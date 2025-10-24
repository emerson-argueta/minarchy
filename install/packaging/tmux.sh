#!/bin/bash
#
# This script installs the tmux Plugin Manager (tpm) and reloads the
# specified tmux configuration file.
#
# Exit immediately if a command fails
set -e

TPM_DIR="$HOME/.tmux/plugins/tpm"
CONFIG_DIR="$HOME/.config/tmux"
CONFIG_FILE="$CONFIG_DIR/tmux.conf"
TPM_REPO="https://github.com/tmux-plugins/tpm"

mkdir -p $CONFIG_DIR
SOURCE_CONFIG_FILE="$OMARCHY_INSTALL/config/tmux/tmux.conf"
if [ -f "$CONFIG_FILE" ]; then
  echo "Config file already present at $CONFIG_FILE. Skipping copy."
else
  echo "Copying config file to $CONFIG_FILE..."
  cp "$SOURCE_CONFIG_FILE" "$CONFIG_FILE"
  echo "Config file copied successfully."
fi

echo "Checking for tpm (tmux plugins) installation..."
if [ -d "$TPM_DIR" ]; then
  echo "tpm is already installed at $TPM_DIR. Skipping clone."
else
  echo "Cloning tmux Plugin Manager (tpm) to $TPM_DIR..."
  git clone "$TPM_REPO" "$TPM_DIR"
  echo "tpm cloned successfully."
fi

echo "Found config file. Attempting to reload tmux..."
if ! tmux ls > /dev/null 2>&1; then
  echo "tmux server is not running."
  echo "Config will be loaded automatically the next time you start tmux."
  echo "Once inside tmux, press 'Prefix + I' (capital I) to install plugins."
  echo ""
  echo "Setup complete."
  exit 0 # Also not an error
fi

echo "Reloading tmux config..."
if tmux source-file "$CONFIG_FILE"; then
  echo "tmux config reloaded successfully."
  echo "---------------------------------------------------------------"
  echo "IMPORTANT: Press 'Prefix + I' (capital I) inside tmux to install plugins."
  echo "---------------------------------------------------------------"
else
  echo "Error: 'tmux source-file' command failed." >&2
  echo "Your config at $CONFIG_FILE may have a syntax error."
fi
echo ""
echo "Setup complete."
