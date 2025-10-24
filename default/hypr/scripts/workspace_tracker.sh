#!/bin/bash

# Create cache directory
mkdir -p ~/.cache/hypr

# Initialize cache files with current state
hyprctl activeworkspace -j | jq -r '.name' > ~/.cache/hypr_current_workspace
hyprctl activeworkspace -j | jq -r '.id' > ~/.cache/hypr_last_workspace # Default to active ID

handle() {
    local WORKSPACE_NAME=""
    local CURRENT_WORKSPACE=""
    local LAST_WORKSPACE=""
    if [[ $1 == "workspacev2" ]]; then
      # Data is WORKSPACEID,WORKSPACENAME. We want WORKSPACENAME. This should be done in the while loop
      WORKSPACE_NAME=$(echo "$2")
    elif [[ $1 == "activespecial" ]]; then
      # Data is WORKSPACENAME,MONNAME. We want WORKSPACENAME. This should be done in the while loop
      WORKSPACE_NAME=$(echo "$2")
    fi

    if [[ $1 == "activespecial" && -z "$WORKSPACE_NAME" ]]; then
      # This event means a special workspace was *closed*.
      # We are now on the last regular workspace.
      # We must swap the cache files.
      CURRENT_WORKSPACE=$(cat ~/.cache/hypr_current_workspace) # e.g., "special:term"
      LAST_WORKSPACE=$(cat ~/.cache/hypr_last_workspace)       # e.g., "1"
      echo "$CURRENT_WORKSPACE" > ~/.cache/hypr_last_workspace # last -> "special:term"
      echo "$LAST_WORKSPACE" > ~/.cache/hypr_current_workspace   # current -> "1"
      return
    fi

    echo "workspace name: $WORKSPACE_NAME"
    if [ -z "$WORKSPACE_NAME" ]; then
      return
    fi

    CURRENT_WORKSPACE=$(cat ~/.cache/hypr_current_workspace)
    # Only update if the workspace has *actually* changed.
    if [[ "$CURRENT_WORKSPACE" != "$WORKSPACE_NAME" ]]; then
      echo "last workspace: $CURRENT_WORKSPACE || current worksapce: $WORKSPACE_NAME"
      echo "$CURRENT_WORKSPACE" > ~/.cache/hypr_last_workspace
      echo "$WORKSPACE_NAME" > ~/.cache/hypr_current_workspace
    fi
}

# Listen to Hyprland's event socket
socat -u "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" - | \
while read -r line; do
    # Format is event>>data
    event_name=$(echo "$line" | cut -d'>' -f1)
    # Need a guard clause to only process [workspacev2, activespecial] events
    if [[ "$event_name" != "workspacev2" && "$event_name" != "activespecial" ]]; then
      continue
    fi
    raw_event_data=$(echo "$line" | cut -d'>' -f3)
    event_data=$(echo "$raw_event_data" | cut -d',' -f1)
    echo "event name: $event_name || event data: $event_data"
    handle "$event_name" "$event_data"
done
