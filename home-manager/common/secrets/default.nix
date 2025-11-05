{ config, lib, pkgs, ... }:

with lib;

let
  # Path to secrets directory
  secretsDir = toString ../.. + "/secrets";

  # Function to read a secret from an encrypted file
  readSecret = secretFile: key: let
    fullSecretPath = "${secretsDir}/${secretFile}";
  in pkgs.writeShellScriptBin "read-${builtins.replaceStrings ["." "/" "-"] ["_" "_" "_"] key}" ''
    export SOPS_AGE_KEY_FILE="${secretsDir}/keys/age-key.txt"

    if [ ! -f "${fullSecretPath}" ]; then
      echo "Error: Secret file ${fullSecretPath} not found" >&2
      exit 1
    fi

    # Decrypt the secret file and extract the key
    ${pkgs.sops}/bin/sops -d "${fullSecretPath}" | grep "^${key}:" | cut -d':' -f2- | sed 's/^ *//' | tr -d '"'
  '';

  # Function to create a script that exports secrets as environment variables
  exportSecrets = secretFile: keys: pkgs.writeShellScriptBin "export-${builtins.replaceStrings ["." "/"] ["_" "_"] secretFile}" ''
    export SOPS_AGE_KEY_FILE="${secretsDir}/keys/age-key.txt"

    ${concatMapStringsSep "\n" (key: ''
      export ${toUpper (builtins.replaceStrings ["-"] ["_"] key)}="$(${pkgs.sops}/bin/sops -d "${secretsDir}/${secretFile}" | grep "^${key}:" | cut -d':' -f2- | sed 's/^ *//' | tr -d '"')"
    '') keys}
  '';

  # Function to create a systemd user service that makes secrets available
  secretService = secretFile: serviceConfig: {
    Unit = {
      Description = "Secret provider for ${secretFile}";
      After = [ "graphical-session-pre.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = toString (pkgs.writeShellScript "secret-service-${builtins.replaceStrings ["." "/"] ["_" "_"] secretFile}" ''
        export SOPS_AGE_KEY_FILE="${secretsDir}/keys/age-key.txt"

        ${concatMapStringsSep "\n" (key: ''
          ${if serviceConfig.environmentVar then ''
            export ${toUpper (builtins.replaceStrings ["-"] ["_"] key)}="$(${pkgs.sops}/bin/sops -d "${secretsDir}/${secretFile}" | grep "^${key}:" | cut -d':' -f2- | sed 's/^ *//' | tr -d '"')"
          '' else ''
            echo "${toUpper (builtins.replaceStrings ["-"] ["_"] key)}=$(${pkgs.sops}/bin/sops -d "${secretsDir}/${secretFile}" | grep "^${key}:" | cut -d':' -f2- | sed 's/^ *//' | tr -d '"')" >> $HOME/.config/secrets/environment
          ''}
        '') serviceConfig.keys}

        ${optionalString serviceConfig.runScript ''
          ${serviceConfig.runScript}
        ''}
      '');
    };

    Install.WantedBy = [ "graphical-session.target" ];
  };

in {
  options.secrets = {
    enable = mkEnableOption "SOPS secret management";

    defaultSecretsFile = mkOption {
      type = types.str;
      default = "user/secrets.d/api-keys.yaml";
      description = "Default secrets file to use";
    };

    environmentFile = mkOption {
      type = types.str;
      default = "$HOME/.config/secrets/environment";
      description = "File where secrets will be exported as environment variables";
    };

    secrets = mkOption {
      type = types.attrsOf (types.submodule ({ name, ... }: {
        options = {
          file = mkOption {
            type = types.str;
            description = "Path to the encrypted secrets file";
          };
          keys = mkOption {
            type = types.listOf types.str;
            default = [];
            description = "List of keys to extract from the secrets file";
          };
          asEnvironment = mkOption {
            type = types.bool;
            default = false;
            description = "Whether to export these secrets as environment variables";
          };
        };
      }));
      default = {};
      description = "Secrets configuration";
    };
  };

  config = mkIf config.secrets.enable {
    # Ensure required packages are available
    home.packages = with pkgs; [
      sops
      yq
    ];

    # Create the secrets directory for environment file
    home.file.".config/secrets/.keep".text = "";

    # Create helper scripts for reading secrets
    home.packages = mapAttrsToList (name: secretConfig:
      readSecret secretConfig.file (head secretConfig.keys)
    ) config.secrets.secrets;

    # Create export scripts for secrets that need to be environment variables
    home.packages = mapAttrsToList (name: secretConfig:
      mkIf secretConfig.asEnvironment (exportSecrets secretConfig.file secretConfig.keys)
    ) config.secrets.secrets;

    # Create systemd user services for secrets
    systemd.user.services = mapAttrs' (name: secretConfig:
      mkIf secretConfig.asEnvironment {
        name = "secrets-${builtins.replaceStrings ["." "/"] ["_" "_"] name}";
        value = secretService secretConfig.file {
          keys = secretConfig.keys;
          environmentVar = true;
        };
      }
    ) config.secrets.secrets;

    # Add shell integration for secrets
    programs.zsh.initExtra = mkIf config.programs.zsh.enable ''
      # Helper function to quickly read a secret
      secret() {
        local secret_file="''${1:-${config.secrets.defaultSecretsFile}}"
        local key="$2"

        if [ -z "$key" ]; then
          echo "Usage: secret [secret_file] key"
          return 1
        fi

        export SOPS_AGE_KEY_FILE="${secretsDir}/keys/age-key.txt"
        ${pkgs.sops}/bin/sops -d "${secretsDir}/$secret_file" | grep "^$key:" | cut -d':' -f2- | sed 's/^ *//' | tr -d '"'
      }

      # List all available secrets in a file
      list-secrets() {
        local secret_file="''${1:-${config.secrets.defaultSecretsFile}}"
        export SOPS_AGE_KEY_FILE="${secretsDir}/keys/age-key.txt"
        ${pkgs.sops}/bin/sops -d "${secretsDir}/$secret_file" | grep -v '^sops:' | grep -v '^#' | grep ':' | cut -d':' -f1 | sed 's/^ *//'
      }

      # Export all secrets from default file
      export-secrets() {
        local secret_file="''${1:-${config.secrets.defaultSecretsFile}}"
        export SOPS_AGE_KEY_FILE="${secretsDir}/keys/age-key.txt"

        if [ -f "${secretsDir}/$secret_file" ]; then
          while IFS=':' read -r key value; do
            # Skip SOPS metadata and comments
            if [[ "$key" =~ ^(sops|#|$) ]]; then
              continue
            fi

            # Clean up the key and value
            key=$(echo "$key" | tr -d ' ')
            value=$(echo "$value" | sed 's/^ *//' | tr -d '"')

            # Export as environment variable
            export "$(echo "$key" | tr '[:lower:]' '[:upper:]' | tr '-' '_')"="$value"
          done < <(${pkgs.sops}/bin/sops -d "${secretsDir}/$secret_file")
        else
          echo "Secret file $secret_file not found"
          return 1
        fi
      }
    '';
  };
}