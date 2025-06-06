{ pkgs, input, system, ...}:
{
  imports = [
    ./opts.nix
    ./keymaps.nix
    ./plugins
  ];

  programs.nixvim = {
    enable = true;
    luaLoader.enable = true;
    clipboard = pkgs.lib.mkMerge [
      (pkgs.lib.mkIf pkgs.stdenv.isLinux {
        providers.wl-copy.enable = true;
      })
      (pkgs.lib.mkIf pkgs.stdenv.isDarwin {
        providers.pbcopy.enable = true;
      })
    ];
  };
}

