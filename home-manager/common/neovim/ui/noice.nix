{
  programs.nixvim.plugins.noice = {
    enable = true;
    
    settings = {
      lsp = {
        override = {
          "vim.lsp.util.convert_input_to_markdown_lines" = true;
          "vim.lsp.util.stylize_markdown" = true;
          "cmp.entry.get_documentation" = true;
        };
      };
      
      presets = {
        bottom_search = true;
        command_palette = true;
        long_message_to_split = true;
        inc_rename = false;
        lsp_doc_border = false;
      };
      
      messages = {
        enabled = true;
        view = "notify";
        view_error = "notify";
        view_warn = "notify";
        view_history = "messages";
        view_search = "virtualtext";
      };
      
      popupmenu = {
        enabled = true;
        backend = "nui";
        kind_icons = {};
      };
      
      redirect = {
        view = "popup";
        filter = {
          event = "msg_show";
        };
      };
      
      commands = {
        history = {
          view = "split";
          opts = {
            enter = true;
            format = "details";
          };
          filter = {
            any = [
              {
                event = "notify";
              }
              {
                error = true;
              }
              {
                warning = true;
              }
              {
                event = "msg_show";
                kind = [""];
              }
              {
                event = "lsp";
                kind = "message";
              }
            ];
          };
        };
        
        last = {
          view = "popup";
          opts = {
            enter = true;
            format = "details";
          };
          filter = {
            any = [
              {
                event = "notify";
              }
              {
                error = true;
              }
              {
                warning = true;
              }
              {
                event = "msg_show";
                kind = [""];
              }
              {
                event = "lsp";
                kind = "message";
              }
            ];
          };
          filter_opts = {
            count = 1;
          };
        };
        
        errors = {
          view = "popup";
          opts = {
            enter = true;
            format = "details";
          };
          filter = {
            error = true;
          };
          filter_opts = {
            reverse = true;
          };
        };
      };
      
      notify = {
        enabled = true;
        view = "notify";
      };
      
      health = {
        checker = false;
      };
      
      smart_move = {
        enabled = true;
        excluded_filetypes = ["cmp_menu" "cmp_docs" "notify"];
      };
      
      throttle = 1000 / 30;
      
      views = {};
      
      routes = [
        {
          filter = {
            event = "msg_show";
            any = [
              {
                find = "%d+L, %d+B";
              }
              {
                find = "; after #%d+";
              }
              {
                find = "; before #%d+";
              }
            ];
          };
          view = "mini";
        }
      ];
      
      status = {};
      format = {};
    };
  };
}


