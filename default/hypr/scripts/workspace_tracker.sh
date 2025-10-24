#!/bin/bash

# Get the name of the currently active workspace
INIT_WS_NAME=$(hyprctl activeworkspace -j | jq -r '.name')
echo "$INIT_WS_NAME" > ~/.cache/hypr_current_workspace
echo "$INIT_WS_NAME" > ~/.cache/hypr_last_workspace
echo "$INIT_WS_NAME" > ~/.cache/hypr_last_regular_workspace

handle() {
  local event_type="$1"
  local new_workspace_name="$2"
  if [[ "$event_type" == "activespecial" && -z "$new_workspace_name" ]]; then
    local last_special_ws=$(cat ~/.cache/hypr_current_workspace)
    local new_current_ws=$(cat ~/.cache/hypr_last_regular_workspace)
    echo "$new_current_ws" > ~/.cache/hypr_current_workspace
    echo "$last_special_ws" > ~/.cache/hypr_last_workspace
    echo "current ==> $(cat ~/.cache/hypr_current_workspace), last ==> $(cat ~/.cache/hypr_last_regular_workspace)"
    return
  fi

  if [ -z "$new_workspace_name" ]; then
    return
  fi

  local current_workspace=$(cat ~/.cache/hypr_current_workspace)
  if [[ "$current_workspace" != "$new_workspace_name" ]]; then
    echo "$current_workspace" > ~/.cache/hypr_last_workspace
    echo "$new_workspace_name" > ~/.cache/hypr_current_workspace
    if [[ "$event_type" == "workspacev2" ]]; then
        echo "$new_workspace_name" > ~/.cache/hypr_last_regular_workspace
    fi
    echo "current ==> $(cat ~/.cache/hypr_current_workspace), last ==> $(cat ~/.cache/hypr_last_regular_workspace)"
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
