 #!/bin/bash
set -e

REPO="$HOME/.dotfiles"
cd "$REPO"

echo "🔄 Updating flake.lock..."
nix flake update

echo "🔧 Rebuilding as root..."
sudo nixos-rebuild switch --flake "$REPO#$(hostname)"
