{ pkgs, ... }:

{
  programs.wofi = {
    enable = true;
    style = ''
      @define-color base00 #282828;
      @define-color base01 #3c3836;
      @define-color base02 #504945;
      @define-color base03 #665c54;
      @define-color base04 #bdae93;
      @define-color base05 #d5c4a1; /* Adjusted for slightly warmer text */
      @define-color base08 #fb4934; /* Red */
      @define-color base09 #fe8019; /* Orange */
      @define-color base0A #fabd2f; /* Yellow */
      @define-color base0B #b8bb26; /* Green */
      @define-color base0D #83a598; /* Aqua */
      @define-color base0E #d3869b; /* Purple */

      window {
        background-color: @base00;
        border: 2px solid @base03;
        border-radius: 10px;
        font-family: "JetBrainsMono Nerd Font"; /* You might need to adjust this font */
        font-size: 16px;
        opacity: 0.95;
      }

      #input {
        background-color: @base01;
        color: @base0A; /* Yellow for input text */
        padding: 10px;
        margin: 5px;
        border-radius: 5px;
        border: none;
      }

      #input image {
        display: none;
      }

      #inner-box {
        margin: 5px;
        spacing: 10px;
      }

      #outer-box {
        padding: 10px;
      }

      #scroll {
        margin-top: 5px;
      }

      #entry {
        padding: 8px;
        border-radius: 5px;
      }

      #entry:selected {
        background-color: @base02;
        color: @base09; /* Orange for selected text */
        outline: none;
      }

      #text {
        color: @base05; /* Warm off-white for text */
      }

      #text:selected {
        color: @base09; /* Orange for selected text */
      }
    '';
    settings = {
        show = "drun"; /* Show applications */
        allow_images = true;
        allow_markup = true;
        image_size = 32;
        key_expand = "Tab";
        key_scroll_down = "Ctrl-j";
        key_scroll_up = "Ctrl-k";
    };
  };
} 