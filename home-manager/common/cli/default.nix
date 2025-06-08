{ config, pkgs, system, inputs, ... }:

{
  programs = {
    zellij = {
      enable = true;
      enableZshIntegration = true;
    };
    eza = {
      enable = true;
      icons = "auto";
      enableZshIntegration = true;
    };
    starship = {
      enable = true;
      enableZshIntegration = true;
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    zsh = {
      enable = true;
      syntaxHighlighting.enable = true;
      autosuggestion.enable = true;
      shellAliases = {
        "ls" = "eza";
        "ll" = "eza -l";
        "l" = "eza -l";
        "la" = "eza -la";
        "tree" = "eza --tree";
        "grcm" = "git reset --hard HEAD ; (git checkout master || git checkout main) ; git fetch --all ; git pull ; (git reset --hard origin/master || git reset --hard origin/main)";
        "v" = "nvim";
        "vim" = "nvim";
      };
      sessionVariables = {
        EDITOR = "vim";
        TERM = "xterm-256color";
      };
      zplug = {
        enable = true;
        plugins = [
          { name = "tj/git-extras"; }
          { name = "hlissner/zsh-autopair";}
          { name = "spwhitt/nix-zsh-completions";}
          { name = "Aloxaf/fzf-tab";}
          { name = "bonnefoa/kubectl-fzf";}
        ];
      };
    };
    zsh.oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "sudo"
        "docker"
        "podman"
        "history"
        "gradle"
        "kubectl"
        "git-extras"
      ];
      theme = "robbyrussell";
    };
    bat = {
      enable = true;
      config = {
        map-syntax = [
          "*.jenkinsfile:Groovy"
          "*.props:Java Properties"
        ];
        pager = "less -FR";
        theme = "TwoDark";
      };
    };
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };

  home.sessionPath = [
    "$HOME/bin"
    # GOLang Paths
    "$HOME/go"
    "$HOME/go/bin"
  ];

  home.packages = with pkgs; [
    bat
    eza
    fd
    fzf
    git
    git-extras
    htop
    jq
    yq
    ripgrep
    tmux
    starship
    dnsutils
    kubectx
    claude-code
    nixd
    nixpkgs-fmt
  ];
} 
