{
  programs.nixvim.plugins.telescope = {
    enable = true;
    
    # Extensions
    extensions = {
      fzf-native = {
        enable = true;
        settings = {
          fuzzy = true;
          override_generic_sorter = true;
          override_file_sorter = true;
          case_mode = "smart_case";
        };
      };
      
      ui-select = {
        enable = true;
      };
      
      file-browser = {
        enable = true;
        settings = {
          theme = "ivy";
          hijack_netrw = true;
          mappings = {
            "i" = {
              "<A-c>" = "create";
              "<A-r>" = "rename";
              "<A-d>" = "remove";
            };
          };
        };
      };
      
      project = {
        enable = true;
        settings = {
          base_dirs = [
            "~/projects"
            "~/.config"
          ];
          hidden_files = true;
          theme = "dropdown";
          order_by = "asc";
          search_by = "title";
        };
      };
    };
    
    # Settings
    settings = {
      defaults = {
        prompt_prefix = " ";
        selection_caret = " ";
        path_display = ["truncate"];
        file_ignore_patterns = [
          ".git/"
          "node_modules/"
          "target/"
          "build/"
          "dist/"
          "*.pyc"
          "__pycache__/"
        ];
        
        mappings = {
          i = {
            "<C-n>" = "move_selection_next";
            "<C-p>" = "move_selection_previous";
            "<C-j>" = "move_selection_next";
            "<C-k>" = "move_selection_previous";
            "<C-c>" = "close";
            "<Down>" = "move_selection_next";
            "<Up>" = "move_selection_previous";
            "<CR>" = "select_default";
            "<C-x>" = "select_horizontal";
            "<C-v>" = "select_vertical";
            "<C-t>" = "select_tab";
            "<C-u>" = "preview_scrolling_up";
            "<C-d>" = "preview_scrolling_down";
            "<PageUp>" = "results_scrolling_up";
            "<PageDown>" = "results_scrolling_down";
            "<Tab>" = "toggle_selection + move_selection_worse";
            "<S-Tab>" = "toggle_selection + move_selection_better";
            "<C-q>" = "send_to_qflist + open_qflist";
            "<M-q>" = "send_selected_to_qflist + open_qflist";
            "<C-l>" = "complete_tag";
            "<C-_>" = "which_key";
          };
          
          n = {
            "<esc>" = "close";
            "<CR>" = "select_default";
            "<C-x>" = "select_horizontal";
            "<C-v>" = "select_vertical";
            "<C-t>" = "select_tab";
            "<Tab>" = "toggle_selection + move_selection_worse";
            "<S-Tab>" = "toggle_selection + move_selection_better";
            "<C-q>" = "send_to_qflist + open_qflist";
            "<M-q>" = "send_selected_to_qflist + open_qflist";
            "j" = "move_selection_next";
            "k" = "move_selection_previous";
            "H" = "move_to_top";
            "M" = "move_to_middle";
            "L" = "move_to_bottom";
            "<Down>" = "move_selection_next";
            "<Up>" = "move_selection_previous";
            "gg" = "move_to_top";
            "G" = "move_to_bottom";
            "<C-u>" = "preview_scrolling_up";
            "<C-d>" = "preview_scrolling_down";
            "<PageUp>" = "results_scrolling_up";
            "<PageDown>" = "results_scrolling_down";
            "?" = "which_key";
          };
        };
      };
      
      pickers = {
        find_files = {
          find_command = ["rg" "--files" "--hidden" "--glob" "!**/.git/*"];
        };
        
        live_grep = {
          additional_args = ["--hidden"];
        };
        
        grep_string = {
          additional_args = ["--hidden"];
        };
        
        buffers = {
          ignore_current_buffer = true;
          sort_lastused = true;
        };
        
        git_files = {
          hidden = true;
          show_untracked = true;
        };
        
        lsp_references = {
          theme = "dropdown";
          initial_mode = "normal";
        };
        
        lsp_definitions = {
          theme = "dropdown";
          initial_mode = "normal";
        };
        
        lsp_declarations = {
          theme = "dropdown";
          initial_mode = "normal";
        };
        
        lsp_implementations = {
          theme = "dropdown";
          initial_mode = "normal";
        };
      };
    };
    
    # Keymaps
    keymaps = {
      "<leader>ff" = {
        action = "find_files";
        options = {
          desc = "Find files";
        };
      };
      
      "<leader>fg" = {
        action = "live_grep";
        options = {
          desc = "Live grep";
        };
      };
      
      "<leader>fb" = {
        action = "buffers";
        options = {
          desc = "Find buffers";
        };
      };
      
      "<leader>fh" = {
        action = "help_tags";
        options = {
          desc = "Help tags";
        };
      };
      
      "<leader>fr" = {
        action = "oldfiles";
        options = {
          desc = "Recent files";
        };
      };
      
      "<leader>fc" = {
        action = "commands";
        options = {
          desc = "Commands";
        };
      };
      
      "<leader>fk" = {
        action = "keymaps";
        options = {
          desc = "Keymaps";
        };
      };
      
      "<leader>fs" = {
        action = "lsp_document_symbols";
        options = {
          desc = "Document symbols";
        };
      };
      
      "<leader>fS" = {
        action = "lsp_workspace_symbols";
        options = {
          desc = "Workspace symbols";
        };
      };
      
      "<leader>fp" = {
        action = "project";
        options = {
          desc = "Projects";
        };
      };
      
      "<leader>fe" = {
        action = "file_browser";
        options = {
          desc = "File browser";
        };
      };
    };
  };
}


