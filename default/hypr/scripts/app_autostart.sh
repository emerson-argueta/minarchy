#!/usr/bin/env bash
# Autostart script for moving slow Chromium PWAs / webapps to special workspaces

WAIT_TIME=2.4

# --- Comms (special:comms) ---
gtk-launch "Google Chat" &
gtk-launch "Google Mail" &

## --- Research (special:research) ---
gtk-launch "Gemini" &
chromium &

### --- Entertainment (special:entertainment) ---
gtk-launch "YouTube" &
gtk-launch "YouTubeMusic" &


## --- Workflow (special:workflow) ---
gtk-launch "Sentry" &
gtk-launch "GitLab" &
gtk-launch "Google Cloud" &
gtk-launch "Zendesk" &

sleep $WAIT_TIME
hyprctl dispatch movetoworkspacesilent 'special:comms,class:^chrome-mail\.google\.com__chat-.*'
hyprctl dispatch movetoworkspacesilent 'special:comms,class:^chrome-mail\.google\.com__mail-.*'
hyprctl dispatch movetoworkspacesilent 'special:entertainment,class:^chrome-youtube\.com__-.*'
hyprctl dispatch movetoworkspacesilent 'special:entertainment,class:^chrome-music\.youtube\.com__-.*'
hyprctl dispatch movetoworkspacesilent 'special:research,class:^(Chromium|chromium)$'
hyprctl dispatch movetoworkspacesilent 'special:research,class:^chrome-gemini\.google\.com__app-.*'
hyprctl dispatch movetoworkspacesilent 'special:workflow,class:^chrome-springs-charter-schools\.sentry\.io__-.*'
hyprctl dispatch movetoworkspacesilent 'special:workflow,class:^chrome-gitlab\.com__-.*'
hyprctl dispatch movetoworkspacesilent 'special:workflow,class:^chrome-console\.cloud\.google\.com__-.*'
hyprctl dispatch movetoworkspacesilent 'special:workflow,class:^chrome-springscharterschool\.zendesk\.com__agent_home_tickets-.*'
