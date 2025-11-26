{ config, pkgs, pkgsStable, system, inputs, ... }:

{

  home.sessionVariables = {
    GDK_SCALE = "1";
    GDK_DPI_SCALE = "1.2"; # Slight boost in scale
    # Fix dead keys (~ `) for GTK applications on Wayland
    GTK_IM_MODULE = "ibus";
    QT_IM_MODULE = "ibus";
    XMODIFIERS = "@im=ibus";
  };

  home.packages = with pkgs; [
    ghostty
    inputs.zen-browser.packages."${system}".default
    code-cursor
    capitaine-cursors
    inter
    wl-clipboard
    obsidian
    pkgsStable.plex-desktop
    gscreenshot
    pkgs.gnome-screenshot
    ibus  # Input method for dead keys support
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
    };
    enableZshIntegration = true;
  };
}
