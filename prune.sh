#!/bin/bash

NUM_GENERATIONS=5

PROFILE="/nix/var/nix/profiles/system"

# List generations
sudo nix-env --list-generations --profile $PROFILE

# Keep only the last 5 generations
sudo nix-env --delete-generations +$NUM_GENERATIONS --profile $PROFILE

sudo nix-collect-garbage -d 