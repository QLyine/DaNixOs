{ config, pkgs, system, inputs, hostname, ... }:

{
  imports = [
    inputs.nvf.homeManagerModules.default
    ./common/neovim
  ] ++ (if hostname == "obelix" then [ ./hyprland.nix ] else [ ]);

  home.username = "qlyine";
  home.homeDirectory = "/home/qlyine";

  programs = {
    zellij = {
      enable = true;
      enableZshIntegration = true;
    };
    eza = {
      enable = true;
      icons = "auto";
      enableZshIntegration = true;
    };
    starship = {
      enable = true;
      enableZshIntegration = true;
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [
        "--no-cmd"
      ];
    };
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        "ls" = "eza";
        "ll" = "eza -l";
        "l" = "eza -l";
        "la" = "eza -la";
        "tree" = "eza --tree";
      };
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
    git
    htop
    ripgrep
    fd
    unzip
    inputs.zen-browser.packages."${system}".default
    code-cursor
    direnv
    uv
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

