#!/usr/bin/env bash
# Autostart script for moving slow Chromium PWAs / webapps to special workspaces

WAIT_TIME=0.5

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
