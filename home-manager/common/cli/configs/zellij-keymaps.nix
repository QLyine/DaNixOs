{ lib, ... }:

let
  # Convert a single mode's keymap into Zellij-compliant format
  mkModeKeybinds = modeMap:
    lib.mapAttrs'
      (key: action: {
        name = "bind \"${key}\"";
        value = action;
      })
      modeMap;

  # Convert all modes
  mkAllKeybinds = modes:
    lib.mapAttrs (mode: keyMap: mkModeKeybinds keyMap) modes;

  # GO To Tab
  tabGoTo =
    builtins.listToAttrs (
      builtins.genList
        (i:
          let idx = toString i;
          in {
            name = "${idx}";
            value = { GoToTab = i; SwitchToMode = "Normal"; };
          })
        9
    );
in
mkAllKeybinds {
  entersearch = {
    "Ctrl c" = { SwitchToMode = "Normal"; };
    "Enter" = {
      SwitchToMode = "Search";
      SearchToggleOption = "CaseSensitivity";
    };
  };

  search = {
    "Esc" = { SwitchToMode = "Normal"; };
    "n" = { Search = "down"; };
    "N" = { Search = "up"; };
    "e" = { "EditScrollback; SwitchToMode" = "Normal"; };
    "c" = { SearchToggleOption = "CaseSensitivity"; };
    "o" = { SearchToggleOption = "WholeWord"; };
    "w" = { SearchToggleOption = "Wrap"; };
  };

  tmux = {
    "f" = { "ToggleFloatingPanes; SwitchToMode" = "Normal"; };
    "Esc" = { "Write 2; SwitchToMode" = "Normal"; };
    "[" = { SwitchToMode = "Scroll"; };
    "s" = { NewPane = "Down"; SwitchToMode = "Normal"; };
    "v" = { NewPane = "Right"; SwitchToMode = "Normal"; };
    "z" = { "ToggleFocusFullscreen; SwitchToMode" = "Normal"; };
    "c" = { "NewTab; SwitchToMode" = "Normal"; };
    "," = { SwitchToMode = "RenameTab"; };
    "p" = { "GoToPreviousTab; SwitchToMode" = "Normal"; };
    "n" = { "GoToNextTab; SwitchToMode" = "Normal"; };

    "h" = { MoveFocus = "Left"; SwitchToMode = "Normal"; };
    "j" = { MoveFocus = "Down"; SwitchToMode = "Normal"; };
    "k" = { MoveFocus = "Up"; SwitchToMode = "Normal"; };
    "l" = { MoveFocus = "Right"; SwitchToMode = "Normal"; };

    "d" = { "Detach; SwitchToMode" = "Normal"; };
    "x" = { "CloseFocus; SwitchToMode" = "Normal"; };

    "w" = {
      "LaunchOrFocusPlugin \"session-manager\"" = {
        floating = true;
        move_to_focused_tab = true;
      };
      SwitchToMode = "Normal";
    };
  };

  scroll = {
    "Esc" = { SwitchToMode = "Normal"; };
    "e" = { "EditScrollback; SwitchToMode" = "Normal"; };
    "Ctrl c" = { "ScrollToBottom; SwitchToMode" = "Normal"; };
    "j" = { "ScrollDown; SwitchToMode" = "Scroll"; };
    "k" = { "ScrollUp; SwitchToMode" = "Scroll"; };
    "Ctrl d" = { "PageScrollDown; SwitchToMode" = "Scroll"; };
    "Ctrl u" = { "PageScrollUp; SwitchToMode" = "Scroll"; };
  };

  tab = tabGoTo // {
    "Esc" = { SwitchToMode = "Normal"; };
    "Ctrl c" = { SwitchToMode = "Normal"; };
  };

  "shared_except \"tmux\" \"locked\"" = {
    "Alt s" = { SwitchToMode = "Tmux"; };
    "Alt Left" = { "GoToPreviousTab; SwitchToMode" = "Normal"; };
    "Alt Right" = { "GoToNextTab; SwitchToMode" = "Normal"; };

    "Alt h" = { MoveFocus = "Left"; SwitchToMode = "Normal"; };
    "Alt j" = { MoveFocus = "Down"; SwitchToMode = "Normal"; };
    "Alt k" = { MoveFocus = "Up"; SwitchToMode = "Normal"; };
    "Alt l" = { MoveFocus = "Right"; SwitchToMode = "Normal"; };
  };

  "shared_except \"tmux\" \"locked\" \"entersearch\"" = {
    "Alt f" = { SwitchToMode = "EnterSearch"; };
  };

  "shared_except \"tab\" \"locked\" \"tmux\" \"search\" \"entersearch\"" = {
    "Alt n" = { SwitchToMode = "Tab"; };
  };


}

