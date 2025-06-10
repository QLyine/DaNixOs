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
    };

    daemon.enable = true;

    enableZshIntegration = true;
  };
}
