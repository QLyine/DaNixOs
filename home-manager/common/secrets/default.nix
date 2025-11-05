{ config, lib, pkgs, ... }:

with lib;

let
  # Path to secrets directory
  secretsDir = "${config.home.homeDirectory}/.dotfiles/secrets";

in {
  options.secrets = {
    enable = mkEnableOption "SOPS secret management with shell integration";

    defaultSecretsFile = mkOption {
      type = types.str;
      default = "user/secrets.d/api-keys.yaml";
      description = "Default secrets file to use";
    };
  };

  config = mkIf config.secrets.enable {
    # Ensure required packages are available
    home.packages = with pkgs; [
      sops
    ];

    # Add shell integration for secrets
    programs.zsh.initContent = mkIf config.programs.zsh.enable ''
      # Helper function to quickly read a secret
      secret() {
        local secret_file="${config.secrets.defaultSecretsFile}"
        local key=""
        local OPTIND=1

        while getopts ":f:s:h" opt; do
          case "$opt" in
            f) secret_file="$OPTARG" ;;
            s) key="$OPTARG" ;;
            h)
              echo "Usage: secret [-f file] -s key"
              echo "       secret [key]"
              echo "       secret [file] [key]"
              echo "Reads a single secret value from a SOPS-encrypted YAML file."
              echo "Defaults: file='${config.secrets.defaultSecretsFile}'"
              return 0
              ;;
            \?) echo "Invalid option: -$OPTARG" ; return 1 ;;
            :) echo "Option -$OPTARG requires an argument" ; return 1 ;;
          esac
        done
        shift $((OPTIND - 1))

        # Backward compatibility for positional args
        if [ -z "$key" ]; then
          if [ "$#" -eq 1 ]; then
            key="$1"
          elif [ "$#" -eq 2 ]; then
            secret_file="$1"
            key="$2"
          fi
        fi

        if [ -z "$key" ]; then
          echo "Usage: secret [-f file] -s key"
          return 1
        fi

        ${pkgs.sops}/bin/sops -d "${secretsDir}/$secret_file" | grep "^$key:" | cut -d':' -f2- | sed 's/^ *//' | tr -d '"'
      }

      # List all available secrets in a file
      list-secrets() {
        local secret_file="${config.secrets.defaultSecretsFile}"
        local OPTIND=1

        while getopts ":f:h" opt; do
          case "$opt" in
            f) secret_file="$OPTARG" ;;
            h)
              echo "Usage: list-secrets [-f file]"
              echo "Lists keys in a SOPS-encrypted YAML file."
              echo "Defaults: file='${config.secrets.defaultSecretsFile}'"
              return 0
              ;;
            \?) echo "Invalid option: -$OPTARG" ; return 1 ;;
            :) echo "Option -$OPTARG requires an argument" ; return 1 ;;
          esac
        done
        shift $((OPTIND - 1))

        # Backward compatibility for positional arg
        if [ "$#" -ge 1 ]; then
          secret_file="$1"
        fi

        ${pkgs.sops}/bin/sops -d "${secretsDir}/$secret_file" | grep -v '^sops:' | grep -v '^#' | grep ':' | cut -d':' -f1 | sed 's/^ *//'
      }

      # Export all secrets from default file
      export-secrets() {
        local secret_file="${config.secrets.defaultSecretsFile}"
        local OPTIND=1

        while getopts ":f:h" opt; do
          case "$opt" in
            f) secret_file="$OPTARG" ;;
            h)
              echo "Usage: export-secrets [-f file]"
              echo "Decrypts a SOPS-encrypted YAML and exports keys as env vars."
              echo "Defaults: file='${config.secrets.defaultSecretsFile}'"
              return 0
              ;;
            \?) echo "Invalid option: -$OPTARG" ; return 1 ;;
            :) echo "Option -$OPTARG requires an argument" ; return 1 ;;
          esac
        done
        shift $((OPTIND - 1))

        # Backward compatibility for positional arg
        if [ "$#" -ge 1 ]; then
          secret_file="$1"
        fi

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

      # List all secret files under user/secrets.d/
      list-secret-files() {
        local dir="${secretsDir}/user/secrets.d"
        local absolute=0
        local OPTIND=1

        while getopts ":d:ha" opt; do
          case "$opt" in
            d) dir="$OPTARG" ;;
            a) absolute=1 ;;
            h)
              echo "Usage: list-secret-files [-d dir] [-a]"
              echo "Lists secret files under a directory (default user/secrets.d)."
              echo "-a: print absolute paths (default prints paths relative to '${secretsDir}')"
              echo "Defaults: dir='${secretsDir}/user/secrets.d'"
              return 0
              ;;
            \?) echo "Invalid option: -$OPTARG" ; return 1 ;;
            :) echo "Option -$OPTARG requires an argument" ; return 1 ;;
          esac
        done
        shift $((OPTIND - 1))

        # Backward compatibility: allow optional positional dir
        if [ "$#" -ge 1 ]; then
          dir="$1"
        fi

        if [ ! -d "$dir" ]; then
          echo "Directory $dir not found"
          return 1
        fi

        # Print sorted list of yaml/yml files
        command -v find >/dev/null 2>&1 || { echo "find command not available"; return 1; }
        find "$dir" -maxdepth 1 -type f \( -name "*.yaml" -o -name "*.yml" \) -print | sort | while IFS= read -r f; do
          if [ "$absolute" -eq 1 ]; then
            echo "$f"
          else
            # print path relative to ${secretsDir}
            echo "''${f#${secretsDir}/}"
          fi
        done
      }
    '';
  };
}