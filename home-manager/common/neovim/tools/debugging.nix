{
  programs.nixvim.plugins = {
    # DAP (Debug Adapter Protocol)
    dap = {
      enable = true;
      
      
      configurations = {
        python = [
          {
            type = "python";
            request = "launch";
            name = "Launch file";
            program = "\${file}";
            pythonPath.__raw = ''
              function()
                local cwd = vim.fn.getcwd()
                if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
                  return cwd .. '/venv/bin/python'
                elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
                  return cwd .. '/.venv/bin/python'
                else
                  return '/usr/bin/python3'
                end
              end
            '';
          }
          {
            type = "python";
            request = "launch";
            name = "Launch file with arguments";
            program = "\${file}";
            args.__raw = ''
              function()
                return vim.split(vim.fn.input('Arguments: '), ' ')
              end
            '';
            pythonPath.__raw = ''
              function()
                local cwd = vim.fn.getcwd()
                if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
                  return cwd .. '/venv/bin/python'
                elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
                  return cwd .. '/.venv/bin/python'
                else
                  return '/usr/bin/python3'
                end
              end
            '';
          }
        ];
        
        rust = [
          {
            type = "lldb";
            request = "launch";
            name = "Debug";
            program.__raw = ''
              function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
              end
            '';
            cwd = "\${workspaceFolder}";
            stopOnEntry = false;
            args = {};
          }
        ];
        
        go = [
          {
            type = "go";
            name = "Debug";
            request = "launch";
            program = "\${file}";
          }
          {
            type = "go";
            name = "Debug test";
            request = "launch";
            mode = "test";
            program = "\${file}";
          }
          {
            type = "go";
            name = "Debug test (go.mod)";
            request = "launch";
            mode = "test";
            program = "./\${relativeFileDirname}";
          }
        ];
      };
    };

    dap-ui = {
      enable = true;
      settings = {
        icons = {
          expanded = "";
          collapsed = "";
          current_frame = "";
        };
        mappings = {
          expand = ["<CR>" "<2-LeftMouse>"];
          open = "o";
          remove = "d";
          edit = "e";
          repl = "r";
          toggle = "t";
        };
        element_mappings = {};
        expand_lines = true;
        layouts = [
          {
            elements = [
              {
                id = "scopes";
                size = 0.25;
              }
              {
                id = "breakpoints";
                size = 0.25;
              }
              {
                id = "stacks";
                size = 0.25;
              }
              {
                id = "watches";
                size = 0.25;
              }
            ];
            position = "left";
            size = 40;
          }
          {
            elements = [
              {
                id = "repl";
                size = 0.5;
              }
              {
                id = "console";
                size = 0.5;
              }
            ];
            position = "bottom";
            size = 10;
          }
        ];
        controls = {
          enabled = true;
          element = "repl";
          icons = {
            pause = "";
            play = "";
            step_into = "";
            step_over = "";
            step_out = "";
            step_back = "";
            run_last = "";
            terminate = "";
            disconnect = "";
          };
        };
        floating = {
          max_height = null;
          max_width = null;
          border = "single";
          mappings = {
            close = ["q" "<Esc>"];
          };
        };
        windows = {
          indent = 1;
        };
        render = {
          max_type_length = null;
          max_value_lines = 100;
        };
      };
    };
    
    dap-virtual-text = {
      enable = true;
      settings = {
        enabled = true;
        enabled_commands = true;
        highlight_changed_variables = true;
        highlight_new_as_changed = false;
        show_stop_reason = true;
        commented = false;
        only_first_definition = true;
        all_references = false;
        clear_on_continue = false;
        display_callback.__raw = ''
          function(variable, buf, stackframe, node, options)
            if options.virt_text_pos == 'inline' then
              return ' = ' .. variable.value
            else
              return variable.name .. ' = ' .. variable.value
            end
          end
        '';
        virt_text_pos = "eol";
        all_frames = false;
        virt_lines = false;
        virt_text_win_col = null;
      };
    };
    
    dap-python = {
      enable = true;
      settings = {
        adapter = "python";
        configurations = [
          {
            type = "python";
            request = "launch";
            name = "Launch file";
            program = "\${file}";
            pythonPath.__raw = ''
              function()
                return '/usr/bin/python3'
              end
            '';
          }
        ];
      };
    };
    
    dap-go = {
      enable = true;
      settings = {
        delve = {
          path = "dlv";
          initialize_timeout_sec = 20;
          port = "\${port}";
          args = [];
          build_flags = "";
        };
      };
    };
  };
}


