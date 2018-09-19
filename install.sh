# Backup old dotfiles
mv ~/.zshrc ~/.dotfiles/backup/.zshrc
mv ~/.vimrc ~/.dotfiles/backup/.vimrc

# Create symlinks to new dotfiles
ln -s ~/.dotfiles/.vimrc ~/.vimrc
ln -s ~/.dotfiles/.zshrc ~/.zshrc
