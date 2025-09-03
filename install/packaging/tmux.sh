#!/bin/bash

if [[ ! -d "$HOME/.config/tmux" ]]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
