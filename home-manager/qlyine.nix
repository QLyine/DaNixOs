{ config, pkgs, system, inputs, hostname, lib, ... }:

{
  imports = [
    inputs.factory-cli-nix.homeManagerModules.default
    { services.factory-cli.enable = true; }
    ./common/neovim
    ./common/cli
  ] ++ (if hostname == "obelix" then [
    ./hyprland
    ./common/gui
  ] else [ ]);

  home.username = "qlyine";
  home.homeDirectory = "/home/qlyine";

  programs = {
    zsh = {
      enable = true;
    };
    zsh.oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "sudo"
      ];
      theme = "robbyrussell";
    };
    git = {
      enable = true;
      userName = "qlyine";
      userEmail = "dffsantos@proton.me";
    };
    password-store = {
      enable = true;
    };
    gpg = {
      enable = true;
    };
    keychain = {
      enable = true;
      agents = [ "gpg" "ssh" ];
      enableZshIntegration = true;
      enableBashIntegration = true;
      keys = [ "id_ed25519" ];
      extraFlags = [ "--quiet" ];
    };
  };

  home.packages = with pkgs; [
    bitwarden-cli
    ripgrep
  ];

  # Create symlinks in ~/.factory/bin
  home.file.".factory/bin/rg".source = "${pkgs.ripgrep}/bin/rg";

  services = {
  };

  services.podman = lib.mkIf (config.virtualisation.podman.enable or false) {
    settings.policy = {
      default = [{ type = "insecureAcceptAnything"; }];
      transports = {
        "docker-daemon" = {
          "" = [{ type = "insecureAcceptAnything"; }];
        };
      };
    };
  };

  # SOPS-nix configuration
  sops = {
    defaultSopsFile = ../secrets/user/secrets.d/api-keys.yaml;
    defaultSopsFormat = "yaml";
    age = {
      keyFile = "/home/qlyine/.config/sops/age/keys.txt";
      generateKey = false;
    };

    # Define secrets as environment variables
    secrets = {
      github_token = {};
      openai_api_key = {};
      anthropic_api_key = {};
      aws_access_key_id = {};
      aws_secret_access_key = {};
      docker_hub_token = {};
      some_service_api_key = {};
    };
  };

  home.stateVersion = "24.11";
}

