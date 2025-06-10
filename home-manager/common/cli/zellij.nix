{ config, pkgs, ... }:
{

  programs.zellij = {
    enable = true;

    enableZshIntegration = true;

    settings = {
      show_startup_tips = false;
      pane_frames = false;
      copy_on_select = true;
      attach_to_session = true;

      "keybinds clear-defaults=true" = import
        ./configs/zellij-keymaps.nix
        {
          lib = pkgs.lib;
        };
    };
  };


}
