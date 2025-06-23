{
  programs.nixvim.plugins.neo-tree = {
    enable = true;

    # Close if last window
    closeIfLastWindow = true;

    # Popup border style
    popupBorderStyle = "rounded";

    # Enable diagnostics
    enableDiagnostics = true;

    # Enable git status
    enableGitStatus = true;

    # Enable modified markers
    enableModifiedMarkers = true;

    # Enable refresh on write
    enableRefreshOnWrite = true;

    # Git status async
    gitStatusAsync = true;

    # Log level
    logLevel = "info";

    # Log to file
    logToFile = false;

    # Sort case insensitive
    sortCaseInsensitive = false;

    # Default component configs
    defaultComponentConfigs = {
      container = {
        enableCharacterFade = true;
      };

      indent = {
        indentSize = 2;
        padding = 1;
        withMarkers = true;
        indentMarker = "│";
        lastIndentMarker = "└";
        highlight = "NeoTreeIndentMarker";
        withExpanders = null;
        expanderCollapsed = "";
        expanderExpanded = "";
        expanderHighlight = "NeoTreeExpander";
      };

      icon = {
        folderClosed = "";
        folderOpen = "";
        folderEmpty = "󰜌";
        folderEmptyOpen = "󰜌";
        default = "*";
        highlight = "NeoTreeFileIcon";
      };

      modified = {
        symbol = "[+]";
        highlight = "NeoTreeModified";
      };

      name = {
        trailingSlash = false;
        useGitStatusColors = true;
        highlight = "NeoTreeFileName";
      };

      gitStatus = {
        symbols = {
          added = "✚";
          modified = "";
          deleted = "✖";
          renamed = "󰁕";
          untracked = "";
          ignored = "";
          unstaged = "󰄱";
          staged = "";
          conflict = "";
        };
      };

    };

    # Window settings
    window = {
      position = "left";
      width = 40;
      mappingOptions = {
        noremap = true;
        nowait = true;
      };

      mappings = {
        "<space>" = {
          command = "toggle_node";
          nowait = false;
        };
        "<2-LeftMouse>" = "open";
        "<cr>" = "open";
        "<esc>" = "cancel";
        "P" = {
          command = "toggle_preview";
          config = {
            use_float = true;
            use_image_nvim = true;
          };
        };
        "l" = "focus_preview";
        "s" = "open_split";
        "v" = "open_vsplit";
        "t" = "open_tabnew";
        "w" = "open_with_window_picker";
        "C" = "close_node";
        "z" = "close_all_nodes";
        "a" = {
          command = "add";
          config = {
            show_path = "none";
          };
        };
        "A" = "add_directory";
        "d" = "delete";
        "r" = "rename";
        "y" = "copy_to_clipboard";
        "x" = "cut_to_clipboard";
        "p" = "paste_from_clipboard";
        "c" = "copy";
        "m" = "move";
        "q" = "close_window";
        "R" = "refresh";
        "?" = "show_help";
        "<" = "prev_source";
        ">" = "next_source";
        "i" = "show_file_details";
      };
    };

    # Nesting rules
    nestingRules = { };

    # Filesystem settings
    filesystem = {
      filteredItems = {
        visible = false;
        hideDotfiles = true;
        hideGitignored = true;
        hideHidden = true;
        hideByName = [
          ".DS_Store"
          "thumbs.db"
        ];
        hideByPattern = [
          "*.meta"
          "*/src/*/tsconfig.json"
        ];
        alwaysShow = [
          ".gitignored"
        ];
        neverShow = [
          ".DS_Store"
          "thumbs.db"
        ];
        neverShowByPattern = [
          ".null-ls_*"
        ];
      };

      followCurrentFile = {
        enabled = true;
        leaveDirsOpen = true;
      };

      groupEmptyDirs = false;
      hijackNetrwBehavior = "open_default";
      useLibuvFileWatcher = false;

      window = {
        mappings = {
          "<bs>" = "navigate_up";
          "." = "set_root";
          "H" = "toggle_hidden";
          "/" = "fuzzy_finder";
          "D" = "fuzzy_finder_directory";
          "#" = "fuzzy_sorter";
          "f" = "filter_on_submit";
          "<c-x>" = "clear_filter";
          "[g" = "prev_git_modified";
          "]g" = "next_git_modified";
          "o" = {
            command = "system_open";
          };
          "Y" = {
            command = "copy_selector";
          };
        };
      };
    };

    # Buffers settings
    buffers = {
      followCurrentFile = {
        enabled = true;
        leaveDirsOpen = false;
      };
      groupEmptyDirs = true;

      window = {
        mappings = {
          "bd" = "buffer_delete";
          "<bs>" = "navigate_up";
          "." = "set_root";
          "o" = {
            command = "system_open";
          };
          "Y" = {
            command = "copy_selector";
          };
        };
      };
    };

    # Git status settings
    gitStatus = {
      window = {
        mappings = {
          "A" = "git_add_all";
          "gu" = "git_unstage_file";
          "ga" = "git_add_file";
          "gr" = "git_revert_file";
          "gc" = "git_commit";
          "gp" = "git_push";
          "gg" = "git_commit_and_push";
          "o" = {
            command = "system_open";
          };
          "Y" = {
            command = "copy_selector";
          };
        };
      };
    };
  };
}


