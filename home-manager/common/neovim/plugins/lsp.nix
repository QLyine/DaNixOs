{
  programs.nixvim.plugins = {
    lsp-lines.enable = true;
    lsp = {
      enable = true;
      servers = {
        nixd.enable = true;
        gopls.enable = true;
        pyright.enable = true;
        cmake.enable = true;
        bashls.enable = true;
      };

      keymaps = {
        silent = false; # Whether nvim-lsp keymaps should be silent.
        diagnostic = {
          # Mappings for functions: `vim.diagnostic.<action>`
          "<leader>dj" = "goto_next";
          "<leader>dk" = "goto_prev";
        };
        lspBuf = {
          K = "hover";
          gD = "references";
          gd = "definition";
          gi = "implementation";
          gt = "type_definition";
          ca = "code_action";
          ff = "format";
        };
      };
    };
  };
}