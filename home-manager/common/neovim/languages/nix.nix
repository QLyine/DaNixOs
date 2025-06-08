{
  programs.nixvim = {
    # Nix-specific configuration
    plugins = {
      # Enhanced Nix support
      vim-nix = {
        enable = true;
      };
    };
    
    # Nix file type settings
    filetype = {
      extension = {
        nix = "nix";
      };
    };
    
    # Nix-specific autocommands
    autoCommands = [
      {
        event = ["FileType"];
        pattern = ["nix"];
        callback.__raw = ''
          function()
            vim.opt_local.tabstop = 2
            vim.opt_local.shiftwidth = 2
            vim.opt_local.expandtab = true
            vim.opt_local.commentstring = "# %s"
            
            -- Nix-specific keymaps
            local opts = { buffer = true, silent = true }
            vim.keymap.set("n", "<leader>nf", ":!nixpkgs-fmt %<CR>", opts)
            vim.keymap.set("n", "<leader>nc", ":!nix-instantiate --parse %<CR>", opts)
            vim.keymap.set("n", "<leader>ne", ":!nix-instantiate --eval %<CR>", opts)
          end
        '';
      }
    ];
    
    # Nix snippets and abbreviations
    userCommands = {
      NixFlakeInit = {
        command = "!nix flake init";
        desc = "Initialize a new Nix flake";
      };
      NixFlakeUpdate = {
        command = "!nix flake update";
        desc = "Update Nix flake inputs";
      };
      NixFlakeCheck = {
        command = "!nix flake check";
        desc = "Check Nix flake";
      };
      NixBuild = {
        command = "!nix build";
        desc = "Build current Nix flake";
      };
      NixDevelop = {
        command = "!nix develop";
        desc = "Enter Nix development shell";
      };
    };
  };
}


