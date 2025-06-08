{
  programs.nixvim.plugins = {
    # ToggleTerm for integrated terminal
    toggleterm = {
      enable = true;
      settings = {
        size = 20;
        open_mapping = "[[<c-\\>]]";
        hide_numbers = true;
        shade_filetypes = [];
        shade_terminals = true;
        shading_factor = 2;
        start_in_insert = true;
        insert_mappings = true;
        terminal_mappings = true;
        persist_size = true;
        persist_mode = true;
        direction = "float";
        close_on_exit = true;
        auto_scroll = true;
        
        float_opts = {
          border = "curved";
          winblend = 0;
          highlights = {
            border = "Normal";
            background = "Normal";
          };
        };
        
        winbar = {
          enabled = false;
          name_formatter.__raw = ''
            function(term)
              return term.name
            end
          '';
        };
      };
    };
  };
  
  # Terminal-specific keymaps and autocommands
  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>tt";
      action = ":ToggleTerm<CR>";
      options = {
        silent = true;
        desc = "Toggle terminal";
      };
    }
    {
      mode = "n";
      key = "<leader>tf";
      action = ":ToggleTerm direction=float<CR>";
      options = {
        silent = true;
        desc = "Toggle floating terminal";
      };
    }
    {
      mode = "n";
      key = "<leader>th";
      action = ":ToggleTerm direction=horizontal<CR>";
      options = {
        silent = true;
        desc = "Toggle horizontal terminal";
      };
    }
    {
      mode = "n";
      key = "<leader>tv";
      action = ":ToggleTerm direction=vertical size=80<CR>";
      options = {
        silent = true;
        desc = "Toggle vertical terminal";
      };
    }
    {
      mode = "t";
      key = "<esc>";
      action = "<C-\\><C-n>";
      options = {
        silent = true;
        desc = "Exit terminal mode";
      };
    }
    {
      mode = "t";
      key = "jk";
      action = "<C-\\><C-n>";
      options = {
        silent = true;
        desc = "Exit terminal mode";
      };
    }
    {
      mode = "t";
      key = "<C-h>";
      action = "<C-\\><C-n><C-w>h";
      options = {
        silent = true;
        desc = "Move to left window";
      };
    }
    {
      mode = "t";
      key = "<C-j>";
      action = "<C-\\><C-n><C-w>j";
      options = {
        silent = true;
        desc = "Move to bottom window";
      };
    }
    {
      mode = "t";
      key = "<C-k>";
      action = "<C-\\><C-n><C-w>k";
      options = {
        silent = true;
        desc = "Move to top window";
      };
    }
    {
      mode = "t";
      key = "<C-l>";
      action = "<C-\\><C-n><C-w>l";
      options = {
        silent = true;
        desc = "Move to right window";
      };
    }
  ];
}


