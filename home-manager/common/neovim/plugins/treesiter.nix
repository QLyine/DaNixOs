{
  programs.nixvim.plugins.treesitter = {
    enable = true;
    settings.ensureInstalled = [
      "bash"
      "go"
      "python"
      "nix"
      "ansible"
      "cmake"
      "json"
      "yaml"
      "toml"
      "dockerfile"
    ];
  };
}