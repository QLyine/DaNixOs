{
  programs.nixvim = {
    # Colorscheme
    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavour = "mocha";
        background = {
          light = "latte";
          dark = "mocha";
        };
        transparent_background = false;
        show_end_of_buffer = false;
        term_colors = false;
        dim_inactive = {
          enabled = false;
          shade = "dark";
          percentage = 0.15;
        };
        no_italic = false;
        no_bold = false;
        no_underline = false;
        styles = {
          comments = ["italic"];
          conditionals = ["italic"];
          loops = [];
          functions = [];
          keywords = [];
          strings = [];
          variables = [];
          numbers = [];
          booleans = [];
          properties = [];
          types = [];
          operators = [];
        };
        color_overrides = {};
        custom_highlights = {};
        integrations = {
          cmp = true;
          gitsigns = true;
          nvimtree = true;
          treesitter = true;
          notify = false;
          mini = {
            enabled = true;
            indentscope_color = "";
          };
          telescope = {
            enabled = true;
            style = "nvchad";
          };
          lsp_trouble = true;
          which_key = true;
        };
      };
    };
    
    # Highlight groups
    highlight = {
      Comment = {
        fg = "#7C7C7C";
        italic = true;
      };
      LineNr = {
        fg = "#5C6370";
      };
      CursorLineNr = {
        fg = "#E5C07B";
        bold = true;
      };
    };
  };
}


