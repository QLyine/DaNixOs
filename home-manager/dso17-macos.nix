{ pkgs, lib, config, username, inputs, ... }:

{
  # Home Manager configuration for macOS user dso17 (standalone)
  home.username = username;
  home.homeDirectory = "/Users/${username}";

  # Set the state version. It's important to set this and bump it periodically.
  # When you bump this, Home Manager will consider all of your managed files
  # and configurations as "new" and might overwrite existing ones if they differ.
  home.stateVersion = "25.11"; # Set to your current Nixpkgs version or a preferred starting point

  imports = [
    inputs.factory-cli-nix.homeManagerModules.default
    { services.factory-cli.enable = true; }
    ./common/cli
    ./common/neovim
  ];

  # Create symlinks in ~/.factory/bin
  # This is needed for the factory-cli-nix module to work.
  home.file.".factory/bin/rg".source = "${pkgs.ripgrep}/bin/rg";


  # Git configuration
  programs.git = {
    enable = true;
    userName = "Daniel Santos"; # Replace with your actual name
    userEmail = "daniel.santos@sky.uk"; # Replace with your actual email
    extraConfig = {
      init.defaultBranch = "master";
      core.editor = "nvim";
      url."git@github.com:NBCUDTC/spell".insteadOf = "https://github.com/NBCUDTC/spell";
    };
  };

  # Set environment variables
  home.sessionVariables = {
    EDITOR = "nvim";
    PAGER = "less";
    GOPRIVATE = "github.com/NBCUDTC/*,github.com/sky-uk/*,github.com-nbcudtc/*,github.com/nbcudtc/*";
  };

  programs.zsh.sessionVariables = {
    GOPRIVATE = "github.com/NBCUDTC/*,github.com/sky-uk/*,github.com-nbcudtc/*,github.com/nbcudtc/*";
  };

  # SOPS-nix configuration
  sops = {
    defaultSopsFile = ../secrets/user/secrets.d/claude.yaml;
    defaultSopsFormat = "yaml";
    age = {
      keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
      generateKey = false;
    };

    # Define secrets (will be handled by the claude.nix module)
    secrets = {};
  };

  home.packages = with pkgs; [
    home-manager
  ];
}

