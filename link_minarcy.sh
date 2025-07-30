#!/usr/bin/env bash

set -euo pipefail

# Define your map: source -> target
declare -A dir_map

# Example mappings
# dir_map["$PWD/default"]="$HOME/.local/share/omarchy/default"
# dir_map["$PWD/bin"]="$HOME/.local/share/omarchy/bin"
dir_map["$PWD/config/hypr"]="$HOME/.config/hypr"

for SOURCE_DIR in "${!dir_map[@]}"; do
  TARGET_DIR="${dir_map[$SOURCE_DIR]}"

  echo "🔄 Processing:"
  echo "   Source: $SOURCE_DIR"
  echo "   Target: $TARGET_DIR"

  # Ensure SOURCE_DIR exists
  if [ ! -d "$SOURCE_DIR" ]; then
    echo "❌ Source directory does not exist: $SOURCE_DIR"
    continue
  fi

  # Create all directories first (including empty ones)
  find "$SOURCE_DIR" -type d | while read -r src_dir; do
    rel_dir="${src_dir#$SOURCE_DIR/}"
    tgt_dir="$TARGET_DIR/$rel_dir"
    mkdir -p "$tgt_dir"
  done

  # Process all files
  find "$SOURCE_DIR" -type f | while read -r src_file; do
    rel_path="${src_file#$SOURCE_DIR/}"
    tgt_file="$TARGET_DIR/$rel_path"

    # Create parent directory if missing (extra safety)
    mkdir -p "$(dirname "$tgt_file")"

    # Remove existing file or symlink at target location
    if [ -e "$tgt_file" ] || [ -L "$tgt_file" ]; then
      rm -rf "$tgt_file"
    fi

    # Create symbolic link
    ln -s "$src_file" "$tgt_file"

    echo "🔗 Linked: $tgt_file -> $src_file"
  done

  echo "✅ Finished syncing: $SOURCE_DIR -> $TARGET_DIR"
  echo "--------------------------------------------"
done

echo "🎉 All mappings processed."
