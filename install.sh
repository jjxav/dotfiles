
sudo pacman -Sy --noconfirm stow ripgrep bat tmux eza zsh zip unzip jq lazygit clang
sudo pacman -Sy --noconfirm hyprland wofi waybar

curl -s https://ohmyposh.dev/install.sh | bash -s
[ ! -d ~/.tmux/plugins/tpm ] && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

curl -s https://ohmyposh.dev/install.sh | bash -s

#curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
#sudo rm -rf /opt/nvim
#sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

wget -O ./gits/delta.deb https://github.com/dandavison/delta/releases/download/0.18.2/git-delta_0.18.2_amd64.deb
sudo dpkg -i ./gits/delta.deb

wget -O ./gits/glab.deb https://gitlab.com/gitlab-org/cli/-/releases/v1.59.2/downloads/glab_1.59.2_linux_amd64.deb
sudo dpkg -i ./gits/glab.deb

wget -O ./gits/zoxide.deb https://github.com/ajeetdsouza/zoxide/releases/download/v0.9.8/zoxide_0.9.8-1_amd64.deb
sudo dpkg -i ./gits/zoxide.deb

# -[x] install go
# -[x] install nvm
# -[x] install lazygit
# -[x] install tmux tpm
# -[x] install fzf
# -[x] zoxide

