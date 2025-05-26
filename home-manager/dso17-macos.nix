{ pkgs, lib, config, username, inputs, ... }:

{
  # Home Manager configuration for macOS user dso17 (standalone)
  home.username = username;
  home.homeDirectory = "/Users/${username}";

  # Set the state version. It's important to set this and bump it periodically.
  # When you bump this, Home Manager will consider all of your managed files
  # and configurations as "new" and might overwrite existing ones if they differ.
  home.stateVersion = "23.11"; # Set to your current Nixpkgs version or a preferred starting point

  # Packages to install
  home.packages = with pkgs; [
    # CLI tools
    bat       # cat clone with syntax highlighting and Git integration
    exa       # Modern replacement for ls
    fd        # Simple, fast and user-friendly alternative to find
    fzf       # Command-line fuzzy finder
    git
    htop      # Interactive process viewer
    jq        # Command-line JSON processor
    ripgrep   # Recursively searches directories for a regex pattern
    tmux      # Terminal multiplexer
    neovim    # Vim-based text editor
    zsh       # Shell
    starship  # Minimal, blazing-fast, and infinitely customizable prompt

    # GUI Apps (via nix-darwin's homebrew or if available directly in nixpkgs for darwin)
    # Example: (if you had nix-darwin, but for standalone you'd manage these differently or look for them in nixpkgs-unstable)
    # pkgs.iterm2
    # pkgs.visual-studio-code
  ];

  # Shell configuration (Zsh)
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    # To use Oh My Zsh or other frameworks, you might need to manage them manually
    # or use a Nix package if available (e.g., pkgs.oh-my-zsh).
    # ohMyZsh.enable = true; # This specific option requires a Home Manager module for Oh My Zsh

    # Example of setting an alias
    shellAliases = {
      ll = "exa -l -g --icons";
      l = "exa -g --icons";
      la = "exa -la -g --icons";
    };
  };

  # Starship prompt configuration
  programs.starship = {
    enable = true;
    enableZshIntegration = true; # Ensure this is true if you use Zsh
    # Example customization (refer to Starship docs for more)
    # settings = {
    #   character = {
    #     success_symbol = "[➜](bold green)";
    #     error_symbol = "[✗](bold red)";
    #   };
    # };
  };

  # Git configuration
  programs.git = {
    enable = true;
    userName = "Your Name"; # Replace with your actual name
    userEmail = "your.email@example.com"; # Replace with your actual email
    extraConfig = {
      init.defaultBranch = "main";
      core.editor = "nvim";
    };
  };

  # Files and directories to be managed by Home Manager
  # home.file.".config/nvim/init.vim".text = ''
  #   set nu
  #   set rnu
  # '';

  # You can import other common configurations if you have them
  # imports = [ ./common/common-aliases.nix ];

  # Set environment variables
  home.sessionVariables = {
    EDITOR = "nvim";
    PAGER = "less";
    # XDG_CONFIG_HOME = "${config.home.homeDirectory}/.config"; # Already default
  };

} 