{ pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        "layer" = "top";
        "position" = "top";
        "modules-left" = ["hyprland/workspaces"];
        "modules-center" = [];
        "modules-right" = ["tray" "clock"];
        "clock" = {
        "format" = "{:%a %d %b %H:%M}";
        "tooltip-format" = "{:%A, %B %d, %Y | %H:%M:%S}";
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
      * {
          font-family: "JetBrainsMono Nerd Font", monospace;
          font-size: 14px;
          min-height: 0;
      }

      window#waybar {
          background: rgba(250, 250, 250, 0.9);
          color: #333;
          border-bottom: 1px solid #d0d0d0;
      }

      #workspaces button {
          padding: 0 6px;
          margin: 0 2px;
          border-radius: 5px;
          background: transparent;
          color: #666;
      }

      #workspaces button.active {
          background: #aed9e0; /* pastel blue */
          color: #2e2e2e;
      }

      #clock,
      #tray {
          padding: 0 10px;
          margin: 0 5px;
          border-radius: 5px;
          background-color: #f4e1d2; /* pastel peach */
          color: #2d2d2d;
      }

      #tray {
          background-color: #e3e0f3; /* pastel purple */
      }
    '';
  };
}