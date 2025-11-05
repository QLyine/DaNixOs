# Claude Configuration Setup Guide

This guide explains how to set up and manage your Claude configuration with secret management using SOPS and age.

## Overview

The setup provides:
- **Secure secret management**: ANTHROPIC_AUTH_TOKEN stored in encrypted SOPS files
- **Shared configuration**: Claude settings available in both Linux (qlyine) and macOS (dso17-macos) environments
- **Automatic configuration**: Settings generated at `~/.claude/settings.json`
- **Environment variable injection**: Auth token automatically available as environment variable

## Architecture

```
home-manager/
├── common/
│   ├── cli/
│   │   ├── default.nix          # Imports claude.nix
│   │   └── claude.nix           # Claude configuration (shared)
│   └── secrets/
│       └── default.nix          # Secrets management module
├── qlyine.nix                   # Linux user config
└── dso17-macos.nix             # macOS user config
```

## Configuration Details

### 1. Claude Configuration (`home-manager/common/cli/claude.nix`)

- **Shared between both environments**
- Creates `~/.claude/` directory
- Provides `generate-claude-settings` script
- Sets up systemd service to regenerate settings when secrets are available

### 2. Secrets Configuration (user-specific)

#### Linux (`home-manager/qlyine.nix`):
```nix
secrets = {
  enable = true;
  defaultSecretsFile = "user/secrets.d/api-keys.yaml";

  secrets = {
    api-keys = { /* existing secrets */ };
    claude = {
      file = "user/secrets.d/claude.yaml";
      keys = [ "anthropic_auth_token" ];
      asEnvironment = true;
    };
  };
};
```

#### macOS (`home-manager/dso17-macos.nix`):
```nix
secrets = {
  enable = true;
  defaultSecretsFile = "user/secrets.d/claude.yaml";

  secrets = {
    claude = {
      file = "user/secrets.d/claude.yaml";
      keys = [ "anthropic_auth_token" ];
      asEnvironment = true;
    };
  };
};
```

## How to Change Your ANTHROPIC_AUTH_TOKEN

### Method 1: Using the Helper Script (Recommended)

1. **Edit the secrets file:**
   ```bash
   ./bin/secrets-helper edit user/secrets.d/claude.yaml
   ```

2. **Update the token value:**
   ```yaml
   # Claude API secrets
   anthropic_auth_token: "sk-ant-your-new-token-here"
   ```

3. **Save and exit** - SOPS will automatically encrypt the file

4. **Rebuild your configuration:**
   ```bash
   # For Linux (qlyine):
   home-manager switch --flake .#qlyine

   # For macOS (dso17-macos):
   home-manager switch --flake .#dso17-macos
   ```

5. **Restart the secrets service:**
   ```bash
   systemctl --user restart secrets-claude.service
   systemctl --user restart claude-settings.service
   ```

### Method 2: Manual SOPS Commands

1. **Edit with SOPS directly:**
   ```bash
   SOPS_AGE_KEY_FILE=secrets/keys/age-key-host.txt sops secrets/user/secrets.d/claude.yaml
   ```

2. **Update the token value and save**

3. **Follow steps 4-5 from Method 1**

### Method 3: Generate New Settings File

If the environment variable is already available:

1. **Generate settings manually:**
   ```bash
   export ANTHROPIC_AUTH_TOKEN="your-token-here"
   generate-claude-settings
   ```

## Generated Settings File

The final `~/.claude/settings.json` will contain:
```json
{
  "env": {
    "ANTHROPIC_AUTH_TOKEN": "your-actual-token",
    "ANTHROPIC_BASE_URL": "https://api.z.ai/api/anthropic",
    "API_TIMEOUT_MS": "3000000",
    "ANTHROPIC_DEFAULT_HAIKU_MODEL": "glm-4.5-air",
    "ANTHROPIC_DEFAULT_SONNET_MODEL": "glm-4.6",
    "ANTHROPIC_DEFAULT_OPUS_MODEL": "glm-4.6"
  }
}
```

## Troubleshooting

### Token Not Working

1. **Check if the secrets service is running:**
   ```bash
   systemctl --user status secrets-claude.service
   systemctl --user status claude-settings.service
   ```

2. **Check if environment variable is set:**
   ```bash
   echo $ANTHROPIC_AUTH_TOKEN
   ```

3. **Check the settings file:**
   ```bash
   cat ~/.claude/settings.json
   ```

4. **Regenerate settings manually:**
   ```bash
   generate-claude-settings
   ```

### Secrets Service Issues

1. **Check if you can decrypt the secrets file:**
   ```bash
   ./bin/secrets-helper get user/secrets.d/claude.yaml anthropic_auth_token
   ```

2. **Check your age key:**
   ```bash
   ./bin/secrets-helper check
   ```

3. **Restart services:**
   ```bash
   systemctl --user daemon-reload
   systemctl --user restart secrets-claude.service
   systemctl --user restart claude-settings.service
   ```

### Configuration Not Applied

1. **Rebuild home-manager:**
   ```bash
   # Linux:
   home-manager switch --flake .#qlyine

   # macOS:
   home-manager switch --flake .#dso17-macos
   ```

2. **Check for errors in the build output**

3. **Verify the configuration files exist:**
   ```bash
   ls -la ~/.claude/
   ls -la ~/.nix-profile/bin/generate-claude-settings
   ```

## Security Notes

- **Never commit** your private age key (`secrets/keys/age-key-host.txt`)
- **Never share** your ANTHROPIC_AUTH_TOKEN
- **Backup** your age key securely using `./bin/secrets-helper backup`
- The encrypted secrets file (`secrets/user/secrets.d/claude.yaml`) is safe to commit to Git
- Both public keys are configured for redundancy - if one machine is compromised, you can rotate keys

## Additional Commands

### List all secrets in a file:
```bash
./bin/secrets-helper list user/secrets.d/claude.yaml
```

### Export secrets as environment variables:
```bash
./bin/secrets-helper export user/secrets.d/claude.yaml
```

### Check the setup:
```bash
./bin/secrets-helper check
```

### Backup your age key:
```bash
./bin/secrets-helper backup
```