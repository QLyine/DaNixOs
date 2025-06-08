{
  programs.nixvim = {
    autoCmd = [
      {
        event = ["FileType"];
        pattern = ["rust"];
        callback.__raw = ''
          function()
            vim.opt_local.tabstop = 4
            vim.opt_local.shiftwidth = 4
            vim.opt_local.expandtab = true
            vim.opt_local.textwidth = 100
            vim.opt_local.colorcolumn = "100"
            vim.opt_local.commentstring = "// %s"
            
            -- Additional Rust keymaps
            local opts = { buffer = true, silent = true }
            
            -- Cargo commands
            vim.keymap.set("n", "<leader>cb", ":!cargo build<CR>", opts)
            vim.keymap.set("n", "<leader>cB", ":!cargo build --release<CR>", opts)
            vim.keymap.set("n", "<leader>cr", ":!cargo run<CR>", opts)
            vim.keymap.set("n", "<leader>cR", ":!cargo run --release<CR>", opts)
            vim.keymap.set("n", "<leader>ct", ":!cargo test<CR>", opts)
            vim.keymap.set("n", "<leader>cT", ":!cargo test --release<CR>", opts)
            vim.keymap.set("n", "<leader>cc", ":!cargo check<CR>", opts)
            vim.keymap.set("n", "<leader>cl", ":!cargo clippy<CR>", opts)
            vim.keymap.set("n", "<leader>cf", ":!cargo fmt<CR>", opts)
            vim.keymap.set("n", "<leader>cd", ":!cargo doc --open<CR>", opts)
            vim.keymap.set("n", "<leader>cu", ":!cargo update<CR>", opts)
            vim.keymap.set("n", "<leader>ca", ":!cargo add ", opts)
            vim.keymap.set("n", "<leader>cA", ":!cargo audit<CR>", opts)
            vim.keymap.set("n", "<leader>cn", ":!cargo new ", opts)
            vim.keymap.set("n", "<leader>ci", ":!cargo init<CR>", opts)
            vim.keymap.set("n", "<leader>cp", ":!cargo publish<CR>", opts)
          end
        '';
      }
      
      {
        event = ["FileType"];
        pattern = ["toml"];
        callback.__raw = ''
          function()
            if vim.fn.expand("%:t") == "Cargo.toml" then
              -- Crates.nvim keymaps for Cargo.toml
              local opts = { buffer = true, silent = true }
              
              vim.keymap.set("n", "<leader>ct", ":lua require('crates').toggle()<CR>", opts)
              vim.keymap.set("n", "<leader>cr", ":lua require('crates').reload()<CR>", opts)
              vim.keymap.set("n", "<leader>cv", ":lua require('crates').show_versions_popup()<CR>", opts)
              vim.keymap.set("n", "<leader>cf", ":lua require('crates').show_features_popup()<CR>", opts)
              vim.keymap.set("n", "<leader>cd", ":lua require('crates').show_dependencies_popup()<CR>", opts)
              vim.keymap.set("n", "<leader>cu", ":lua require('crates').update_crate()<CR>", opts)
              vim.keymap.set("v", "<leader>cu", ":lua require('crates').update_crates()<CR>", opts)
              vim.keymap.set("n", "<leader>ca", ":lua require('crates').update_all_crates()<CR>", opts)
              vim.keymap.set("n", "<leader>cU", ":lua require('crates').upgrade_crate()<CR>", opts)
              vim.keymap.set("v", "<leader>cU", ":lua require('crates').upgrade_crates()<CR>", opts)
              vim.keymap.set("n", "<leader>cA", ":lua require('crates').upgrade_all_crates()<CR>", opts)
              vim.keymap.set("n", "<leader>ce", ":lua require('crates').expand_plain_crate_to_inline_table()<CR>", opts)
              vim.keymap.set("n", "<leader>cE", ":lua require('crates').extract_crate_into_table()<CR>", opts)
              vim.keymap.set("n", "<leader>cH", ":lua require('crates').open_homepage()<CR>", opts)
              vim.keymap.set("n", "<leader>cR", ":lua require('crates').open_repository()<CR>", opts)
              vim.keymap.set("n", "<leader>cD", ":lua require('crates').open_documentation()<CR>", opts)
              vim.keymap.set("n", "<leader>cC", ":lua require('crates').open_crates_io()<CR>", opts)
            end
          end
        '';
      }
    ];
    
    # Rust user commands
    userCommands = {
      CargoRun = {
        command = "!cargo run";
        desc = "Run Rust project";
      };
      CargoBuild = {
        command = "!cargo build";
        desc = "Build Rust project";
      };
      CargoTest = {
        command = "!cargo test";
        desc = "Test Rust project";
      };
      CargoCheck = {
        command = "!cargo check";
        desc = "Check Rust project";
      };
      CargoClippy = {
        command = "!cargo clippy";
        desc = "Run Clippy on Rust project";
      };
      CargoFmt = {
        command = "!cargo fmt";
        desc = "Format Rust project";
      };
      CargoDoc = {
        command = "!cargo doc --open";
        desc = "Generate and open documentation";
      };
      CargoUpdate = {
        command = "!cargo update";
        desc = "Update Rust dependencies";
      };
      CargoAudit = {
        command = "!cargo audit";
        desc = "Audit Rust dependencies";
      };
    };
  };
}


