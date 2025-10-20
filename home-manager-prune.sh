#!/bin/bash

# Expire last 7 days
home-manager expire-generations '-7 days'

# After expire-generations run garbage collection
nix-collect-garbage -d
