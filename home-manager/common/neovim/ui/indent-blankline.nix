{
  programs.nixvim.plugins.indent-blankline = {
    enable = true;
    
    settings = {
      indent = {
        char = "│";
        tab_char = "│";
      };
      whitespace = {
        highlight = ["Whitespace" "NonText"];
        remove_blankline_trail = false;
      };
      scope = {
        enabled = true;
        char = "│";
        show_start = true;
        show_end = true;
        injected_languages = false;
        highlight = ["Function" "Label"];
        priority = 500;
      };
      exclude = {
        filetypes = [
          "help"
          "alpha"
          "dashboard"
          "neo-tree"
          "Trouble"
          "trouble"
          "lazy"
          "mason"
          "notify"
          "toggleterm"
          "lazyterm"
        ];
        buftypes = [
          "terminal"
          "nofile"
          "quickfix"
          "prompt"
        ];
      };
    };
  };
}


