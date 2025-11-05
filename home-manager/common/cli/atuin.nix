{ pkgs, ... }:

{
  home.packages = with pkgs; [
    atuin
  ];

  programs.atuin = {
    enable = true;

    flags = [
      "--disable-up-arrow"
    ];

    settings = {
      search_mode = "fuzzy";
      keymap_mode = "vim-insert";
    };

    daemon.enable = false;

    enableZshIntegration = true;
  };
}
