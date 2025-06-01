{ config, pkgs, system, inputs, ... }:

{
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
  };
} 