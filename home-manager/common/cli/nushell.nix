{ pkgs, config, nuScripts, ... }:
let
  homeDir = config.home.homeDirectory;

  nushellLibDirs = ".nushell/scripts";
  nushellScripts = "nushell-scripts";
  files = [
    "nix-utils.nu"
    "git.nu"
    "docker.nu"
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

  # Path where remote completion scripts will be copied.
  #completionsTargetDir = ".config/nushell/custom-completions";
  #modulesTargetDir = ".config/nushell/modules";


  # Whitelist of completion scripts to source.
  # Add the full path from the root of the completions directory.
  completionFilesToSource = [
    "git/git-completions.nu"
    "docker/docker-completions.nu"
    "nix/nix-completions.nu"
    "zellij/zellij-completions.nu"
    "uv/uv-completions.nu"
    "bat/bat-completions.nu"
    "curl/curl-completions.nu"
    "cargo/cargo-completions.nu"
    "eza/eza-completions.nu"
    "less/less-completions.nu"
    "make/make-completions.nu"
    "npm/npm-completions.nu"
    "ssh/ssh-completions.nu"
    "tar/tar-completions.nu"
    "auto-generate/completions/minikube.nu"
    # Add other working completion files here
  ];

  modulesToSource = [
    "argx"
    #"kubernetes"
  ];

  completionSourceCommands = pkgs.lib.strings.concatMapStringsSep "\n"
    (file: ''source "${nuScripts}/custom-completions/${file}"'')
    completionFilesToSource;

  moduleSourceCommands = pkgs.lib.strings.concatMapStringsSep "\n"
    (module: ''source "${nuScripts}/modules/${module}/mod.nu"'' )
    modulesToSource;

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

          $env.VISUAL = 'nvim';

          ${sourceCommands}
          ${completionSourceCommands}
          ${moduleSourceCommands}
        '';

    };

    atuin.enableNushellIntegration = true;
    zoxide.enableNushellIntegration = true;
    starship.enableNushellIntegration = true;
    carapace.enableNushellIntegration = false;
  };

  home.file = fileAttrs // {
    # Recursively copy the completion scripts from the Nix store to home.
    #"${completionsTargetDir}" = {
    #  source = nuCustomCompletions;
    #  recursive = true;
    #};
  };

}

