{
  programs.nixvim.opts = {
    updatetime = 100;

    relativenumber = true;
    number = true;

    mouse = "a";
    mousemodel = "extend";


    swapfile = false; # Disable the swap file

    modeline = true; # Tags such as 'vim:ft=sh'
    modelines = 100; # Sets the type of modelines

    undofile = true; # Automatically save and restore undo history

    incsearch = true; # Incremental search: show match for partly typed search command

    inccommand = "split"; # Search and replace: preview changes in quickfix list
    ignorecase = true; # When the search query is lower-case, match both lower and upper-case
    smartcase = true; # Override the 'ignorecase' option if the search pattern contains upper

    hlsearch = true; # Highlight all matches on previous search pattern

    cursorline = false; # Highlight the screen line of the cursor
    cursorcolumn = false; # Highlight the screen column of the cursor
    signcolumn = "yes"; # Whether to show the signcolumn
    colorcolumn = "100"; # Columns to highlight

    fileencoding = "utf-8"; # File-content encoding for the current buffer

    spell = false; # Highlight spelling mistakes (local to window)
    wrap = false; # Prevent text from wrapping

    breakindent = true; # Enable break indent
    breakindentopt = "shift:2"; # Indent wrapped lines by 2 spaces
    showbreak = "↳"; # Show a marker for wrapped lines


    tabstop = 2; # Number of spaces a <Tab> in the text stands for (local to buffer)
    shiftwidth = 2; # Number of spaces used for each step of (auto)indent (local to buffer)
    expandtab = true; # Expand <Tab> to spaces in Insert mode (local to buffer)
    autoindent = true; # Do clever autoindenting


    textwidth = 0; # Maximum width of text that is being inserted.  A longer line will be

    foldlevel = 99; # Folds with a level higher than this number will be closed

    foldmethod = "indent"; # Fold based on indent level
    foldlevelstart = 99; # Start with all folds closed

    foldenable = true; # Enable folding

    foldcolumn = "1"; # Show the fold column

  };
}