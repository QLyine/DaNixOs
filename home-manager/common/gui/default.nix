{ config, pkgs, system, inputs, ... }:

{

  home.sessionVariables = {
    GDK_SCALE = "1";
    GDK_DPI_SCALE = "1.2";  # Slight boost in scale
  };

  home.packages = with pkgs; [
    ghostty
    inputs.zen-browser.packages."${system}".default
    code-cursor
    capitaine-cursors
    inter
  ];

  home.pointerCursor = {
    name = "capitaine-cursors-white";
    size = 24;
    package = pkgs.capitaine-cursors;

    # Optional but recommended for full support
    x11.enable = false;
    gtk.enable = true;
  };

  # Optional if you're managing GTK through Home Manager
  gtk = {
    enable = true;
    cursorTheme = {
      name = "capitaine-cursors-white";
      package = pkgs.capitaine-cursors;
    };
    font = {
      name = "Inter";
      size = 12;
    };
  };

    # Set fonts globally for applications (useful for Waybar, terminals, etc.)
  xresources.properties = {
    "Xft.dpi" = 110;
    "Xft.antialias" = true;
    "Xft.hinting" = true;
    "Xft.rgba" = "rgb";
    "Xft.hintstyle" = "hintslight";
    "Xft.lcdfilter" = "lcddefault";
  };

  programs.ghostty = {
    enable = true;
    settings = {
      font-family = "JetBrainsMono Nerd Font";
      font-size = 12;
      theme = "OneHalfDark";
    };
    enableZshIntegration = true;
  };
} 