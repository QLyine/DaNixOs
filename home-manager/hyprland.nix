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

  wayland.windowManager.hyprland.settings = {
    monitor = [
      "DP-5,3440x1440@59.973,0x0,1" # Primary, at 0x0
      "HDMI-A-2,3840x2160@60,0x-2160,1" # Above DP-5
      ",preferred,auto,1" # Fallback for other monitors
    ];
    exec-once = [
      "waybar"
      "hyprpaper"
    ];
    input = {
      kb_layout = "pt";
    };

    "$MOD" = "SUPER";

    bind = [
      "$MOD, RETURN, exec, kitty"
      "$MOD, Q, killactive,"
      "$MOD, D, exec, wofi --show run"
      "$MOD, SHIFT, D, exec, wofi --show drun"

      # Vim-like window focus
      "$MOD, H, movefocus, l"
      "$MOD, J, movefocus, d"
      "$MOD, K, movefocus, u"
      "$MOD, L, movefocus, r"

      # Vim-like window movement
      "$MOD, SHIFT, H, movewindow, l"
      "$MOD, SHIFT, J, movewindow, d"
      "$MOD, SHIFT, K, movewindow, u"
      "$MOD, SHIFT, L, movewindow, r"

      # Vim-like window resizing
      "$MOD, CONTROL, H, resizeactive, -20 0"
      "$MOD, CONTROL, J, resizeactive, 0 20"
      "$MOD, CONTROL, K, resizeactive, 0 -20"
      "$MOD, CONTROL, L, resizeactive, 20 0"

      # Switch workspaces 1-8
      "$MOD, 1, workspace, 1"
      "$MOD, 2, workspace, 2"
      "$MOD, 3, workspace, 3"
      "$MOD, 4, workspace, 4"
      "$MOD, 5, workspace, 5"
      "$MOD, 6, workspace, 6"
      "$MOD, 7, workspace, 7"
      "$MOD, 8, workspace, 8"

      # Switch to workspaces 9-16
      "$MOD, SHIFT, 1, workspace, 9"
      "$MOD, SHIFT, 2, workspace, 10"
      "$MOD, SHIFT, 3, workspace, 11"
      "$MOD, SHIFT, 4, workspace, 12"
      "$MOD, SHIFT, 5, workspace, 13"
      "$MOD, SHIFT, 6, workspace, 14"
      "$MOD, SHIFT, 7, workspace, 15"
      "$MOD, SHIFT, 8, workspace, 16"

      # Move active window to a workspace 1-8
      "$MOD, ALT, 1, movetoworkspace, 1"
      "$MOD, ALT, 2, movetoworkspace, 2"
      "$MOD, ALT, 3, movetoworkspace, 3"
      "$MOD, ALT, 4, movetoworkspace, 4"
      "$MOD, ALT, 5, movetoworkspace, 5"
      "$MOD, ALT, 6, movetoworkspace, 6"
      "$MOD, ALT, 7, movetoworkspace, 7"
      "$MOD, ALT, 8, movetoworkspace, 8"

      # Move active window to workspaces 9-16
      "$MOD, ALT, SHIFT, 1, movetoworkspace, 9"
      "$MOD, ALT, SHIFT, 2, movetoworkspace, 10"
      "$MOD, ALT, SHIFT, 3, movetoworkspace, 11"
      "$MOD, ALT, SHIFT, 4, movetoworkspace, 12"
      "$MOD, ALT, SHIFT, 5, movetoworkspace, 13"
      "$MOD, ALT, SHIFT, 6, movetoworkspace, 14"
      "$MOD, ALT, SHIFT, 7, movetoworkspace, 15"
      "$MOD, ALT, SHIFT, 8, movetoworkspace, 16"
    ];

    workspace = [
      "1, monitor:DP-5, name:1:main"
      "2, monitor:DP-5, name:2:Web"
      "3, monitor:DP-5, name:3:code"
      "4, monitor:DP-5"
      "5, monitor:DP-5"
      "6, monitor:DP-5"
      "7, monitor:DP-5"
      "8, monitor:DP-5"
      "9, monitor:HDMI-A-2"
      "10, monitor:HDMI-A-2"
      "11, monitor:HDMI-A-2"
      "12, monitor:HDMI-A-2"
      "13, monitor:HDMI-A-2"
      "14, monitor:HDMI-A-2"
      "15, monitor:HDMI-A-2"
      "16, monitor:HDMI-A-2"
    ];

    windowrulev2 = [
      "workspace 2:Web, class:^(zen-browser)$"
      "workspace 2:Web, title:^(Zen Browser)$" # Fallback if class doesn't match
    ];
  };

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

  programs.wofi = {
    enable = true;
    style = ''
      @define-color base00 #282828;
      @define-color base01 #3c3836;
      @define-color base02 #504945;
      @define-color base03 #665c54;
      @define-color base04 #bdae93;
      @define-color base05 #d5c4a1; /* Adjusted for slightly warmer text */
      @define-color base08 #fb4934; /* Red */
      @define-color base09 #fe8019; /* Orange */
      @define-color base0A #fabd2f; /* Yellow */
      @define-color base0B #b8bb26; /* Green */
      @define-color base0D #83a598; /* Aqua */
      @define-color base0E #d3869b; /* Purple */

      window {
        background-color: @base00;
        border: 2px solid @base03;
        border-radius: 10px;
        font-family: "JetBrainsMono Nerd Font"; /* You might need to adjust this font */
        font-size: 16px;
        opacity: 0.95;
      }

      #input {
        background-color: @base01;
        color: @base0A; /* Yellow for input text */
        padding: 10px;
        margin: 5px;
        border-radius: 5px;
        border: none;
      }

      #input image {
        display: none;
      }

      #inner-box {
        margin: 5px;
        spacing: 10px;
      }

      #outer-box {
        padding: 10px;
      }

      #scroll {
        margin-top: 5px;
      }

      #entry {
        padding: 8px;
        border-radius: 5px;
      }

      #entry:selected {
        background-color: @base02;
        color: @base09; /* Orange for selected text */
        outline: none;
      }

      #text {
        color: @base05; /* Warm off-white for text */
      }

      #text:selected {
        color: @base09; /* Orange for selected text */
      }
    '';
    settings = {
        show = "drun"; /* Show applications */
        allow_images = true;
        allow_markup = true;
        image_size = 32;
        key_expand = "Tab";
        key_scroll_down = "Ctrl-j";
        key_scroll_up = "Ctrl-k";
    };
  };
} 