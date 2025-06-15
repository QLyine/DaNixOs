{ pkgs, config, ... }:
let
  homeDir = config.home.homeDirectory;

  nushellLibDirs = ".nushell/scripts";
  nushellScripts = "nushell-scripts";
  files = [
    "nix-utils.nu"
    "git.nu"
  ];
  # Build home.file attributes
  fileAttrs = builtins.listToAttrs (map
    (filename: {
      name = "${nushellLibDirs}/${filename}";
      value = {
        source = ./${nushellScripts}/${filename};
      };
    })
    files);
  sourceCommands = pkgs.lib.strings.concatMapStringsSep "\n" (file: ''source "${homeDir}/${nushellLibDirs}/${file}"'') files;
in
{
  programs = {
    nushell = {
      enable = true;

      shellAliases = {
        l = "ls";
        ll = "ls -l";
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
          libDirs = builtins.toJSON [
            "${homeDir}/${nushellLibDirs}"
          ];
        in
        ''
          $env.config = ${conf};
          $env.completions = ${completions};

          $env.NU_LIB_DIRS = ${libDirs};

          ${sourceCommands}
        '';

    };

    atuin.enableNushellIntegration = true;
    zoxide.enableNushellIntegration = true;
    starship.enableNushellIntegration = true;
    carapace.enableNushellIntegration = true;
  };

  home.file = fileAttrs;

}

