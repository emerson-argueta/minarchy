#!/bin/bash

if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
  echo 'configuring tmux'
  mkdir -p ~/.config/tmux
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  cp -R ~/.local/share/omarchy/config/tmux/* ~/.config/tmux/
fi
