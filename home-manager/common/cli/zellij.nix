{ config, pkgs, ... }:
{

  programs.zellij = {
    enable = true;

    enableZshIntegration = true;

    settings = {
      default_layout = "compact";
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
