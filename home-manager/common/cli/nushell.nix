{ pkgs, ... }:
{
  programs = {
    nushell = {
      enable = true;

      shellAliases = {
        l = "ls";
        ll = "ls -l";
        grcm = "git reset --hard HEAD; try { git checkout master } catch { git checkout main }; git fetch --all; git pull; try { git reset --hard origin/master } catch { git reset --hard origin/main }";
        v = "nvim";
        vim = "nvim";
        bpy = "bat --paging=always --language=yaml";
        bpj = "bat --paging=always --language=json";
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

          completions = builtins.toJSON
            {
              algorithm = "fuzzy";
            };
        in
        ''
          $env.config = ${conf};
          $env.completions = ${completions};

        '';

    };

    atuin.enableNushellIntegration = true;
    zoxide.enableNushellIntegration = true;
    starship.enableNushellIntegration = true;
    carapace.enableNushellIntegration = true;
  };

}



