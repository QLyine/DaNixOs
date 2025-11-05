{ pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;

    plugins = with pkgs.hyprlandPlugins; [
      hyprexpo
    ];

    xwayland.enable = true;
    settings = {
      monitor = [
        "DP-5,3440x1440@59.973,0x0,1" # Primary, at 0x0
        "HDMI-A-2,3840x2160@60,0x-2160,1" # Above DP-5
        ",preferred,auto,1" # Fallback for other monitors
      ];
      exec-once = [
        "waybar"
        "hyprpaper"
        # "eval $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)"  # Commented out - using system service
      ];
      input = {
        kb_layout = "pt";
      };

      general = {
        gaps_in = 4;
        gaps_out = 8;

        border_size = 2;

        resize_on_border = true;

        # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = false;

        layout = "dwindle";
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
        smart_resizing = true;
      };

      master = {
        new_status = "master";
      };

      "$MOD" = "SUPER";

      bind = let
        defaultApp = type: "${pkgs.gtk3}/bin/gtk-launch $(${pkgs.xdg-utils}/bin/xdg-mime query default ${type})"; 
        browser = defaultApp "x-scheme-handler/https";
      in
      [
        # Applications
        "$MOD, RETURN, exec, ghostty"
        "$MOD, Q, killactive,"
        "$MOD, D, exec, wofi"
        "$MOD SHIFT, D, exec, wofi --show drun"
        "$MOD, B, exec, ${browser}"

        # Compositor Commands
        "$MOD, F, fullscreen"
        "$MOD, P, pseudo"
        "$MOD, S, togglesplit"
        "$MOD, Space, togglefloating"
        "$MOD, C, centerwindow"
        "$MOD SHIFT, P, pin"


        # Expo
        "$MOD, Tab, hyprexpo:expo, toggle"

        # Vim-like window focus
        "$MOD, H, movefocus, l"
        "$MOD, J, movefocus, d"
        "$MOD, K, movefocus, u"
        "$MOD, L, movefocus, r"

        # Vim-like window movement
        "$MOD SHIFT, H, movewindow, l"
        "$MOD SHIFT, J, movewindow, d"
        "$MOD SHIFT, K, movewindow, u"
        "$MOD SHIFT, L, movewindow, r"

        # Vim-like window resizing
        "$MOD CONTROL, H, resizeactive, -20 0"
        "$MOD CONTROL, J, resizeactive, 0 20"
        "$MOD CONTROL, K, resizeactive, 0 -20"
        "$MOD CONTROL, L, resizeactive, 20 0"

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
        "$MOD SHIFT, 1, workspace, 9"
        "$MOD SHIFT, 2, workspace, 10"
        "$MOD SHIFT, 3, workspace, 11"
        "$MOD SHIFT, 4, workspace, 12"
        "$MOD SHIFT, 5, workspace, 13"
        "$MOD SHIFT, 6, workspace, 14"
        "$MOD SHIFT, 7, workspace, 15"
        "$MOD SHIFT, 8, workspace, 16"

        # Move active window to a workspace 1-8
        "$MOD ALT, 1, movetoworkspace, 1"
        "$MOD ALT, 2, movetoworkspace, 2"
        "$MOD ALT, 3, movetoworkspace, 3"
        "$MOD ALT, 4, movetoworkspace, 4"
        "$MOD ALT, 5, movetoworkspace, 5"
        "$MOD ALT, 6, movetoworkspace, 6"
        "$MOD ALT, 7, movetoworkspace, 7"
        "$MOD ALT, 8, movetoworkspace, 8"

        # Move active window to workspaces 9-16
        "$MOD ALT SHIFT, 1, movetoworkspace, 9"
        "$MOD ALT SHIFT, 2, movetoworkspace, 10"
        "$MOD ALT SHIFT, 3, movetoworkspace, 11"
        "$MOD ALT SHIFT, 4, movetoworkspace, 12"
        "$MOD ALT SHIFT, 5, movetoworkspace, 13"
        "$MOD ALT SHIFT, 6, movetoworkspace, 14"
        "$MOD ALT SHIFT, 7, movetoworkspace, 15"
        "$MOD ALT SHIFT, 8, movetoworkspace, 16"
      ];

      env = [
        "HYPRCURSOR_THEME,MyCursor"
        "HYPRCURSOR_SIZE,24"
      ];

      decoration = {
        rounding = 10;

        blur = {
          size = 8;
          passes = 2;
        };

        shadow = {
          enabled = true;
          range = 15;
          render_power = 3;
          offset = "0, 0";
        };

        active_opacity = 0.9;
        inactive_opacity = 0.8;
        fullscreen_opacity = 0.9;
      };

      layerrule = [
        "blur, logout_dialog"
      ];

      animations = {
        enabled = true;

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 2, myBezier"
          "windowsOut, 1, 2, default, popin 80%"
          "border, 1, 3, default"
          "fade, 1, 2, default"
          "workspaces, 1, 1, default"
        ];
      };

      workspace = [
        "1, monitor:DP-5, name:1:main"
        "2, monitor:DP-5, name:2:web"
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
        "workspace 2, class:^(zen-beta)$"
        "workspace 3, class:^(Cursor)$"
        "workspace special:scratchpad silent, class:^(ghostty)$, title:^(scratchpad)$"
      ];

      plugin = {
        hyprexpo = {
          columns = 3;
          gap_size = 4;
          bg_col = "rgb(0,0,0)";
          enable_gesture = true;
          gesture_fingers = 3;
          gesture_distance = 300;
          gesture_positive = false;
        };
      };
    };
  };

  # Enable xdg-desktop-portal-hyprland for screen sharing, etc.
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*"; # Or "hyprland" if you only want it for hyprland
  };
} 