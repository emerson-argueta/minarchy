echo "Installing missing tmux terminal tool for terminal multiplexing"

if ! command -v tmux &>/dev/null; then
  yay -S --noconfirm --needed tmux
fi
