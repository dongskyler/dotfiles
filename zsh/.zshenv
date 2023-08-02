#!/bin/zsh

export LANG=en_US.UTF-8

GPG_TTY=$(tty)
export GPG_TTY

export LC_ALL='en_US.UTF-8'

export EDITOR=nvim

export PAGER=less

export ZDOTDIR="$HOME/.zsh"

export PATH="$HOME/.local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

export ALIASES_FILE="$ZDOTDIR/aliases.zsh"

load_aliases() {
  if [[ -f "$ALIASES_FILE" ]]; then
    . "$ALIASES_FILE"
  fi
}

load_aliases && unset -f load_aliases

export DOCKER_DIR="$HOME/.docker"
export PATH="$DOCKER_DIR/bin:$PATH"

export PYENV_ROOT="$HOME/.pyenv"

if [[ -d "$PYENV_ROOT" ]]; then
  export PATH="$PYENV_ROOT/bin:$PATH"
  export PYENV_VIRTUALENV_DISABLE_PROMPT=1
fi

export POETRY_DIR="$HOME/.poetry"

if [[ -d "$POETRY_DIR" ]]; then
  export PATH="$POETRY_DIR/bin:$PATH"
fi

if [[ -d "$HOME/.node_modules" ]]; then
  export PATH="$HOME/.node_modules/bin:$PATH"
fi

export NVM_DIR="$HOME/.nvm"

if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi

export MATLAB_DIR="$HOME/.matlab"

export GO_DIR="${HOME}/.go"
# export GO_ROOT_DIR="$(brew --prefix golang)/libexec"

export PATH="$PATH:${GO_DIR}/bin:${GO_ROOT_DIR}/bin"
test -d "${GO_DIR}" || mkdir "${GO_DIR}"
test -d "${GO_DIR}/src/github.com" || mkdir -p "${GO_DIR}/src/github.com"

eval $(/opt/homebrew/bin/brew shellenv)

# ----------------------------------------------------------------------
# Load local configuration file, if present, to override default settings

load_local_zshenv () {
  LOCAL_ZSHENV="$ZDOTDIR/.zshenv.local.zsh"

  if [[ -f "$LOCAL_ZSHENV" ]]; then
    . "$LOCAL_ZSHENV"
  fi
}

load_local_zshenv && unset -f load_local_zshenv

# No more code below this line
# ----------------------------------------------------------------------
