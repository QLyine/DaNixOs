{ pkgs, ... }:
{
  programs = {
    nushell = {
      enable = true;

      plugins = with pkgs; [
        nushellPlugins.formats
        nushellPlugins.query
        nushellPlugins.net
      ];
    };

    atuin.enableNushellIntegration = true;
    zoxide.enableNushellIntegration = true;
    starship.enableNushellIntegration = true;
    carapace.enableNushellIntegration = true;
  };

}
