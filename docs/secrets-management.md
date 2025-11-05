# Secret Management with SOPS and Age

This repository uses [SOPS](https://github.com/mozilla/sops) with [age](https://github.com/FiloSottile/age) for secure secret management. This allows you to store encrypted secrets in Git while keeping them safe from unauthorized access.

## Overview

- **SOPS**: Secrets OPerationS - manages encrypted files
- **age**: Simple, modern, and secure file encryption tool
- **Integration**: Home Manager module provides automatic secret loading and environment variable export

## Quick Start

### 1. Set up your age key

Age keys are generated and stored in `secrets/keys/`. These files are **never committed** to Git. The system supports multiple keys for different machines/users.

```bash
# View your host-specific public key
cat secrets/keys/age-key-host.txt

# Example output:
# # created: 2025-11-05T09:17:36Z
# # public key: age1l6w6yuxrylqedd07f7n5hvhwch2cvq59qmv6gztr6mu6yj2qq4kstjn3dv
# AGE-SECRET-KEY-1...

# Current configured public keys:
# - Original user key: age16pa9tevkpr7xu4jmlqq6mykrxds3y8rfcqy6u2dgwuas2jztl32qrqqpey
# - Host key: age1l6w6yuxrylqedd07f7n5hvhwch2cvq59qmv6gztr6mu6yj2qq4kstjn3dv
```

### 2. Edit secrets

To edit or add secrets:

```bash
# Edit the API keys file
sops secrets/user/secrets.d/api-keys.yaml

# Create a new secrets file
sops secrets/user/secrets.d/new-secrets.yaml
```

SOPS will automatically:
- Decrypt the file
- Open it in your `$EDITOR`
- Re-encrypt it when you save and exit

### 3. Use secrets in your shell

```bash
# Export all secrets as environment variables
export-secrets

# Read a specific secret
secret user/secrets.d/api-keys.yaml github_token

# List all available secrets in a file
list-secrets user/secrets.d/api-keys.yaml
```

### 4. Access secrets in applications

Secrets configured with `asEnvironment = true` are automatically exported as environment variables:

```bash
# These variables are available in your shell:
echo $GITHUB_TOKEN
echo $OPENAI_API_KEY
echo $ANTHROPIC_API_KEY
```

## File Structure

```
secrets/
├── keys/
│   └── age-key.txt           # Your private age key (NEVER commit this)
└── user/
    └── secrets.d/
        ├── api-keys.yaml     # Encrypted API keys and tokens
        └── ...               # Other encrypted secret files
```

## Configuration

### Adding New Secrets

1. **Edit an existing secrets file:**
   ```bash
   sops secrets/user/secrets.d/api-keys.yaml
   ```

2. **Add a new secret key:**
   ```yaml
   new_service_token: "your-new-token-here"
   ```

3. **Update Home Manager configuration** in `home-manager/qlyine.nix`:
   ```nix
   secrets.secrets.api-keys.keys = [
     # ... existing keys ...
     "new_service_token"  # Add this line
   ];
   ```

4. **Rebuild your configuration:**
   ```bash
   home-manager switch --flake .#qlyine
   ```

### Creating New Secret Files

1. **Create a new encrypted file:**
   ```bash
   sops secrets/user/secrets.d/new-service.yaml
   ```

2. **Add content:**
   ```yaml
   api_key: "your-api-key"
   secret_token: "your-secret-token"
   database_url: "your-database-url"
   ```

3. **Configure in Home Manager:**
   ```nix
   secrets.secrets.new-service = {
     file = "user/secrets.d/new-service.yaml";
     keys = [ "api_key" "secret_token" "database_url" ];
     asEnvironment = true;  # Optional: export as environment variables
   };
   ```

## Advanced Usage

### Manual Encryption/Decryption

```bash
# Decrypt and view a file
sops -d secrets/user/secrets.d/api-keys.yaml

# Encrypt an existing file
sops --encrypt --age age16pa9tevkpr7xu4jmlqq6mykrxds3y8rfcqy6u2dgwuas2jztl32qrqqpey --age age1l6w6yuxrylqedd07f7n5hvhwch2cvq59qmv6gztr6mu6yj2qq4kstjn3dv plain-secrets.yaml > secrets/user/secrets.d/api-keys.yaml

# Extract a specific key without decrypting the whole file
sops -d --extract '["github_token"]' secrets/user/secrets.d/api-keys.yaml
```

### Multiple Recipients

For collaboration, you can add multiple age recipients:

```yaml
# Update .sops.yaml
creation_rules:
  - path_regex: secrets/.*\.yaml$
    age:
      - age16pa9tevkpr7xu4jmlqq6mykrxds3y8rfcqy6u2dgwuas2jztl32qrqqpey  # Original user key
      - age1l6w6yuxrylqedd07f7n5hvhwch2cvq59qmv6gztr6mu6yj2qq4kstjn3dv  # Host key
```

### Using with systemd User Services

Secrets are automatically loaded via systemd user services:

```bash
# Check the status
systemctl --user status secrets-api-keys

# Restart to reload secrets
systemctl --user restart secrets-api-keys

# View logs
journalctl --user -u secrets-api-keys
```

## Security Best Practices

1. **Never commit private keys**: The `secrets/keys/` directory is in `.gitignore`
2. **Backup your age key**: Store a secure backup of `secrets/keys/age-key.txt`
3. **Use strong secrets**: Generate strong, unique secrets for each service
4. **Rotate secrets regularly**: Update secrets periodically and revoke old ones
5. **Limit access**: Only give access to people who need specific secrets

## Troubleshooting

### Common Issues

**Error: "failed to get file key"**
- Your age key is not in the right location
- Check that `secrets/keys/age-key.txt` exists and contains the correct key

**Error: "no keys were successfully loaded"**
- The encrypted file was created with a different age key
- Verify you're using the correct age public key in `.sops.yaml`

**Secrets not available as environment variables**
- Check that `asEnvironment = true` is set in your configuration
- Restart your user session: `systemctl --user restart secrets-api-keys`

**Editor doesn't open**
- Set your `EDITOR` environment variable
- Example: `export EDITOR=nvim`

### Debug Commands

```bash
# Check SOPS configuration
sops --config .sops.yaml --encrypt --dry-run secrets/user/secrets.d/api-keys.yaml

# Test age key
age -d -i secrets/keys/age-key.txt < test-file.age

# Check systemd service status
systemctl --user list-units 'secrets-*'
```

## Integration Examples

### Git Configuration

```bash
# Use secret in Git config
git config --global credential.helper "!f() { echo username=yourname; echo password=$(secret user/secrets.d/api-keys.yaml github_token); }; f"
```

### Docker Configuration

```bash
# Use secrets in Docker compose
export GITHUB_TOKEN
docker run --rm -e GITHUB_TOKEN your-image
```

### Shell Scripts

```bash
#!/bin/bash
# Load secrets in scripts
source $(which export-api-keys)
echo "GitHub token: $GITHUB_TOKEN"
```

## Files Reference

- `.sops.yaml`: SOPS configuration and encryption rules
- `secrets/keys/age-key.txt`: Your private age key (NEVER commit)
- `home-manager/common/secrets/default.nix`: Home Manager secrets module
- `home-manager/qlyine.nix`: Your secrets configuration
- `.gitignore`: Excludes sensitive files from Git

## Additional Resources

- [SOPS Documentation](https://github.com/mozilla/sops)
- [age Documentation](https://github.com/FiloSottile/age)
- [Home Manager Secrets Options](https://nix-community.github.io/home-manager/options.html#opt-secrets.enable)