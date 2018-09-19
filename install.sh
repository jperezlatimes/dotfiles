# Create backup directory if it doesn't exist
if [ ! -d ~/.dotfiles/backup ]; then
  mkdir ~/.dotfiles/backup
fi

# Backup old dotfiles
mv ~/.zshrc ~/.dotfiles/backup/.zshrc || echo "No .zshrc file to move"
mv ~/.vimrc ~/.dotfiles/backup/.vimrc || echo "No .vimrc file to move"

# Create symlinks to new dotfiles
ln -s ~/.dotfiles/.vimrc ~/.vimrc
ln -s ~/.dotfiles/.zshrc ~/.zshrc

# Load the new zsh config
source ~/.zshrc
