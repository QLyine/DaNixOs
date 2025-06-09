{
  programs.nixvim.plugins = {
    # LSP configuration
    lsp = {
      enable = true;

      # Keymaps
      keymaps = {
        silent = true;
        diagnostic = {
          "<leader>k" = "goto_prev";
          "<leader>j" = "goto_next";
          "<leader>ef" = "open_float";
          "<leader>el" = "setloclist";
        };

        lspBuf = {
          "gd" = "definition";
          "gD" = "declaration";
          "gr" = "references";
          "gi" = "implementation";
          "gt" = "type_definition";
          "K" = "hover";
          "<leader>ca" = "code_action";
          "<leader>rn" = "rename";
          "<leader>f" = "format";
        };
      };

      # Language servers
      servers = {
        # Nix
        nil_ls = {
          enable = true;
          settings = {
            formatting = {
              command = [ "nixpkgs-fmt" ];
            };
            nix = {
              maxMemoryMB = 2560;
              flake = {
                autoArchive = true;
                autoEvalInputs = true;
              };
            };
          };
        };

        # TypeScript/JavaScript
        ts_ls = {
          enable = true;
          filetypes = [ "javascript" "javascriptreact" "typescript" "typescriptreact" ];
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "literal";
                includeInlayParameterNameHintsWhenArgumentMatchesName = false;
                includeInlayFunctionParameterTypeHints = true;
                includeInlayVariableTypeHints = false;
                includeInlayPropertyDeclarationTypeHints = true;
                includeInlayFunctionLikeReturnTypeHints = true;
                includeInlayEnumMemberValueHints = true;
              };
            };
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all";
                includeInlayParameterNameHintsWhenArgumentMatchesName = false;
                includeInlayFunctionParameterTypeHints = true;
                includeInlayVariableTypeHints = true;
                includeInlayPropertyDeclarationTypeHints = true;
                includeInlayFunctionLikeReturnTypeHints = true;
                includeInlayEnumMemberValueHints = true;
              };
            };
          };
        };

        # HTML/CSS/JSON
        html.enable = true;
        cssls.enable = true;
        jsonls.enable = true;

        # Python
        pylsp = {
          enable = true;
          settings = {
            pylsp = {
              plugins = {
                pycodestyle = {
                  ignore = [ "W391" ];
                  maxLineLength = 100;
                };
                flake8 = {
                  enabled = true;
                  maxLineLength = 100;
                };
                black = {
                  enabled = true;
                  line_length = 100;
                };
                isort = {
                  enabled = true;
                };
                pylint = {
                  enabled = true;
                };
                rope_completion = {
                  enabled = true;
                };
              };
            };
          };
        };

        # Rust
        rust_analyzer = {
          enable = true;
          installCargo = true;
          installRustc = true;
          settings = {
            cargo = {
              allFeatures = true;
              loadOutDirsFromCheck = true;
              runBuildScripts = true;
            };
            check = {
              features = "all";
              command = "clippy";
              extraArgs = [ "--no-deps" ];
            };
            procMacro = {
              enable = true;
              ignored = {
                async-trait = [ "async_trait" ];
                napi-derive = [ "napi" ];
                async-recursion = [ "async_recursion" ];
              };
            };
          };
        };

        # Go
        gopls = {
          enable = true;
          settings = {
            gopls = {
              analyses = {
                unusedparams = true;
              };
              staticcheck = true;
              gofumpt = true;
            };
          };
        };

        # Lua
        lua_ls = {
          enable = true;
          settings = {
            Lua = {
              runtime = {
                version = "LuaJIT";
              };
              diagnostics = {
                globals = [ "vim" ];
              };
              workspace = {
                checkThirdParty = false;
              };
              telemetry = {
                enable = false;
              };
            };
          };
        };

        # Bash
        bashls.enable = true;

        # YAML
        yamlls.enable = true;

        # Docker
        dockerls.enable = true;

        # Markdown
        marksman.enable = true;
      };
    };

    # LSP-related plugins
    lsp-format = {
      enable = true;
    };

    lsp-lines = {
      enable = true;
    };

    lspsaga = {
      enable = true;
      hover = {
        maxWidth = 0.6;
      };
      outline = {
        winWidth = 30;
        keys = {
          jump = "o";
          quit = "q";
        };
      };
    };

    # Inlay hints
    lsp-signature = {
      enable = true;
      settings = {
        bind = true;
        handler_opts = {
          border = "rounded";
        };
      };
    };
  };

  # Diagnostic configuration
  programs.nixvim.diagnostics = {
    virtual_text = {
      prefix = "●";
    };
    signs = {
      text = {
        error = "✘";
        warn = "▲";
        hint = "⚑";
        info = "»";
      };
    };
    update_in_insert = false;
    underline = true;
    severity_sort = true;
    float = {
      focusable = false;
      style = "minimal";
      border = "rounded";
      source = "always";
      header = "";
      prefix = "";
    };
  };
}


