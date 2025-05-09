
sudo pacman -Sy --noconfirm stow ripgrep bat tmux eza zsh zip unzip jq lazygit
sudo pacman -Sy --noconfirm hyprland wofi waybar

curl -s https://ohmyposh.dev/install.sh | bash -s
[ ! -d ~/.tmux/plugins/tpm ] && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
