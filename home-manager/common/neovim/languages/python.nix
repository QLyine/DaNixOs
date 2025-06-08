{
  programs.nixvim = {
    autoCmd = [
      {
        event = ["FileType"];
        pattern = ["python"];
        callback.__raw = ''
          function()
            vim.opt_local.tabstop = 4
            vim.opt_local.shiftwidth = 4
            vim.opt_local.expandtab = true
            vim.opt_local.textwidth = 88
            vim.opt_local.colorcolumn = "88"
            vim.opt_local.commentstring = "# %s"
            
            -- Python-specific keymaps
            local opts = { buffer = true, silent = true }
            
            -- Running Python
            vim.keymap.set("n", "<leader>pr", ":!python3 %<CR>", opts)
            vim.keymap.set("n", "<leader>pi", ":!python3 -i %<CR>", opts)
            
            -- Testing
            vim.keymap.set("n", "<leader>pt", ":!python3 -m pytest %<CR>", opts)
            vim.keymap.set("n", "<leader>pT", ":!python3 -m pytest<CR>", opts)
            
            -- Virtual environment
            vim.keymap.set("n", "<leader>pv", ":!python3 -m venv venv<CR>", opts)
            vim.keymap.set("n", "<leader>pa", ":!source venv/bin/activate<CR>", opts)
            
            -- Package management
            vim.keymap.set("n", "<leader>pp", ":!pip install -r requirements.txt<CR>", opts)
            vim.keymap.set("n", "<leader>pf", ":!pip freeze > requirements.txt<CR>", opts)
            
            -- Formatting and linting
            vim.keymap.set("n", "<leader>pb", ":!black %<CR>", opts)
            vim.keymap.set("n", "<leader>pI", ":!isort %<CR>", opts)
            vim.keymap.set("n", "<leader>pF", ":!flake8 %<CR>", opts)
            vim.keymap.set("n", "<leader>pm", ":!mypy %<CR>", opts)
            
            -- Docstring generation
            vim.keymap.set("n", "<leader>pd", ":Pydocstring<CR>", opts)
            
            -- REPL
            vim.keymap.set("n", "<leader>ps", ":IronRepl<CR>", opts)
            vim.keymap.set("n", "<leader>pR", ":IronRestart<CR>", opts)
          end
        '';
      }
      
      # Auto-activate virtual environment
      {
        event = ["BufEnter"];
        pattern = ["*.py"];
        callback.__raw = ''
          function()
            local cwd = vim.fn.getcwd()
            local venv_path = cwd .. "/venv/bin/python"
            local venv_path_alt = cwd .. "/.venv/bin/python"
            
            if vim.fn.executable(venv_path) == 1 then
              vim.g.python3_host_prog = venv_path
            elseif vim.fn.executable(venv_path_alt) == 1 then
              vim.g.python3_host_prog = venv_path_alt
            end
          end
        '';
      }
    ];
    
    # Python user commands
    userCommands = {
      PythonRun = {
        command = "!python3 %";
        desc = "Run current Python file";
      };
      PythonTest = {
        command = "!python3 -m pytest %";
        desc = "Test current Python file";
      };
      PythonTestAll = {
        command = "!python3 -m pytest";
        desc = "Run all Python tests";
      };
      PythonVenv = {
        command = "!python3 -m venv venv";
        desc = "Create Python virtual environment";
      };
      PythonRequirements = {
        command = "!pip freeze > requirements.txt";
        desc = "Generate requirements.txt";
      };
      PythonInstall = {
        command = "!pip install -r requirements.txt";
        desc = "Install from requirements.txt";
      };
      PythonFormat = {
        command = "!black % && isort %";
        desc = "Format current Python file";
      };
      PythonLint = {
        command = "!flake8 % && mypy %";
        desc = "Lint current Python file";
      };
    };
  };
}


