#!/usr/bin/env bash

set -euo pipefail

SOURCE_DIR="$HOME/Development/minarchy/default"
TARGET_DIR="$HOME/.local/share/omarchy/default"

# Ensure SOURCE_DIR exists
if [ ! -d "$SOURCE_DIR" ]; then
  echo "Source directory does not exist: $SOURCE_DIR"
  exit 1
fi

# Ensure TARGET_DIR exists
mkdir -p "$TARGET_DIR"

# Loop through all files in SOURCE_DIR
find "$SOURCE_DIR" -type f | while read -r src_file; do
  # Determine relative path
  rel_path="${src_file#$SOURCE_DIR/}"

  # Determine target file path
  tgt_file="$TARGET_DIR/$rel_path"

  # Create target directory if it doesn't exist
  mkdir -p "$(dirname "$tgt_file")"

  # Remove existing file or symlink at target location
  if [ -e "$tgt_file" ] || [ -L "$tgt_file" ]; then
    rm -rf "$tgt_file"
  fi

  # Create symbolic link
  ln -s "$src_file" "$tgt_file"

  echo "Linked: $tgt_file -> $src_file"
done

echo "✅ All files in $TARGET_DIR replaced with symlinks to $SOURCE_DIR"
