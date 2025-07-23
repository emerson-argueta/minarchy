#!/bin/bash

# List of special workspace names
special_workspaces=("research" "entertainment" "productivity" "comms")

# Extract the current workspace name using jq
full_workspace_name=$(hyprctl activewindow -j | jq -r '.workspace.name')
workspace_name=${full_workspace_name#special:}

echo $workspace_name
# Check against the special workspace list
for ws in "${special_workspaces[@]}"; do
  if [[ "$workspace_name" == "$ws" ]]; then
    echo $ws
    hyprctl dispatch togglespecialworkspace "$ws"
    exit 0
  fi
done

exit 0
