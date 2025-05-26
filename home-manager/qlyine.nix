{ config, pkgs, system, inputs, hostname, ... }:

{
  imports = [
    inputs.nvf.homeManagerModules.default
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
  ];

  home.stateVersion = "24.11";
}

