{ config, pkgs, lib, ... }:

{
  # Define the secret for sops-nix
  sops.secrets = {
    "claude_auth_token" = {
      sopsFile = ./../../../secrets/user/secrets.d/claude.yaml;
      format = "yaml";
      key = "anthropic_auth_token";
    };
  };

  # Ensure the Claude directory exists
  home.file.".claude/.keep".text = "";

  # Create the settings.json file using sops-nix placeholder
  # The placeholder will be replaced with the actual secret value during activation
  sops.templates."claude-settings.json".content = builtins.toJSON {
    env = {
      ANTHROPIC_AUTH_TOKEN = config.sops.placeholder."claude_auth_token";
      ANTHROPIC_BASE_URL = "https://api.z.ai/api/anthropic";
      API_TIMEOUT_MS = "3000000";
      ANTHROPIC_DEFAULT_HAIKU_MODEL = "glm-4.5-air";
      ANTHROPIC_DEFAULT_SONNET_MODEL = "glm-4.6";
      ANTHROPIC_DEFAULT_OPUS_MODEL = "glm-4.6";
    };
  };

  home.file.".claude/settings.json".source = config.lib.file.mkOutOfStoreSymlink (
    config.sops.templates."claude-settings.json".path
  );

  # Create a script to manually regenerate settings if needed
  home.packages = with pkgs; [
    (writeShellScriptBin "refresh-claude-settings" ''
      set -euo pipefail
      echo "Claude settings are managed by sops-nix and Home Manager."
      echo "To update settings, rebuild your configuration:"
      echo "  home-manager switch --flake ."
    '')
  ];
}