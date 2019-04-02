#!/bin/bash

THEME='spaceship'

# Take first argument as theme name
if [ "$0" != "" ]; then
  if [ ! -f .zshrc-$0 ]; then
    echo "ZSH theme $0 not supported please select from: spaceship, powerlevel9k"
  else
    echo "Initializing ZSH profile with $0 theme."
    THEME=$0
  fi
fi

# Create backup directory if it doesn't exist
if [ ! -d ~/.dotfiles/backup ]; then
  mkdir ~/.dotfiles/backup
fi

# Backup old dotfiles
mv ~/.zshrc ~/.dotfiles/backup/.zshrc || echo "No .zshrc file to move"
mv ~/.vimrc ~/.dotfiles/backup/.vimrc || echo "No .vimrc file to move"

# Create symlinks to new dotfiles
ln -s ~/.dotfiles/.vimrc ~/.vimrc
ln -s ~/.dotfiles/.zshrc-$THEME ~/.zshrc

# Load the new zsh config
source ~/.zshrc
