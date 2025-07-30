#!/bin/bash

# List of special workspace names
special_workspaces=("research" "entertainment" "productivity" "comms")

# File to store the last active workspace
LAST_WORKSPACE_FILE="/tmp/hypr_last_workspace"

# Extract the current workspace name using jq
full_workspace_name=$(hyprctl activewindow -j | jq -r '.workspace.name')
workspace_name=${full_workspace_name#special:}

# Check against the special workspace list
is_current_special=false
for ws in "${special_workspaces[@]}"; do
  if [[ "$workspace_name" == "$ws" ]]; then
    is_current_special=true
    break
  fi
done

if $is_current_special; then
  hyprctl dispatch togglespecialworkspace "$workspace_name"
  echo "$workspace_name" >"$LAST_WORKSPACE_FILE"
  exit 0
fi

last_workspace=""
if [[ -f "$LAST_WORKSPACE_FILE" ]]; then
  last_workspace=$(cat "$LAST_WORKSPACE_FILE")
fi

if [[ -n "$last_workspace" ]]; then
  echo "Switching back to last non-special workspace: $last_workspace"
  hyprctl dispatch togglespecialworkspace "$last_workspace"
else
  echo "No previous non-special workspace recorded. Staying on current workspace."
fi

exit 0
