#!/bin/bash

# Create backup directory if it doesn't exist
if [ ! -d ~/.dotfiles/backup ]; then
  mkdir ~/.dotfiles/backup
fi

# Backup old dotfiles
mv ~/.zshrc ~/.dotfiles/backup/.zshrc || echo "No .zshrc file to move"
mv ~/.vimrc ~/.dotfiles/backup/.vimrc || echo "No .vimrc file to move"

# Write zshrc file with theme link
sudo rm -f .zshrc && touch .zshrc
echo "export source ~/.zshrc-base" >> .zshrc

# If theme is specified, add it
if [ "$0" != "" ]; then
  if [ ! -f .zshrc-$0 ]; then
    echo "ZSH theme $0 not supported, using default. Supported themes: spaceship, powerlevel9k"
  else
    echo "Initializing ZSH profile with $0 theme."
    echo "export source ~/.zshrc-$0" >> .zshrc
  fi
fi

# Create symlinks to new dotfiles
ln -s ~/.dotfiles/.vimrc ~/.vimrc
ln -s ~/.dotfiles/.zshrc ~/.zshrc

# Load the new zsh config
source ~/.zshrc
