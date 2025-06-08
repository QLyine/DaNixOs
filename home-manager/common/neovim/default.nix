{ pkgs, inputs, system, ... }:
{
  imports = [
    # Core configuration
    ./core/options.nix
    ./core/keymaps.nix
    ./core/autocommands.nix
    
    ## Plugin configurations
    ./plugins/completion.nix
    ./plugins/lsp.nix
    ./plugins/treesitter.nix
    ./plugins/telescope.nix
    ./plugins/neotree.nix
    ./plugins/autopairs.nix
    ./plugins/trouble.nix
    ./plugins/neoclip.nix
    
    ### UI enhancements
    ./ui/lualine.nix
    ./ui/colorscheme.nix
    ./ui/bufferline.nix
    ./ui/indent-blankline.nix
    ./ui/noice.nix
    
    ## Development tools
    ./tools/git.nix
    #./tools/formatting.nix
    ./tools/debugging.nix
    ./tools/terminal.nix
    #./tools/project-management.nix
    
    ## Language-specific configurations
    ./languages/nix.nix
    ./languages/python.nix
    ./languages/rust.nix
    #./languages/go.nix
  ];

  programs.nixvim = {
    enable = true;

    plugins = {
      which-key = {
        enable = true;
      };
    };
    
    # Enable Lua loader for faster startup
    luaLoader.enable = true;
    
    # Performance optimizations
    performance = {
      byteCompileLua = {
        enable = true;
        nvimRuntime = true;
        plugins = true;
      };
    };
    
    # Clipboard configuration
    clipboard = pkgs.lib.mkMerge [
      (pkgs.lib.mkIf pkgs.stdenv.isLinux {
        providers.wl-copy.enable = true;
      })
      (pkgs.lib.mkIf pkgs.stdenv.isDarwin {
        providers.pbcopy.enable = true;
      })
    ];
    
    # Global variables
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };
    
    # Extra packages that might be needed
    extraPackages = with pkgs; [
      # Language servers and tools
      nil # Nix LSP
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted
      python3Packages.python-lsp-server
      rust-analyzer
      gopls
      
      # Formatters
      nixpkgs-fmt
      nodePackages.prettier
      black
      rustfmt
      #gofmt
      
      # Other tools
      ripgrep
      fd
      tree-sitter
      git
    ];
  };
}

