{ pkgs, ... }:

{
  home.packages = with pkgs; [
    atuin
  ];

  programs.atuin = {
    enable = true;

    settings = {
      search_mode = "fuzzy";
    };

    daemon.enable = true;

    enableZshIntegration = true;
  };
}
