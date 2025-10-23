#!/bin/bash

# Create cache directory
mkdir -p ~/.cache/hypr

# Initialize cache files with current state
hyprctl activeworkspace -j | jq -r '.name' > ~/.cache/hypr_current_workspace
hyprctl activeworkspace -j | jq -r '.id' > ~/.cache/hypr_last_workspace # Default to active ID

handle() {
    local WORKSPACE_NAME=""
    # $1 = event name (e.g., "workspacev2")
    # $2 = event data (e.g., "1,1" or "special:term,HDMI-A-1")
    if [[ $1 == "workspacev2" ]]; then
        # Data is WORKSPACEID,WORKSPACENAME. We want WORKSPACENAME.
        WORKSPACE_NAME=$(echo "$2" | cut -d',' -f2)
    elif [[ $1 == "activespecial" ]]; then
        # Data is WORKSPACENAME,MONNAME. We want WORKSPACENAME.
        WORKSPACE_NAME=$(echo "$2" | cut -d',' -f1)
    fi
    # If the name is empty (e.g., from closing a special workspace),
    # we ignore it. The subsequent "workspacev2" event will log
    # the new regular workspace.
    if [ -z "$WORKSPACE_NAME" ]; then
        return
    fi
    # Now we have a valid name, update the cache.
    CURRENT_WORKSPACE=$(cat ~/.cache/hypr_current_workspace)
    # Only update if the workspace has *actually* changed.
    if [[ "$CURRENT_WORKSPACE" != "$WORKSPACE_NAME" ]]; then
        echo "$CURRENT_WORKSPACE" > ~/.cache/hypr_last_workspace
        echo "$WORKSPACE_NAME" > ~/.cache/hypr_current_workspace
    fi
}

# Listen to Hyprland's event socket
socat -u "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" - | \
while read -r line; do
    # Format is event>>data
    event_name=$(echo "$line" | cut -d'>' -f1)
    event_data=$(echo "$line" | cut -d'>' -f3) # '>>' delimiter
    handle "$event_name" "$event_data"
done
