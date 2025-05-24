{ config, pkgs, system, inputs, ... }:

{
  imports = [
    inputs.nvf.homeManagerModules.default
    ./common/neovim
  ];

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
    code-cursor
    direnv
    zellij
  ];

  programs.bat = {
    enable = true;
    config = {
      map-syntax = [
        "*.jenkinsfile:Groovy"
        "*.props:Java Properties"
      ];
      pager = "less -FR";
      theme = "TwoDark";
    };
  };

  home.stateVersion = "24.11";
}

