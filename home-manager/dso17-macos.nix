{ pkgs, lib, config, username, inputs, ... }:

let
  # Work-specific private Go modules
  goPrivateModules = "github.com/NBCUDTC/*,github.com/sky-uk/*,github.com-nbcudtc/*,github.com/nbcudtc/*";

  # Custom shell scripts
  jfrogLoginScript = pkgs.writeShellScriptBin "jfrog-cli-login" ''
    jf login
    export ARTIFACTSTORE_URL=https://artifactory.tools.gspcloud.com
    export ARTIFACTSTORE_USER=$(jq '.servers[] | select(.serverId == "artifactstore").user' -r ~/.jfrog/jfrog-cli.conf.v6)
    export ARTIFACTSTORE_TOKEN=$(jq '.servers[] | select(.serverId == "artifactstore").accessToken' -r ~/.jfrog/jfrog-cli.conf.v6)
  '';
in
{
  # ==========================================================================
  # Home Manager Core Settings
  # ==========================================================================

  home = {
    username = username;
    homeDirectory = "/Users/${username}";
    stateVersion = "25.11";

    sessionVariables = {
      EDITOR = "nvim";
      PAGER = "less";
      GOPRIVATE = goPrivateModules;
    };

    packages = with pkgs; [
      home-manager
      jfrog-cli
      jfrogLoginScript
    ];

    # Factory CLI requires ripgrep symlink
    file.".factory/bin/rg".source = "${pkgs.ripgrep}/bin/rg";
  };

  # ==========================================================================
  # Module Imports
  # ==========================================================================

  imports = [
    inputs.factory-cli-nix.homeManagerModules.default
    { services.factory-cli.enable = true; }
    ./common/cli
    ./common/neovim
  ];

  # ==========================================================================
  # Programs Configuration
  # ==========================================================================

  programs.git = {
    enable = true;
    userName = "Daniel Santos";
    userEmail = "daniel.santos@sky.uk";
    extraConfig = {
      init.defaultBranch = "master";
      core.editor = "nvim";
      url."git@github.com:NBCUDTC/spell".insteadOf = "https://github.com/NBCUDTC/spell";
    };
  };

  programs.zsh = {
    sessionVariables.GOPRIVATE = goPrivateModules;
    shellAliases.augie = "npx @augmentcode/auggie";
  };

  # ==========================================================================
  # Secrets Management (SOPS)
  # ==========================================================================

  sops = {
    defaultSopsFile = ../secrets/user/secrets.d/claude.yaml;
    defaultSopsFormat = "yaml";
    age = {
      keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
      generateKey = false;
    };
    secrets = { };
  };
}
