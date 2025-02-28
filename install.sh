wget https://github.com/sigma2647/dotfile -O ~/.dotfiles
wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz -O ~/usr/bin/neovim
tar -xzf nvim-linux64.tar.gz
sudo mv nvim-linux64 /usr/local/bin/neovim



apt install stow
apt install vim


git clone https://github.com/sigma2647/nvim -b lua ~/.config/nvim


