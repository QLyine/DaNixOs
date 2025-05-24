{ pkgs, config, ... }:

{
  # Enable Hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;

    xwayland.enable = true;
  };

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

  # Example: Basic Hyprland configuration (put your actual config here or source it)
  xdg.configFile."hypr/hyprland.conf".text = ''
  monitor=,preferred,auto,1
  exec-once = waybar & hyprpaper
  input {
    kb_layout = "pt"
  }
  '';

  # Enable xdg-desktop-portal-hyprland for screen sharing, etc.
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
    config.common.default = "*"; # Or "hyprland" if you only want it for hyprland
  };

  # If you want to use a display manager like greetd:
  # programs.greetd = {
  #   enable = true;
  #   settings = {
  #     default_session = {
  #       command = "${pkgs.hyprland}/bin/Hyprland";
  #     };
  #   };
  # };
  # services.greetd.enable = true; # This would typically go in NixOS configuration
} 