{
  programs.nixvim.plugins = {
    lsp-lines.enable = true;
    lsp = {
      enable = true;
      servers = {
        nixd.enable = true;
        gopls.enable = true;
        pyright.enable = true;
        cmake.enable = true;
        ansiblels.enable = true;
        bashls.enable = true;
      };
    };
  };
}