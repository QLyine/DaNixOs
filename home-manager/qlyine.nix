{ config, pkgs, system, inputs, hostname, lib, ... }:

let
  isDesktop = hostname == "obelix";
in
{
  # ==========================================================================
  # Home Manager Core Settings
  # ==========================================================================

  home = {
    username = "qlyine";
    homeDirectory = "/home/qlyine";
    stateVersion = "24.11";
    enableNixpkgsReleaseCheck = false;

    packages = with pkgs; [
      bitwarden-cli
      ripgrep
    ];

    # Factory CLI requires ripgrep symlink
    file.".factory/bin/rg".source = "${pkgs.ripgrep}/bin/rg";
  };

  # ==========================================================================
  # Module Imports
  # ==========================================================================

  imports = [
    inputs.factory-cli-nix.homeManagerModules.default
    { services.factory-cli.enable = true; }
    ./common/neovim
    ./common/cli
  ] ++ lib.optionals isDesktop [
    ./hyprland
    ./common/gui
  ];

  # ==========================================================================
  # Programs Configuration
  # ==========================================================================

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" ];
      theme = "robbyrussell";
    };
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "qlyine";
        email = "dffsantos@proton.me";
      };
    };
  };

  programs.password-store.enable = true;
  programs.gpg.enable = true;

  programs.keychain = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    keys = [ "id_ed25519" ];
    extraFlags = [ "--quiet" ];
  };

  # ==========================================================================
  # Services Configuration
  # ==========================================================================

  services.podman = lib.mkIf (config.virtualisation.podman.enable or false) {
    settings.policy = {
      default = [{ type = "insecureAcceptAnything"; }];
      transports."docker-daemon"."" = [{ type = "insecureAcceptAnything"; }];
    };
  };

  # ==========================================================================
  # Secrets Management (SOPS)
  # ==========================================================================

  sops = {
    defaultSopsFile = ../secrets/user/secrets.d/api-keys.yaml;
    defaultSopsFormat = "yaml";
    age = {
      keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
      generateKey = false;
    };
    secrets = { };
  };
}
