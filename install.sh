
sudo apt install -y stow \
	unzip \
	zip \
	ripgrep \
	bat \
	tmux \
	zsh \
	jq \
	eza \
	clang
	# lazygit \

curl -s https://ohmyposh.dev/install.sh | bash -s

#curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
#sudo rm -rf /opt/nvim
#sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

mkdir -p ./gits/delta
wget -O ./gits/delta.deb https://github.com/dandavison/delta/releases/download/0.18.2/git-delta_0.18.2_amd64.deb
sudo dpkg -i ./gits/delta.deb

# -[x] install go
# -[x] install nvm
# -[x] install lazygit
# -[x] install tmux tpm
# -[x] install fzf
# -[ ] zoxide


