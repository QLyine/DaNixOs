{ lib, config, ... }: {
  programs.nixvim.keymaps = let
    # Helper function to create keymaps
    mkKeymap = mode: key: action: desc: {
      inherit mode key action;
      options = {
        silent = true;
        desc = desc;
      };
    };
    
    # Normal mode keymaps
    normal = [
      # Leader key shortcuts
      (mkKeymap "n" "<leader>w" ":w<CR>" "Save file")
      (mkKeymap "n" "<leader>wq" ":wq<CR>" "Save and quit")
      (mkKeymap "n" "<leader>q" ":q<CR>" "Quit")
      (mkKeymap "n" "<leader>Q" ":qa!<CR>" "Force quit all")
      (mkKeymap "n" "<C-s>" ":w<CR>" "Save file")
      
      # Clear search highlighting
      (mkKeymap "n" "<Esc>" ":noh<CR>" "Clear search highlighting")
      
      # Better Y behavior
      (mkKeymap "n" "Y" "y$" "Yank to end of line")
      
      # Window navigation
      (mkKeymap "n" "<leader>h" "<C-w>h" "Move to left window")
      (mkKeymap "n" "<leader>j" "<C-w>j" "Move to bottom window")
      (mkKeymap "n" "<leader>k" "<C-w>k" "Move to top window")
      (mkKeymap "n" "<leader>l" "<C-w>l" "Move to right window")
      
      # Window management
      (mkKeymap "n" "<leader>sv" ":vsplit<CR>" "Split vertically")
      (mkKeymap "n" "<leader>sh" ":split<CR>" "Split horizontally")
      (mkKeymap "n" "<leader>sc" ":close<CR>" "Close window")
      (mkKeymap "n" "<leader>so" ":only<CR>" "Close other windows")
      
      # Window resizing
      (mkKeymap "n" "<C-Up>" ":resize -2<CR>" "Decrease height")
      (mkKeymap "n" "<C-Down>" ":resize +2<CR>" "Increase height")
      (mkKeymap "n" "<C-Left>" ":vertical resize -2<CR>" "Decrease width")
      (mkKeymap "n" "<C-Right>" ":vertical resize +2<CR>" "Increase width")
      
      # Buffer navigation
      (mkKeymap "n" "<leader>bn" ":bnext<CR>" "Next buffer")
      (mkKeymap "n" "<leader>bp" ":bprevious<CR>" "Previous buffer")
      (mkKeymap "n" "<leader>bd" ":bdelete<CR>" "Delete buffer")
      (mkKeymap "n" "<leader>bD" ":bdelete!<CR>" "Force delete buffer")
      (mkKeymap "n" "<C-c>" ":b#<CR>" "Switch to last buffer")
      
      # Tab navigation
      (mkKeymap "n" "<leader>tn" ":tabnew<CR>" "New tab")
      (mkKeymap "n" "<leader>tc" ":tabclose<CR>" "Close tab")
      (mkKeymap "n" "<leader>to" ":tabonly<CR>" "Close other tabs")
      (mkKeymap "n" "gt" ":tabnext<CR>" "Next tab")
      (mkKeymap "n" "gT" ":tabprevious<CR>" "Previous tab")
      
      # File explorer
      (mkKeymap "n" "<leader>e" ":Neotree toggle<CR>" "Toggle file explorer")
      (mkKeymap "n" "<leader>E" ":Neotree focus<CR>" "Focus file explorer")
      
      # Telescope shortcuts
      (mkKeymap "n" "<leader>ff" ":Telescope find_files<CR>" "Find files")
      (mkKeymap "n" "<leader>fg" ":Telescope live_grep<CR>" "Live grep")
      (mkKeymap "n" "<leader>fb" ":Telescope buffers<CR>" "Find buffers")
      (mkKeymap "n" "<leader>fh" ":Telescope help_tags<CR>" "Help tags")
      (mkKeymap "n" "<leader>fr" ":Telescope oldfiles<CR>" "Recent files")
      (mkKeymap "n" "<leader>fc" ":Telescope commands<CR>" "Commands")
      (mkKeymap "n" "<leader>fk" ":Telescope keymaps<CR>" "Keymaps")
      (mkKeymap "n" "<leader>fs" ":Telescope lsp_document_symbols<CR>" "Document symbols")
      (mkKeymap "n" "<leader>fS" ":Telescope lsp_workspace_symbols<CR>" "Workspace symbols")
      
      # LSP shortcuts
      (mkKeymap "n" "gd" ":Telescope lsp_definitions<CR>" "Go to definition")
      (mkKeymap "n" "gr" ":Telescope lsp_references<CR>" "Go to references")
      (mkKeymap "n" "gi" ":Telescope lsp_implementations<CR>" "Go to implementation")
      (mkKeymap "n" "gt" ":Telescope lsp_type_definitions<CR>" "Go to type definition")
      (mkKeymap "n" "K" ":lua vim.lsp.buf.hover()<CR>" "Show hover")
      (mkKeymap "n" "<leader>ca" ":lua vim.lsp.buf.code_action()<CR>" "Code action")
      (mkKeymap "n" "<leader>rn" ":lua vim.lsp.buf.rename()<CR>" "Rename")
      (mkKeymap "n" "<leader>f" ":lua vim.lsp.buf.format()<CR>" "Format")
      (mkKeymap "n" "[d" ":lua vim.diagnostic.goto_prev()<CR>" "Previous diagnostic")
      (mkKeymap "n" "]d" ":lua vim.diagnostic.goto_next()<CR>" "Next diagnostic")
      (mkKeymap "n" "<leader>d" ":lua vim.diagnostic.open_float()<CR>" "Show diagnostic")
      
      # Trouble (diagnostics)
      (mkKeymap "n" "<leader>xx" ":Trouble diagnostics toggle<CR>" "Toggle diagnostics")
      (mkKeymap "n" "<leader>xX" ":Trouble diagnostics toggle filter.buf=0<CR>" "Buffer diagnostics")
      (mkKeymap "n" "<leader>cs" ":Trouble symbols toggle focus=false<CR>" "Symbols")
      (mkKeymap "n" "<leader>cl" ":Trouble lsp toggle focus=false win.position=right<CR>" "LSP definitions")
      (mkKeymap "n" "<leader>xL" ":Trouble loclist toggle<CR>" "Location list")
      (mkKeymap "n" "<leader>xQ" ":Trouble qflist toggle<CR>" "Quickfix list")
      
      # Git shortcuts
      (mkKeymap "n" "<leader>gs" ":Git<CR>" "Git status")
      (mkKeymap "n" "<leader>gc" ":Git commit<CR>" "Git commit")
      (mkKeymap "n" "<leader>gp" ":Git push<CR>" "Git push")
      (mkKeymap "n" "<leader>gl" ":Git pull<CR>" "Git pull")
      (mkKeymap "n" "<leader>gb" ":Git blame<CR>" "Git blame")
      
      # Clipboard
      (mkKeymap "n" "<leader>p" ":Telescope neoclip<CR>" "Clipboard history")
      (mkKeymap "n" "<leader>y" "\"+y" "Yank to system clipboard")
      (mkKeymap "n" "<leader>P" "\"+p" "Paste from system clipboard")
      
      # Line movement
      (mkKeymap "n" "<A-j>" ":m .+1<CR>==" "Move line down")
      (mkKeymap "n" "<A-k>" ":m .-2<CR>==" "Move line up")
      
      # Quick actions
      (mkKeymap "n" "<leader>nh" ":nohl<CR>" "No highlight")
      (mkKeymap "n" "<leader>+" "<C-a>" "Increment number")
      (mkKeymap "n" "<leader>-" "<C-x>" "Decrement number")
      
      # Terminal
      (mkKeymap "n" "<leader>tt" ":ToggleTerm<CR>" "Toggle terminal")
      (mkKeymap "n" "<leader>tf" ":ToggleTerm direction=float<CR>" "Float terminal")
      (mkKeymap "n" "<leader>th" ":ToggleTerm direction=horizontal<CR>" "Horizontal terminal")
      (mkKeymap "n" "<leader>tv" ":ToggleTerm direction=vertical<CR>" "Vertical terminal")
    ];
    
    # Visual mode keymaps
    visual = [
      # Better indenting
      (mkKeymap "v" "<" "<gv" "Indent left")
      (mkKeymap "v" ">" ">gv" "Indent right")
      
      # Move text up and down
      (mkKeymap "v" "<A-j>" ":m '>+1<CR>gv=gv" "Move selection down")
      (mkKeymap "v" "<A-k>" ":m '<-2<CR>gv=gv" "Move selection up")
      
      # Clipboard
      (mkKeymap "v" "<leader>y" "\"+y" "Yank to system clipboard")
      (mkKeymap "v" "<leader>p" "\"+p" "Paste from system clipboard")
      
      # Search and replace
      (mkKeymap "v" "<leader>r" "\"hy:%s/<C-r>h//gc<left><left><left>" "Replace selection")
    ];
    
    # Insert mode keymaps
    insert = [
      # Exit insert mode
      (mkKeymap "i" "jk" "<ESC>" "Exit insert mode")
      (mkKeymap "i" "kj" "<ESC>" "Exit insert mode")
      
      # Save in insert mode
      (mkKeymap "i" "<C-s>" "<ESC>:w<CR>a" "Save and continue")
      
      # Move cursor in insert mode
      (mkKeymap "i" "<C-h>" "<Left>" "Move left")
      (mkKeymap "i" "<C-j>" "<Down>" "Move down")
      (mkKeymap "i" "<C-k>" "<Up>" "Move up")
      (mkKeymap "i" "<C-l>" "<Right>" "Move right")
    ];
    
    # Terminal mode keymaps
    terminal = [
      (mkKeymap "t" "<Esc>" "<C-\\><C-n>" "Exit terminal mode")
      (mkKeymap "t" "<C-h>" "<C-\\><C-n><C-w>h" "Move to left window")
      (mkKeymap "t" "<C-j>" "<C-\\><C-n><C-w>j" "Move to bottom window")
      (mkKeymap "t" "<C-k>" "<C-\\><C-n><C-w>k" "Move to top window")
      (mkKeymap "t" "<C-l>" "<C-\\><C-n><C-w>l" "Move to right window")
    ];
    
  in normal ++ visual ++ insert ++ terminal;
}


