{
  programs.nixvim.plugins = {
    # Project management
    project-nvim = {
      enable = true;
      enableTelescope = true;
      settings = {
        manual_mode = false;
        detection_methods = ["lsp" "pattern"];
        patterns = [".git" "_darcs" ".hg" ".bzr" ".svn" "Makefile" "package.json" "flake.nix"];
        ignore_lsp = {};
        exclude_dirs = [];
        show_hidden = false;
        silent_chdir = true;
        scope_chdir = "global";
        datapath = vim.fn.stdpath("data");
      };
    };
    
    # Session management
    auto-session = {
      enable = true;
      settings = {
        log_level = "error";
        auto_session_enable_last_session = false;
        auto_session_enabled = true;
        auto_save_enabled = null;
        auto_restore_enabled = null;
        auto_session_suppress_dirs = ["~/" "~/Projects" "~/Downloads" "/"];
        auto_session_use_git_branch = false;
        
        bypass_session_save_file_types = [
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
        
        session_lens = {
          buftypes_to_ignore = [];
          load_on_setup = true;
          theme_conf = {
            border = true;
          };
          previewer = false;
        };
      };
    };
    
    # Workspace diagnostics
    workspace-diagnostics = {
      enable = true;
    };
    
    # Better quickfix
    bqf = {
      enable = true;
      settings = {
        auto_enable = true;
        auto_resize_height = true;
        preview = {
          win_height = 12;
          win_vheight = 12;
          delay_syntax = 80;
          border_chars = ["┃" "┃" "━" "━" "┏" "┓" "┗" "┛" "█"];
          show_title = false;
          should_preview_cb.__raw = ''
            function(bufnr, qwinid)
              local ret = true
              local bufname = vim.api.nvim_buf_get_name(bufnr)
              local fsize = vim.fn.getfsize(bufname)
              if fsize > 100 * 1024 then
                -- skip file size greater than 100k
                ret = false
              elseif bufname:match('^fugitive://') then
                -- skip fugitive buffer
                ret = false
              end
              return ret
            end
          '';
        };
        func_map = {
          drop = "o";
          openc = "O";
          split = "<C-s>";
          tabdrop = "<C-t>";
          tabc = "";
          ptogglemode = "z,";
        };
        filter = {
          fzf = {
            action_for = {
              ["ctrl-s"] = "split";
              ["ctrl-t"] = "tab drop";
            };
            extra_opts = ["--bind" "ctrl-o:toggle-all" "--prompt" "> "];
          };
        };
      };
    };
    
    # Harpoon for quick file navigation
    harpoon = {
      enable = true;
      enableTelescope = true;
      keymaps = {
        addFile = "<leader>ha";
        toggleQuickMenu = "<leader>hh";
        navFile = {
          "1" = "<leader>h1";
          "2" = "<leader>h2";
          "3" = "<leader>h3";
          "4" = "<leader>h4";
        };
      };
    };
    
    # Which-key for keybinding help
    which-key = {
      enable = true;
      settings = {
        delay = 200;
        expand = 1;
        notify = false;
        preset = false;
        
        replace = {
          key = [
            ["<Space>" "SPC"]
            ["<cr>" "RET"]
            ["<tab>" "TAB"]
          ];
        };
        
        icons = {
          breadcrumb = "»";
          separator = "➜";
          group = "+";
          ellipsis = "…";
          mappings = true;
          rules = false;
          colors = true;
          keys = {
            Up = " ";
            Down = " ";
            Left = " ";
            Right = " ";
            C = "󰘴 ";
            M = "󰘵 ";
            D = "󰘳 ";
            S = "󰘶 ";
            CR = "󰌑 ";
            Esc = "󱊷 ";
            ScrollWheelDown = "󱕐 ";
            ScrollWheelUp = "󱕑 ";
            NL = "󰌑 ";
            BS = "󰁮";
            Space = "󱁐 ";
            Tab = "󰌒 ";
            F1 = "󱊫";
            F2 = "󱊬";
            F3 = "󱊭";
            F4 = "󱊮";
            F5 = "󱊯";
            F6 = "󱊰";
            F7 = "󱊱";
            F8 = "󱊲";
            F9 = "󱊳";
            F10 = "󱊴";
            F11 = "󱊵";
            F12 = "󱊶";
          };
        };
        
        win = {
          border = "rounded";
          position = "bottom";
          margin = [1 0 1 0];
          padding = [1 2 1 2];
          winblend = 0;
          zindex = 1000;
        };
        
        layout = {
          height = {
            min = 4;
            max = 25;
          };
          width = {
            min = 20;
            max = 50;
          };
          spacing = 3;
          align = "left";
        };
        
        keys = {
          scroll_down = "<c-d>";
          scroll_up = "<c-u>";
        };
        
        sort = ["local" "order" "group" "alphanum" "mod"];
        
        expand = 0;
        
        spec = [
          {
            __unkeyed-1 = "<leader>f";
            group = "Find";
            expand.__raw = ''
              function()
                return require("which-key.extras").expand.buf()
              end
            '';
          }
          {
            __unkeyed-1 = "<leader>g";
            group = "Git";
          }
          {
            __unkeyed-1 = "<leader>h";
            group = "Harpoon";
          }
          {
            __unkeyed-1 = "<leader>l";
            group = "LSP";
          }
          {
            __unkeyed-1 = "<leader>t";
            group = "Terminal/Toggle";
          }
          {
            __unkeyed-1 = "<leader>w";
            group = "Windows";
          }
          {
            __unkeyed-1 = "<leader>x";
            group = "Diagnostics/Quickfix";
          }
        ];
      };
    };
  };
}


