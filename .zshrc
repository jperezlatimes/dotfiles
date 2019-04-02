# Install oh my zsh
if [ ! -d ~/.oh-my-zsh ]; then
  curl -L http://install.ohmyz.sh | sh
fi
export ZSH=~/.oh-my-zsh

HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

# -------------------------------------------------------------------
# History file
# -------------------------------------------------------------------
if [ ! -f ~/.dotfiles/.zhist ]; then
  touch ~/.dotfiles/.zhist
fi
HISTFILE=~/.dotfiles/.zhist
