{
  programs.nixvim.opts = {
    # Performance
    updatetime = 100;
    timeoutlen = 300;
    
    # Line numbers
    number = true;
    relativenumber = true;
    
    # Mouse support
    mouse = "a";
    mousemodel = "extend";
    
    # File handling
    swapfile = false;
    backup = false;
    undofile = true;
    undodir = "/tmp/.vim-undo-dir";
    
    # Search
    incsearch = true;
    inccommand = "split";
    ignorecase = true;
    smartcase = true;
    hlsearch = true;
    
    # Display
    cursorline = true;
    cursorcolumn = false;
    signcolumn = "yes";
    colorcolumn = "100";
    scrolloff = 8;
    sidescrolloff = 8;
    
    # Encoding
    fileencoding = "utf-8";
    encoding = "utf-8";
    
    # Text wrapping
    wrap = false;
    breakindent = true;
    breakindentopt = "shift:2";
    showbreak = "↳";
    
    # Indentation
    tabstop = 2;
    shiftwidth = 2;
    softtabstop = 2;
    expandtab = true;
    autoindent = true;
    smartindent = true;
    
    # Folding
    foldlevel = 99;
    foldmethod = "expr";
    foldexpr = "nvim_treesitter#foldexpr()";
    foldlevelstart = 99;
    foldenable = true;
    foldcolumn = "1";
    
    # Completion
    completeopt = ["menu" "menuone" "noselect"];
    pumheight = 10;
    
    # Split behavior
    splitbelow = true;
    splitright = true;
    
    # Command line
    cmdheight = 1;
    showmode = false;
    
    # Misc
    hidden = true;
    confirm = true;
    termguicolors = true;
    laststatus = 3; # Global statusline
    showtabline = 2;
    
    # Spell checking
    spell = false;
    spelllang = ["en_us"];
    
    # Whitespace characters
    list = true;
    listchars = "tab:→ ,trail:·,extends:…,precedes:…,nbsp:␣";
    
    # Session options
    sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions";
  };
}


