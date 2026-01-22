#!/bin/bash

tmux start-server
sleep 0.5

# === Terminal: dev (workspace 1) ===
uwsm-app -- alacritty --class "Alacritty-dev" -e tmux new-session -A -s dev &

# === Database manager (workspace 3) ===
uwsm-app -- alacritty --class "Database-manager" -e tmux new-session -A -s database "lazysql" &

# === Sysadmin terminal (workspace 2) ===
uwsm-app -- alacritty --class "Alacritty-sysadmin" -e bash -ic springs-db-connections &

sleep 0.5
