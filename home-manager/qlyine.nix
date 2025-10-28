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
      #sessionVariables = {
      #  SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
      #};
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
  };

  home.packages = with pkgs; [
    bitwarden-cli
    ripgrep
  ];

  # Create symlinks in ~/.factory/bin
  home.file.".factory/bin/rg".source = "${pkgs.ripgrep}/bin/rg";

  services = {
    gnome-keyring = {
      enable = true;
      components = [ "pkcs11" "secrets" "ssh" ];
    };

    ssh-agent.enable = false;
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

  home.stateVersion = "24.11";
}

