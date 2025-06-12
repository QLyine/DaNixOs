{
  programs.nixvim.plugins.blink-cmp = {
    enable = true;
    
    settings = {
      # Appearance
      appearance = {
        use_nvim_cmp_as_default = true;
        nerd_font_variant = "mono";
      };
      
      # Completion settings
      completion = {
        accept = {
          auto_brackets = {
            enabled = true;
          };
        };
        
        menu = {
          draw = {
            treesitter = ["lsp"];
            columns = [
              ["label" "label_description" "kind_icon"]
              ["kind"]
            ];
          };
        };
        
        documentation = {
          auto_show = true;
          auto_show_delay_ms = 200;
        };
        
        ghost_text = {
          enabled = true;
        };
      };
      
      # Fuzzy matching ??? Not working whyyyy ???
      #fuzzy = {
      #  use_typo_resistance = true;
      #  use_frecency = true;
      #  use_proximity = true;
      #  max_items = 200;
      #  sorts = ["label" "kind" "score"];
      #};
      
      # Sources
      sources = {
        default = ["lsp" "path" "snippets" "buffer"];
        providers = {
          lsp = {
            name = "LSP";
            module = "blink.cmp.sources.lsp";
            enabled = true;
            transform_items.__raw = ''
              function(_, items)
                -- Deprioritize text from LSP
                for _, item in ipairs(items) do
                  if item.kind == require('blink.cmp.types').CompletionItemKind.Text then
                    item.score_offset = item.score_offset - 3
                  end
                end
                return items
              end
            '';
          };
          
          path = {
            name = "Path";
            module = "blink.cmp.sources.path";
            enabled = true;
            opts = {
              trailing_slash = false;
              label_trailing_slash = true;
              get_cwd.__raw = "function(context) return vim.fn.expand(('#%d:p:h'):format(context.bufnr)) end";
              show_hidden_files_by_default = false;
            };
          };
          
          snippets = {
            name = "Snippets";
            module = "blink.cmp.sources.snippets";
            enabled = true;
            opts = {
              friendly_snippets = true;
              search_paths = ["~/.config/nvim/snippets"];
              global_snippets = ["all"];
              extended_filetypes = {};
              ignored_filetypes = {};
            };
          };
          
          buffer = {
            name = "Buffer";
            module = "blink.cmp.sources.buffer";
            enabled = true;
            opts = {
              min_keyword_length = 3;
              max_items = 5;
            };
          };
        };
      };
      
      # Signature help
      signature = {
        enabled = true;
        trigger = {
          blocked_trigger_characters = [];
          blocked_retrigger_characters = [];
        };
        window = {
          min_width = 1;
          max_width = 100;
          max_height = 10;
          border = "padded";
          winblend = 0;
          winhighlight = "Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder";
          scrollbar = true;
          direction_priority = ["n" "s"];
        };
      };
      
      # Keymaps
      keymap = {
        preset = "super-tab";
      };
    };
  };
  
  # Additional completion-related plugins
  programs.nixvim.plugins = {
    # Snippet engine
    luasnip = {
      enable = true;
      settings = {
        enable_autosnippets = true;
        store_selection_keys = "<Tab>";
      };
      fromVscode = [
        {
          lazyLoad = true;
          paths = ["~/.config/nvim/snippets"];
        }
      ];
    };
    
    # Friendly snippets
    friendly-snippets.enable = true;
  };
}


