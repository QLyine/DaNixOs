{
  programs.nixvim.autoCmd = [
    # Highlight yanked text
    {
      event = ["TextYankPost"];
      callback.__raw = ''
        function()
          vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 200,
          })
        end
      '';
    }
    
    # Auto-resize splits when window is resized
    {
      event = ["VimResized"];
      command = "tabdo wincmd =";
    }
    
    # Remove trailing whitespace on save
    {
      event = ["BufWritePre"];
      command = "%s/\\s\\+$//e";
    }
    
    # Return to last edit position when opening files
    {
      event = ["BufReadPost"];
      callback.__raw = ''
        function()
          local mark = vim.api.nvim_buf_get_mark(0, '"')
          local lcount = vim.api.nvim_buf_line_count(0)
          if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
          end
        end
      '';
    }
    
    # Close certain filetypes with q
    {
      event = ["FileType"];
      pattern = ["qf" "help" "man" "lspinfo" "spectre_panel"];
      callback.__raw = ''
        function()
          vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = true })
        end
      '';
    }
    
    # Auto-create directories when saving files
    {
      event = ["BufWritePre"];
      callback.__raw = ''
        function()
          local dir = vim.fn.expand("<afile>:p:h")
          if vim.fn.isdirectory(dir) == 0 then
            vim.fn.mkdir(dir, "p")
          end
        end
      '';
    }
    
    # Set wrap and spell for text files
    {
      event = ["FileType"];
      pattern = ["gitcommit" "markdown" "text"];
      callback.__raw = ''
        function()
          vim.opt_local.wrap = true
          vim.opt_local.spell = true
        end
      '';
    }
    
    # Disable line numbers in terminal
    {
      event = ["TermOpen"];
      callback.__raw = ''
        function()
          vim.opt_local.number = false
          vim.opt_local.relativenumber = false
        end
      '';
    }
    
    # Auto-save when focus is lost
    {
      event = ["FocusLost"];
      command = "silent! wa";
    }
    
    # Format on save for specific filetypes
    {
      event = ["BufWritePre"];
      pattern = ["*.lua" "*.nix" "*.rs" "*.go" "*.py" "*.js" "*.ts" "*.jsx" "*.tsx"];
      callback.__raw = ''
        function()
          vim.lsp.buf.format({ async = false })
        end
      '';
    }
  ];
}


