{ inputs, config, pkgs, system, ... }:

{
  home.username = "qlyine";
  home.homeDirectory = "/home/qlyine";

  programs = {
    zsh.enable = true;
    git = {
      enable = true;
      userName = "qlyine";
      userEmail = "dffsantos@proton.me";
    };
  };

  home.packages = with pkgs; [
    git
    htop
    ripgrep
    fd
    unzip
    inputs.zen-browser.packages."${system}".default
  ];

  imports = [
    ./common/neovim
  ];

  home.stateVersion = "24.11";
}
