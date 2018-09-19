# -------------------------------------------------------------------
# Base Setup
# -------------------------------------------------------------------
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZSH=~/.oh-my-zsh

ZSH_THEME="powerlevel9k/powerlevel9k"
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

# -------------------------------------------------------------------
# Options
# -------------------------------------------------------------------
setopt extended_history         # Also record time and duration of commands.
setopt share_history            # Share history between multiple shells
setopt hist_find_no_dups        # Dont display duplicates during searches.
setopt hist_ignore_dups         # Ignore consecutive duplicates.

# -------------------------------------------------------------------
# Completions
# -------------------------------------------------------------------
autoload -Uz compinit
compinit

# -------------------------------------------------------------------
# Bundled plugins
# -------------------------------------------------------------------
plugins=(
  git
  pip
  npm
  node
  sudo
  history
  virtualenv
  redis-cli
  docker
  docker-compose
  common-aliases
  colorize
  archlinux
)
source $ZSH/oh-my-zsh.sh

# -------------------------------------------------------------------
# Custom plugins
# -------------------------------------------------------------------
if [ ! -d $ZSH_CUSTOM/plugins/zsh-completions ]; then
	sudo git clone https://github.com/zsh-users/zsh-completions $ZSH_CUSTOM/plugins/zsh-completions	
fi

if [ ! -d $ZSH_CUSTOM/plugins/zsh-autosuggestions ]; then
	sudo git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
fi

DEFAULT_FOREGROUND=006 DEFAULT_BACKGROUND=235

POWERLEVEL9K_MODE="nerdfont-complete"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="╭"
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="╰\uF460\uF460 "

POWERLEVEL9K_DIR_OMIT_FIRST_CHARACTER=false

POWERLEVEL9K_ALWAYS_SHOW_CONTEXT=true
POWERLEVEL9K_ALWAYS_SHOW_USER=true

POWERLEVEL9K_CONTEXT_TEMPLATE="\uF109 %m"

POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR="\uE0B4"
POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR="%F{$(( $DEFAULT_BACKGROUND - 2 ))}|%f"
POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR="\uE0B6"
POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR="%F{$(( $DEFAULT_BACKGROUND - 2 ))}|%f"

POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_RPROMPT_ON_NEWLINE=false

POWERLEVEL9K_STATUS_VERBOSE=true
POWERLEVEL9K_STATUS_CROSS=true
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

POWERLEVEL9K_VIRTUALENV_FOREGROUND=221
POWERLEVEL9K_VIRTUALENV_BACKGROUND=17

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(user root_indicator context dir_writable dir virtualenv vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(command_execution_time background_jobs status time ssh)

# -------------------------------------------------------------------
# Aliases
# -------------------------------------------------------------------
alias mkenv="virtualenv"
alias off="deactivate"
alias search="sudo find / -name"
alias zshconfig="vim ~/.dotfiles/.zshrc"
alias zshupdate="source ~/.zshrc"

# Set Java Home var
export JAVA_HOME=/usr/lib/jvm/default || echo "JVM not installed"

# Set up NVM
source /usr/share/nvm/init-nvm.sh || "NVM not installed"

# Install an AUR repo package
auryn() {
  if [ -z "$1" ]; then
    echo "No AUR package specified"
  else
    cd ~/Downloads
    git clone "https://aur.archlinux.org/$1.git"
    cd "$1"
    makepkg -Acs && sudo pacman -U *.pkg.tar.xz
    cd ~/Downloads && sudo rm -r "$1" 
 fi
}

# Ship a python package to different pypi profiles
ship() {
  if [ "$1" == "publish" ]; then
    python setup.py sdist bdist_wheel
    twine upload dist/*
  elif [ -z $1 ]; then
    python setup.py sdist bdist_wheel
    twine upload dist/* --skip-existing
  else
    echo "shipping library $1"
    python setup.py sdist bdist_wheel
    twine upload dist/* -r "$1" --skip-existing
  fi
}
