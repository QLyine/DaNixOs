{
  programs.nixvim.plugins = {
    # Conform for formatting
    conform-nvim = {
      enable = true;
      settings = {
        formatters_by_ft = {
          lua = ["stylua"];
          python = ["isort" "black"];
          javascript = ["prettierd" "prettier"];
          typescript = ["prettierd" "prettier"];
          javascriptreact = ["prettierd" "prettier"];
          typescriptreact = ["prettierd" "prettier"];
          json = ["prettierd" "prettier"];
          yaml = ["prettierd" "prettier"];
          markdown = ["prettierd" "prettier"];
          html = ["prettierd" "prettier"];
          css = ["prettierd" "prettier"];
          scss = ["prettierd" "prettier"];
          rust = ["rustfmt"];
          go = ["goimports" "gofmt"];
          nix = ["nixpkgs_fmt"];
          sh = ["shfmt"];
          bash = ["shfmt"];
          zsh = ["shfmt"];
          toml = ["taplo"];
          xml = ["xmlformat"];
        };
        
        format_on_save = {
          timeout_ms = 500;
          lsp_fallback = true;
        };
        
        format_after_save = {
          lsp_fallback = true;
        };
        
        log_level = "error";
        
        notify_on_error = true;
        
        formatters = {
          shfmt = {
            prepend_args = ["-i" "2"];
          };
          
          prettier = {
            prepend_args = ["--tab-width" "2"];
          };
          
          prettierd = {
            prepend_args = ["--tab-width" "2"];
          };
        };
      };
    };
    
    # None-ls for additional formatting and linting
    none-ls = {
      enable = true;
      enableLspFormat = true;
      updateInInsert = false;
      
      sources = {
        formatting = {
          # Nix
          nixpkgs_fmt.enable = true;
          
          # Lua
          stylua.enable = true;
          
          # Python
          black.enable = true;
          isort.enable = true;
          
          # JavaScript/TypeScript
          prettier = {
            enable = true;
            disableTsServerFormatter = true;
          };
          
          # Go
          gofmt.enable = true;
          goimports.enable = true;
          
          # Shell
          shfmt.enable = true;
          
          # YAML
          yamlfmt.enable = true;
        };
        
        diagnostics = {
          # Python
          mypy.enable = true;
          
          # YAML
          yamllint.enable = true;
          
          # Markdown
          markdownlint.enable = true;
          
          # Git
          gitlint.enable = true;
        };
      };
    };
  };
}


