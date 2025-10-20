{ config, pkgs, system, inputs, ... }:

{
  imports = [
    ./atuin.nix
    ./zellij.nix
  ];

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
      settings = {
        kubernetes = {
          disabled = false;
        };
        ruby.disabled = true;
        python.disabled = true;
      };
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
        "bpy" = "bat --paging=always --language=yaml";
        "bpj" = "bat --paging=always --language=json";
      };
      sessionVariables = {
        EDITOR = "nvim";
        TERM = "xterm-256color";
      };
      zplug = {
        enable = true;
        plugins = [
          { name = "tj/git-extras"; }
          { name = "hlissner/zsh-autopair"; }
          { name = "spwhitt/nix-zsh-completions"; }
          { name = "Aloxaf/fzf-tab"; }
          { name = "bonnefoa/kubectl-fzf"; }
        ];
      };
      initContent = ''
        source ${./zsh-functions/gcm.zsh}
      '';
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
    carapace = {
      enable = false;
      enableZshIntegration = false;
    };
  };

  home.sessionPath = [
    "$HOME/bin"
    # GOLang Paths
    "$HOME/go"
    "$HOME/go/bin"
    "$HOME/.krew/bin"
  ];

  programs.git = {
    aliases = {
      # 🔭 Clean, readable log (current branch)
      l = "log --graph --abbrev-commit --date=human --pretty";
      # 🌳 See everything (all branches)
      lg = "log --graph --all --abbrev-commit --date=human --pretty";
      # 🏷  Only the commits that have refs (tags/branch tips), super scannable
      lt = "log --graph --abbrev-commit --simplify-by-decoration --decorate --date=human --pretty --tags";
      # 🏷▶ Semantic-tag walk: traverse starting from tags in semver order (uses shell function alias)
      lv = "!f(){ git log --graph --abbrev-commit --decorate --date=human --pretty $(git tag --sort=v:refname); }; f";
      # 🆚 Compare two refs visually: git lrange v1.2.0 v1.3.0
      lrange = "!f(){ git log --graph --abbrev-commit --decorate --date=human --pretty \"$1..$2\"; }; f";
      # ⏭ Since last tag: what changed after the most recent tag?
      lsince = "!f(){ t=$(git describe --tags --abbrev=0); git log --graph --abbrev-commit --decorate --date=human --pretty \"$t..HEAD\"; }; f";
      # 🔎 Show tag objects themselves (messages/annotations), semver-sorted
      tshow = "!f(){ for t in $(git tag --sort=v:refname); do echo; echo \"# $t\"; git show -s --pretty='%C(auto)%h %Cgreen%ad %Creset%C(yellow)%d%Creset %s' --date=human \"$t\"; done; }; f";
      # 🧮 List tags semantically (no commits)
      tagsv = "tag --list --sort=v:refname";
    };
    extraConfig = {
      pager = {
        log = "nvimpager";
      };
    };
  };

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
    unzip
    nodejs_24
    krew
    nvimpager
    gemini-cli
  ];
}
