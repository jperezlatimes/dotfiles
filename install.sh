#!/bin/bash

# Create backup directory if it doesn't exist
if [ ! -d ~/.dotfiles/backup ]; then
  mkdir ~/.dotfiles/backup
fi

# Backup old dotfiles
mv ~/.zshrc ~/.dotfiles/backup/.zshrc || echo "No .zshrc file to move"
mv ~/.vimrc ~/.dotfiles/backup/.vimrc || echo "No .vimrc file to move"

# Create a new zshrc file and source theme and base
sudo rm -f .zshrc && touch .zshrc

# If theme is specified, add it
if [ "$1" != "" ]; then
  if [ ! -f .zshrc-$1 ]; then
    echo "ZSH theme $1 not supported, using default. Supported themes: spaceship, powerlevel9k"
  else
    echo "Initializing ZSH profile with $1 theme."
    echo "source ~/.dotfiles/.zshrc-$1" >> .zshrc
  fi
fi

# Add the base configuration
echo "source ~/.dotfiles/.zshrc-base" >> .zshrc

# Create symlinks to new dotfiles
ln -s ~/.dotfiles/.vimrc ~/.vimrc
ln -s ~/.dotfiles/.zshrc ~/.zshrc

# Load the new zsh config
source ~/.zshrc
