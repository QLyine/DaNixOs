{ pkgs, config, ... }:

{
  imports = [
    ./hyprland.nix
    ./wofi.nix
  ];

  # Example: Essential packages for a Hyprland setup
  home.packages = with pkgs; [
    hyprpaper # for wallpaper
    waybar # for status bar
    wofi # for application launcher
    mako # for notifications
    kitty # a popular terminal emulator
    # thunar # a file manager
    polkit_gnome # for authentication
    grim # for screenshots
    slurp # for selecting a region for screenshots
    swappy # for editing screenshots
    cliphist # for clipboard history
  ];

} 