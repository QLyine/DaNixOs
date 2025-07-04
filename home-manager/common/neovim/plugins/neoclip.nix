{
  programs.nixvim.plugins.neoclip = {
    enable = true;
    
    settings = {
      history = 1000;
      enable_persistent_history = false;
      length_limit = 1048576;
      continuous_sync = false;
      filter = null;
      preview = true;
      prompt = null;
      default_register = "\"";
      default_register_macros = "q";
      enable_macro_history = true;
      content_spec_column = false;
      disable_keycodes_parsing = false;
      on_select = {
        move_to_front = false;
        close_telescope = true;
      };
      on_paste = {
        set_reg = false;
        move_to_front = false;
        close_telescope = true;
      };
      on_replay = {
        set_reg = false;
        move_to_front = false;
        close_telescope = true;
      };
      on_custom_action = {
        close_telescope = true;
      };
      keys = {
        telescope = {
          i = {
            select = "<cr>";
            paste = "<c-y>";
            paste_behind = "<c-k>";
            replay = "<c-q>";
            delete = "<c-d>";
            edit = "<c-e>";
            custom = {};
          };
          n = {
            select = "<cr>";
            paste = "p";
            paste_behind = "P";
            replay = "q";
            delete = "d";
            edit = "e";
            custom = {};
          };
        };
        fzf = {
          select = "default";
          paste = "ctrl-p";
          paste_behind = "ctrl-k";
          custom = {};
        };
      };
    };
  };
}


