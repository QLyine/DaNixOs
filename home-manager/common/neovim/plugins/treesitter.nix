{ pkgs, ... }:
{
  programs.nixvim.plugins.treesitter = {
    enable = true;
    
    # Language parsers
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      bash
      c
      cpp
      css
      dockerfile
      go
      gomod
      gowork
      html
      javascript
      json
      lua
      markdown
      markdown_inline
      nix
      python
      rust
      toml
      tsx
      typescript
      vim
      vimdoc
      yaml
    ];
    
    settings = {
      # Enable syntax highlighting
      highlight = {
        enable = true;
        additional_vim_regex_highlighting = false;
      };
      
      # Enable incremental selection
      incremental_selection = {
        enable = true;
        keymaps = {
          init_selection = "<C-space>";
          node_incremental = "<C-space>";
          scope_incremental = "<C-space>";
          node_decremental = "<M-space>";
        };
      };
      
      # Enable indentation
      indent = {
        enable = true;
      };
      
      # Enable folding
      fold = {
        enable = true;
      };
    };
    
    # Additional treesitter modules
    nixvimInjections = true;
  };
  
  # Treesitter-related plugins
  programs.nixvim.plugins = {
    # Treesitter context
    treesitter-context = {
      enable = true;
      settings = {
        enable = true;
        max_lines = 0;
        min_window_height = 0;
        line_numbers = true;
        multiline_threshold = 20;
        trim_scope = "outer";
        mode = "cursor";
        separator = null;
        zindex = 20;
        on_attach = null;
      };
    };
    
    # Treesitter textobjects
    treesitter-textobjects = {
      enable = true;
      select = {
        enable = true;
        lookahead = true;
        keymaps = {
          "aa" = "@parameter.outer";
          "ia" = "@parameter.inner";
          "af" = "@function.outer";
          "if" = "@function.inner";
          "ac" = "@class.outer";
          "ic" = "@class.inner";
          "ii" = "@conditional.inner";
          "ai" = "@conditional.outer";
          "il" = "@loop.inner";
          "al" = "@loop.outer";
          "at" = "@comment.outer";
        };
      };
      move = {
        enable = true;
        gotoNextStart = {
          "]m" = "@function.outer";
          "]]" = "@class.outer";
          "]o" = "@loop.*";
          "]s" = "@scope";
          "]z" = "@fold";
        };
        gotoNextEnd = {
          "]M" = "@function.outer";
          "][" = "@class.outer";
        };
        gotoPreviousStart = {
          "[m" = "@function.outer";
          "[[" = "@class.outer";
          "[o" = "@loop.*";
          "[s" = "@scope";
          "[z" = "@fold";
        };
        gotoPreviousEnd = {
          "[M" = "@function.outer";
          "[]" = "@class.outer";
        };
      };
      swap = {
        enable = true;
        swapNext = {
          "<leader>a" = "@parameter.inner";
        };
        swapPrevious = {
          "<leader>A" = "@parameter.inner";
        };
      };
    };
    
    # Rainbow delimiters
    rainbow-delimiters = {
      enable = true;
      strategy = {
        default = "global";
        vim = "local";
      };
      query = {
        default = "rainbow-delimiters";
        lua = "rainbow-blocks";
      };
      highlight = [
        "RainbowDelimiterRed"
        "RainbowDelimiterYellow"
        "RainbowDelimiterBlue"
        "RainbowDelimiterOrange"
        "RainbowDelimiterGreen"
        "RainbowDelimiterViolet"
        "RainbowDelimiterCyan"
      ];
    };
    
    # Treesitter refactor
    treesitter-refactor = {
      enable = true;
      highlightDefinitions = {
        enable = true;
        clearOnCursorMove = false;
      };
      highlightCurrentScope = {
        enable = true;
      };
      smartRename = {
        enable = true;
        keymaps = {
          smartRename = "grr";
        };
      };
      navigation = {
        enable = true;
        keymaps = {
          gotoDefinition = "gnd";
          listDefinitions = "gnD";
          listDefinitionsToc = "gO";
          gotoNextUsage = "<a-*>";
          gotoPreviousUsage = "<a-#>";
        };
      };
    };
  };
}


