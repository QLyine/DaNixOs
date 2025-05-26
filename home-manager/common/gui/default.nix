{ config, pkgs, system, inputs, ... }:

{
  home.packages = with pkgs; [
    ghostty
    inputs.zen-browser.packages."${system}".default
    code-cursor
  ];
} 