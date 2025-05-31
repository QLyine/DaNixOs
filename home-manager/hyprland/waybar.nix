{ pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    settings = {
      "top_bar" = {
        "name" = "top_bar";
        "layer" = "top";
        "position" = "top";
        "modules-left" = ["hyprland/workspaces"];
        "modules-center" = [];
        "modules-right" = ["tray" "clock#time" "custom/separator" "clock#week" "custom/separator_dot" "clock#month" "custom/separator" "clock#calendar"];

        "clock#time" = {
          "format" = "{:%I:%M %p %Ez}";
        };

        "custom/separator" = {
            "format" = "|";
            "tooltip" = false;
        };

        "custom/separator_dot" = {
            "format" = "•";
            "tooltip" = false;
        };

        "clock#week" = {
            "format" = "{:%a}";
        };

        "clock#month" = {
            "format" = "{:%h}";
        };

        "clock#calendar" = {
            "format" = "{:%F}";
            "tooltip-format" = "<tt><small>{calendar}</small></tt>";
            "actions" = {
                "on-click-right" = "mode";
            };
            "calendar" = {
                "mode"          = "month";
                "mode-mon-col"  = 3;
                "weeks-pos"     = "right";
                "on-scroll"     = 1;
                "on-click-right" = "mode";
                "format" = {
                    "months" = "<span color='#f4dbd6'><b>{}</b></span>";
                    "days" = "<span color='#cad3f5'><b>{}</b></span>";
                    "weeks" = "<span color='#c6a0f6'><b>W{}</b></span>";
                    "weekdays" = "<span color='#a6da95'><b>{}</b></span>";
                    "today" = "<span color='#8bd5ca'><b><u>{}</u></b></span>";
                };
            };
        };

        "tray" = {
          "icon-size" = 18;
          "spacing" = 10;
        };

        "hyprland/workspaces" = {
          "format" = "{name}";
          "on-click" = "activate";
          "all-outputs" = true;
        };
      };
    };
    style = ''
      @import "macchiato.css";

      * {
        border: none;
      }

      window.bottom_bar#waybar {
        background-color: alpha(@base, 0.7);
        border-top: solid alpha(@surface1, 0.7) 2;
      }

      window.top_bar#waybar {
        background-color: alpha(@base, 0.7);
        border-bottom: solid alpha(@surface1, 0.7) 2;
      }

      window.left_bar#waybar {
        background-color: alpha(@base, 0.7);
        border-top: solid alpha(@surface1, 0.7) 2;
        border-right: solid alpha(@surface1, 0.7) 2;
        border-bottom: solid alpha(@surface1, 0.7) 2;
        border-radius: 0 15 15 0;
      }

      window.bottom_bar .modules-center {
        background-color: alpha(@surface1, 0.7);
        color: @green;
        border-radius: 15;
        padding-left: 20;
        padding-right: 20;
        margin-top: 5;
        margin-bottom: 5;
      }

      window.bottom_bar .modules-left {
        background-color: alpha(@surface1, 0.7);
        border-radius: 0 15 15 0;
        padding-left: 20;
        padding-right: 20;
        margin-top: 5;
        margin-bottom: 5;
      }

      window.bottom_bar .modules-right {
        background-color: alpha(@surface1, 0.7);
        border-radius: 15 0 0 15;
        padding-left: 20;
        padding-right: 20;
        margin-top: 5;
        margin-bottom: 5;
      }

      #user {
        padding-left: 10;
      }

      #language {
        padding-left: 15;
      }

      #keyboard-state label.locked {
        color: @yellow;
      }

      #keyboard-state label {
        color: @subtext0;
      }

      #workspaces {
        margin-left: 10;
      }

      #workspaces button {
        color: @text;
        font-size: 1.25rem;
      }

      #workspaces button.empty {
        color: @overlay0;
      }

      #workspaces button.active {
        color: @peach;
      }

      #submap {
        background-color: alpha(@surface1, 0.7);
        border-radius: 15;
        padding-left: 15;
        padding-right: 15;
        margin-left: 20;
        margin-right: 20;
        margin-top: 5;
        margin-bottom: 5;
      }

      window.top_bar .modules-center {
        font-weight: bold;
        background-color: alpha(@surface1, 0.7);
        color: @peach;
        border-radius: 15;
        padding-left: 20;
        padding-right: 20;
        margin-top: 5;
        margin-bottom: 5;
      }

      #custom-separator {
        color: @green;
      }

      #custom-separator_dot {
        color: @green;
      }

      #clock.time {
        color: @flamingo;
      }

      #clock.week {
        color: @sapphire;
      }

      #clock.month {
        color: @sapphire;
      }

      #clock.calendar {
        color: @mauve;
      }

      #bluetooth {
        background-color: alpha(@surface1, 0.7);
        border-radius: 15;
        padding-left: 15;
        padding-right: 15;
        margin-top: 5;
        margin-bottom: 5;
      }

      #bluetooth.disabled {
        background-color: alpha(@surface0, 0.7);
        color: @subtext0;
      }

      #bluetooth.on {
        color: @blue;
      }

      #bluetooth.connected {
        color: @sapphire;
      }

      #network {
        background-color: alpha(@surface1, 0.7);
        border-radius: 15;
        padding-left: 15;
        padding-right: 15;
        margin-left: 2;
        margin-right: 2;
        margin-top: 5;
        margin-bottom: 5;
      }

      #network.disabled {
        background-color: alpha(@surface0, 0.7);
        color: @subtext0;
      }

      #network.disconnected {
        color: @red;
      }

      #network.wifi {
        color: @teal;
      }

      #idle_inhibitor {
        margin-right: 2;
      }

      #idle_inhibitor.deactivated {
        color: @subtext0;
      }

      #custom-dunst.off {
        color: @subtext0;
      }

      #custom-airplane_mode {
        margin-right: 2;
      }

      #custom-airplane_mode.off {
        color: @subtext0;
      }

      #custom-night_mode {
        margin-right: 2;
      }

      #custom-night_mode.off {
        color: @subtext0;
      }

      #custom-dunst {
        margin-right: 2;
      }

      #custom-media.Paused {
        color: @subtext0;
      }

      #custom-webcam {
        color: @maroon;
        margin-right: 3;
      }

      #privacy-item.screenshare {
        color: @peach;
        margin-right: 5;
      }

      #privacy-item.audio-in {
        color: @pink;
        margin-right: 4;
      }

      #custom-recording {
        color: @red;
        margin-right: 4;
      }

      #custom-geo {
        color: @yellow;
        margin-right: 4;
      }

      #custom-logout_menu {
        color: @red;
        background-color: alpha(@surface1, 0.7);
        border-radius: 15 0 0 15;
        padding-left: 10;
        padding-right: 5;
        margin-top: 5;
        margin-bottom: 5;
      }

      window.left_bar .modules-center {
        background-color: alpha(@surface1, 0.7);
        border-radius: 0 15 15 0;
        margin-right: 5;
        margin-top: 15;
        margin-bottom: 15;
        padding-top: 5;
        padding-bottom: 5;
      }

      #taskbar {
        margin-top: 10;
        margin-right: 10;
        margin-left: 10;
      }

      #taskbar button.active {
        background-color: alpha(@surface1, 0.7);
        border-radius: 10;
      }

      #tray {
        margin-bottom: 10;
        margin-right: 10;
        margin-left: 10;
      }

      #tray>.needs-attention {
        background-color: alpha(@maroon, 0.7);
        border-radius: 10;
      }

      #cpu {
        color: @sapphire;
      }

      #cpu.low {
        color: @rosewater;
      }

      #cpu.lower-medium {
        color: @yellow;
      }

      #cpu.medium {
        color: @peach;
      }

      #cpu.upper-medium {
        color: @maroon;
      }

      #cpu.high {
        color: @red;
      }

      #memory {
        color: @sapphire;
      }

      #memory.low {
        color: @rosewater;
      }

      #memory.lower-medium {
        color: @yellow;
      }

      #memory.medium {
        color: @peach;
      }

      #memory.upper-medium {
        color: @maroon;
      }

      #memory.high {
        color: @red;
      }

      #disk {
        color: @sapphire;
      }

      #disk.low {
        color: @rosewater;
      }

      #disk.lower-medium {
        color: @yellow;
      }

      #disk.medium {
        color: @peach;
      }

      #disk.upper-medium {
        color: @maroon;
      }

      #disk.high {
        color: @red;
      }

      #temperature {
        color: @green;
      }

      #temperature.critical {
        color: @red;
      }

      #battery {
        color: @teal;
      }

      #battery.low {
        color: @red;
      }

      #battery.lower-medium {
        color: @maroon;
      }

      #battery.medium {
        color: @peach;
      }

      #battery.upper-medium {
        color: @flamingo;
      }

      #battery.high {
        color: @rosewater;
      }

      #backlight {
        color: @overlay0;
      }

      #backlight.low {
        color: @overlay1;
      }

      #backlight.lower-medium {
        color: @overlay2;
      }

      #backlight.medium {
        color: @subtext0;
      }

      #backlight.upper-medium {
        color: @subtext1;
      }

      #backlight.high {
        color: @text;
      }

      #pulseaudio.bluetooth {
        color: @sapphire;
      }

      #pulseaudio.muted {
        color: @surface2;
      }

      #pulseaudio {
        color: @text;
      }

      #pulseaudio.low {
        color: @overlay0;
      }

      #pulseaudio.lower-medium {
        color: @overlay1;
      }

      #pulseaudio.medium {
        color: @overlay2;
      }

      #pulseaudio.upper-medium {
        color: @subtext0;
      }

      #pulseaudio.high {
        color: @subtext1;
      }

      #systemd-failed-units {
        color: @red;
      }
    '';
  };

  home.file.".config/waybar/macchiato.css" = {
    source = ./macchiato.css;
    executable = false; # Ensure it's not marked as executable
  };
}