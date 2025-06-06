{ pkgs, lib, config, username, inputs, ... }:

{
  # Home Manager configuration for macOS user dso17 (standalone)
  home.username = username;
  home.homeDirectory = "/Users/${username}";

  # Set the state version. It's important to set this and bump it periodically.
  # When you bump this, Home Manager will consider all of your managed files
  # and configurations as "new" and might overwrite existing ones if they differ.
  home.stateVersion = "25.05"; # Set to your current Nixpkgs version or a preferred starting point

  imports = [
    ./common/cli
    ./common/neovim
  ];


  # Git configuration
  programs.git = {
    enable = true;
    userName = "Daniel Santos"; # Replace with your actual name
    userEmail = "daniel.santos@sky.uk"; # Replace with your actual email
    extraConfig = {
      init.defaultBranch = "main";
      core.editor = "nvim";
    };
  };

  # Set environment variables
  home.sessionVariables = {
    EDITOR = "nvim";
    PAGER = "less";
    # XDG_CONFIG_HOME = "${config.home.homeDirectory}/.config"; # Already default
  };

  home.packages = with pkgs; [
    home-manager
  ];
} 