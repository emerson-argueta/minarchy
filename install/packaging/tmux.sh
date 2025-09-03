#!/bin/bash

if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
  echo 'configuring tmux'
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
