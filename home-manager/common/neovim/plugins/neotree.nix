{
  programs.nixvim.plugins.neo-tree = {
    enable = true;

    settings = {
      # Close if last window
      close_if_last_window = true;

      # Popup border style
      popup_border_style = "rounded";

      # Enable diagnostics
      enable_diagnostics = true;

      # Enable git status
      enable_git_status = true;

      # Enable modified markers
      enable_modified_markers = true;

      # Enable refresh on write
      enable_refresh_on_write = true;

      # Git status async
      git_status_async = true;

      # Log level
      log_level = "info";

      # Log to file
      log_to_file = false;

      # Sort case insensitive
      sort_case_insensitive = false;

      # Default component configs
      default_component_configs = {
        container = {
          enable_character_fade = true;
        };

        indent = {
          indent_size = 2;
          padding = 1;
          with_markers = true;
          indent_marker = "│";
          last_indent_marker = "└";
          highlight = "NeoTreeIndentMarker";
          with_expanders = null;
          expander_collapsed = "";
          expander_expanded = "";
          expander_highlight = "NeoTreeExpander";
        };

        icon = {
          folder_closed = "";
          folder_open = "";
          folder_empty = "󰜌";
          folder_empty_open = "󰜌";
          default = "*";
          highlight = "NeoTreeFileIcon";
        };

        modified = {
          symbol = "[+]";
          highlight = "NeoTreeModified";
        };

        name = {
          trailing_slash = false;
          use_git_status_colors = true;
          highlight = "NeoTreeFileName";
        };

        git_status = {
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
        mapping_options = {
          noremap = true;
        };
      };

      # Nesting rules
      nesting_rules = { };

      # Filesystem settings
      filesystem = {
        filtered_items = {
          visible = false;
          hide_dotfiles = true;
          hide_gitignored = true;
          hide_hidden = true;
          hide_by_name = [
            ".DS_Store"
            "thumbs.db"
          ];
          hide_by_pattern = [
            "*.meta"
            "*/src/*/tsconfig.json"
          ];
          always_show = [
            ".gitignored"
          ];
          never_show = [
            ".DS_Store"
            "thumbs.db"
          ];
          never_show_by_pattern = [
            ".null-ls_*"
          ];
        };

        follow_current_file = {
          enabled = true;
          leave_dirs_open = true;
        };

        group_empty_dirs = false;
        hijack_netrw_behavior = "open_default";
        use_libuv_file_watcher = false;
      };

      # Buffers settings
      buffers = {
        follow_current_file = {
          enabled = true;
          leave_dirs_open = false;
        };
        group_empty_dirs = true;
      };

      # Mappings structure
      # Main window mappings
      window = {
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

      # Filesystem window mappings
      filesystem = {
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

      # Buffers window mappings
      buffers = {
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

      # Git status window mappings (note: snake_case)
      git_status = {
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
  };
}


