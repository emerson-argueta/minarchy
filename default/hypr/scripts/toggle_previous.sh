#!/bin/bash

LAST_WORKSPACE=$(cat ~/.cache/hypr_last_workspace)
CURRENT_WORKSPACE=$(cat ~/.cache/hypr_current_workspace)

# Determine state
CURRENT_IS_SPECIAL=false
LAST_IS_SPECIAL=false
if [[ "$CURRENT_WORKSPACE" == special:* ]]; then CURRENT_IS_SPECIAL=true; fi
if [[ "$LAST_WORKSPACE" == special:* ]]; then LAST_IS_SPECIAL=true; fi

# Flattened logic
if $CURRENT_IS_SPECIAL && $LAST_IS_SPECIAL; then
    # CASE 1: special -> special (e.g., special:term -> special:chat)
    # Toggle the LAST one; this auto-closes the current one.
    LAST_SPECIAL_NAME=$(echo "$LAST_WORKSPACE" | cut -d':' -f2)
    hyprctl dispatch togglespecialworkspace "$LAST_SPECIAL_NAME"

elif $CURRENT_IS_SPECIAL && ! $LAST_IS_SPECIAL; then
    # CASE 2: special -> regular (e.g., special:term -> 1)
    # Toggle the CURRENT one OFF; this returns to the last regular.
    CURRENT_SPECIAL_NAME=$(echo "$CURRENT_WORKSPACE" | cut -d':' -f2)
    hyprctl dispatch togglespecialworkspace "$CURRENT_SPECIAL_NAME"

elif ! $CURRENT_IS_SPECIAL && $LAST_IS_SPECIAL; then
    # CASE 3: regular -> special (e.g., 1 -> special:term)
    # Toggle the LAST one ON.
    LAST_SPECIAL_NAME=$(echo "$LAST_WORKSPACE" | cut -d':' -f2)
    hyprctl dispatch togglespecialworkspace "$LAST_SPECIAL_NAME"

else
    # CASE 4: regular -> regular (e.g., 1 -> 2)
    # Switch by name.
    hyprctl dispatch workspace name:"$LAST_WORKSPACE"
fi
