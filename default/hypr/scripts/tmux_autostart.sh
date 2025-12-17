#!/bin/bash
tmux start-server
sleep 0.5
uwsm-app -- alacritty --class "Alacritty-dev" -e tmux new-session -A -s dev &
uwsm-app -- alacritty --class "Database-manager" -e tmux new-session -A -s database "lazysql" &
uwsm-app -- alacritty --class "Alacritty-sysadmin" -e bash -ic springs-db-connections &
