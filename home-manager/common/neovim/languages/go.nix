{
  programs.nixvim = {
    plugins = {
      # Go-specific enhancements
      go = {
        enable = true;
        settings = {
          go_highlight_types = 1;
          go_highlight_fields = 1;
          go_highlight_functions = 1;
          go_highlight_function_calls = 1;
          go_highlight_operators = 1;
          go_highlight_extra_types = 1;
          go_highlight_methods = 1;
          go_highlight_generate_tags = 1;
          go_highlight_format_strings = 1;
          go_highlight_variable_declarations = 1;
          go_highlight_variable_assignments = 1;
          go_highlight_build_constraints = 1;
          go_auto_type_info = 1;
          go_auto_sameids = 1;
          go_fmt_command = "goimports";
          go_fmt_autosave = 1;
          go_fmt_fail_silently = 0;
          go_fmt_experimental = 1;
          go_imports_autosave = 1;
          go_imports_mode = "goimports";
          go_mod_fmt_autosave = 1;
          go_doc_popup_window = 1;
          go_def_mode = "gopls";
          go_info_mode = "gopls";
          go_referrers_mode = "gopls";
          go_implements_mode = "gopls";
          go_rename_command = "gopls";
          go_gopls_enabled = 1;
          go_gopls_options = ["-remote=auto"];
          go_gopls_deep_completion = 1;
          go_gopls_matcher = "fuzzy";
          go_gopls_use_placeholders = 1;
          go_gopls_complete_unimported = 1;
          go_gopls_staticcheck = 1;
          go_gopls_gofumpt = 1;
          go_template_autocreate = 0;
          go_textobj_enabled = 1;
          go_textobj_include_function_doc = 1;
          go_textobj_include_variable = 1;
          go_metalinter_enabled = ["vet" "golint" "errcheck"];
          go_metalinter_autosave = 1;
          go_metalinter_autosave_enabled = ["vet" "golint"];
          go_metalinter_deadline = "5s";
          go_list_type = "quickfix";
          go_list_autoclose = 1;
          go_asmfmt_autosave = 0;
          go_term_enabled = 1;
          go_term_mode = "split";
          go_term_height = 30;
          go_term_width = 30;
          go_term_close_on_exit = 0;
          go_alternate_mode = "edit";
          go_test_show_name = 0;
          go_test_timeout = "10s";
          go_test_prepend_name = 0;
          go_play_open_browser = 1;
          go_play_browser_command = "";
          go_snippet_engine = "automatic";
          go_get_update = 1;
          go_guru_scope = "";
          go_build_tags = "";
          go_autodetect_gopath = 1;
          go_loaded_gosnippets = 1;
          go_snippet_case_type = "camelcase";
        };
      };
    };
    
    # Go-specific autocommands
    autoCmd = [
      {
        event = ["FileType"];
        pattern = ["go"];
        callback.__raw = ''
          function()
            vim.opt_local.tabstop = 4
            vim.opt_local.shiftwidth = 4
            vim.opt_local.expandtab = false
            vim.opt_local.textwidth = 120
            vim.opt_local.colorcolumn = "120"
            vim.opt_local.commentstring = "// %s"
            
            -- Go-specific keymaps
            local opts = { buffer = true, silent = true }
            
            -- Building and running
            vim.keymap.set("n", "<leader>gb", ":GoBuild<CR>", opts)
            vim.keymap.set("n", "<leader>gr", ":GoRun<CR>", opts)
            vim.keymap.set("n", "<leader>gt", ":GoTest<CR>", opts)
            vim.keymap.set("n", "<leader>gT", ":GoTestFunc<CR>", opts)
            vim.keymap.set("n", "<leader>gc", ":GoCoverage<CR>", opts)
            vim.keymap.set("n", "<leader>gC", ":GoCoverageToggle<CR>", opts)
            
            -- Code navigation
            vim.keymap.set("n", "<leader>gd", ":GoDef<CR>", opts)
            vim.keymap.set("n", "<leader>gD", ":GoDefPop<CR>", opts)
            vim.keymap.set("n", "<leader>gi", ":GoInfo<CR>", opts)
            vim.keymap.set("n", "<leader>gI", ":GoImplements<CR>", opts)
            vim.keymap.set("n", "<leader>gR", ":GoReferrers<CR>", opts)
            vim.keymap.set("n", "<leader>gn", ":GoRename<CR>", opts)
            
            -- Documentation
            vim.keymap.set("n", "<leader>gk", ":GoDoc<CR>", opts)
            vim.keymap.set("n", "<leader>gK", ":GoDocBrowser<CR>", opts)
            
            -- Code generation
            vim.keymap.set("n", "<leader>ga", ":GoAlternate<CR>", opts)
            vim.keymap.set("n", "<leader>gA", ":GoAlternate!<CR>", opts)
            vim.keymap.set("n", "<leader>ge", ":GoIfErr<CR>", opts)
            vim.keymap.set("n", "<leader>gf", ":GoFillStruct<CR>", opts)
            vim.keymap.set("n", "<leader>gj", ":GoAddTags<CR>", opts)
            vim.keymap.set("n", "<leader>gJ", ":GoRemoveTags<CR>", opts)
            
            -- Formatting and imports
            vim.keymap.set("n", "<leader>gF", ":GoFmt<CR>", opts)
            vim.keymap.set("n", "<leader>gm", ":GoImports<CR>", opts)
            vim.keymap.set("n", "<leader>gM", ":GoImport ", opts)
            vim.keymap.set("n", "<leader>gp", ":GoDrop ", opts)
            
            -- Linting
            vim.keymap.set("n", "<leader>gl", ":GoLint<CR>", opts)
            vim.keymap.set("n", "<leader>gv", ":GoVet<CR>", opts)
            vim.keymap.set("n", "<leader>gE", ":GoErrCheck<CR>", opts)
            
            -- Debugging
            vim.keymap.set("n", "<leader>gB", ":GoDebugBreakpoint<CR>", opts)
            vim.keymap.set("n", "<leader>gS", ":GoDebugStart<CR>", opts)
            vim.keymap.set("n", "<leader>gQ", ":GoDebugStop<CR>", opts)
            
            -- Playground
            vim.keymap.set("n", "<leader>gP", ":GoPlay<CR>", opts)
            
            -- Module management
            vim.keymap.set("n", "<leader>go", ":!go mod init<CR>", opts)
            vim.keymap.set("n", "<leader>gu", ":!go mod tidy<CR>", opts)
            vim.keymap.set("n", "<leader>gU", ":!go get -u ./...<CR>", opts)
            vim.keymap.set("n", "<leader>gw", ":!go mod download<CR>", opts)
            vim.keymap.set("n", "<leader>gV", ":!go mod verify<CR>", opts)
            vim.keymap.set("n", "<leader>gg", ":!go generate ./...<CR>", opts)
            vim.keymap.set("n", "<leader>gG", ":!go get ", opts)
          end
        '';
      }
      
      {
        event = ["FileType"];
        pattern = ["gomod"];
        callback.__raw = ''
          function()
            vim.opt_local.tabstop = 4
            vim.opt_local.shiftwidth = 4
            vim.opt_local.expandtab = false
            
            -- Go mod specific keymaps
            local opts = { buffer = true, silent = true }
            vim.keymap.set("n", "<leader>gt", ":!go mod tidy<CR>", opts)
            vim.keymap.set("n", "<leader>gd", ":!go mod download<CR>", opts)
            vim.keymap.set("n", "<leader>gv", ":!go mod verify<CR>", opts)
            vim.keymap.set("n", "<leader>gg", ":!go mod graph<CR>", opts)
            vim.keymap.set("n", "<leader>gw", ":!go mod why ", opts)
          end
        '';
      }
    ];
    
    # Go user commands
    userCommands = {
      GoRun = {
        command = "!go run %";
        desc = "Run current Go file";
      };
      GoBuild = {
        command = "!go build";
        desc = "Build Go project";
      };
      GoTest = {
        command = "!go test ./...";
        desc = "Test Go project";
      };
      GoTestVerbose = {
        command = "!go test -v ./...";
        desc = "Test Go project (verbose)";
      };
      GoMod = {
        command = "!go mod tidy";
        desc = "Tidy Go modules";
      };
      GoModInit = {
        command = "!go mod init";
        desc = "Initialize Go module";
      };
      GoGet = {
        command = "!go get";
        desc = "Get Go dependencies";
      };
      GoFmt = {
        command = "!go fmt ./...";
        desc = "Format Go code";
      };
      GoVet = {
        command = "!go vet ./...";
        desc = "Vet Go code";
      };
      GoGenerate = {
        command = "!go generate ./...";
        desc = "Generate Go code";
      };
      GoClean = {
        command = "!go clean";
        desc = "Clean Go build cache";
      };
      GoDoc = {
        command = "!go doc";
        desc = "Show Go documentation";
      };
      GoVersion = {
        command = "!go version";
        desc = "Show Go version";
      };
      GoEnv = {
        command = "!go env";
        desc = "Show Go environment";
      };
    };
  };
}


