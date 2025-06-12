{ pkgs, ... }:
{
  programs = {
    nushell = {
      enable = true;

      shellAliases = {
        grcm = "git reset --hard HEAD; try { git checkout master } catch { git checkout main }; git fetch --all; git pull; try { git reset --hard origin/master } catch { git reset --hard origin/main }";
        v = "nvim";
        vim = "nvim";
      };

      plugins = with pkgs; [
        nushellPlugins.formats
        nushellPlugins.query
        nushellPlugins.net
      ];

      extraConfig =
        let
          conf = builtins.toJSON
            {
              show_banner = false;
              edit_mode = "vi";

              ls.clickable_links = true;

              cursor_shape = {
                vi_insert = "line";
                vi_normal = "block";

              };

            };
        in
        ''
          $env.config = ${conf};

          def yv [] {
            to yaml | bat --paging=always --language=yaml
          }

        '';

    };

    atuin.enableNushellIntegration = true;
    zoxide.enableNushellIntegration = true;
    starship.enableNushellIntegration = true;
    carapace.enableNushellIntegration = true;
  };

}
