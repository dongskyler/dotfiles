#!/bin/zsh

ZSH="$ZDOTDIR/presets/oh-my-zsh"
ZSH_THEME="spaceship"
THEME_CONFIG="$ZDOTDIR/spaceship-config.zsh"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="false"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
UPDATE_ZSH_DAYS=14

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="false"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

ZSH_CUSTOM="$ZDOTDIR/custom"

ZSH_COMPDUMP="$ZDOTDIR/.zcompdump"

ZSH_AUTOSUGGEST_USE_ASYNC="true"
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_STRATEGY="history completion"
ZSH_AUTOSUGGEST_HISTORY_IGNORE="?(#c50,)"

load_autojump () {
  AUTOJUMP_SH="$HOME/.autojump/etc/profile.d/autojump.sh"

  if [[ -s "$AUTOJUMP_SH" ]]; then
    . "$AUTOJUMP_SH"
  fi
}

load_autojump && unset -f load_autojump

set_zsh_plugins () {
  plugins=(
    git
    yarn
    zsh-syntax-highlighting
  )

  if command -v autojump &> /dev/null; then
    plugins+=(autojump)
  else
    print -P "%F{yellow}Info: %BAutojump%b is not installed%f"
  fi

  if [[ -z "$SSH_CLIENT" ]] && [[ -z "$SSH_TTY" ]]; then
    plugins+=(zsh-autosuggestions)
  fi
}

set_zsh_plugins && unset -f set_zsh_plugins

load_oh_my_zsh () {
  ZSH_SH="$ZSH/oh-my-zsh.sh"

  if [[ -f "$ZSH_SH" ]]; then
    . "$ZSH_SH"
  else
    print -P "%F{red}Error: %BOh-my-zsh%b cannot be found!%f"
  fi
}

load_oh_my_zsh && unset -f load_oh_my_zsh

load_zsh_theme_config () {
  if [[ -f "$THEME_CONFIG" ]]; then
    . "$THEME_CONFIG"
  fi
}

load_zsh_theme_config && unset -f load_zsh_theme_config

load_nvm () {
  NVM_SH="$NVM_DIR/nvm.sh"
  NVM_BASH_COMPLETION="$NVM_DIR/etc/bash_completion.d/nvm"

  if [[ -s "$NVM_SH" ]]; then
    . "$NVM_SH"
  fi

  if [[ -s "$NVM_BASH_COMPLETION" ]]; then
    . "$NVM_BASH_COMPLETION"
  fi
}

init_nvm () {
  if [[ -d "$NVM_DIR" ]]; then
    NODE_GLOBALS=$(find "$HOME/.nvm/versions/node" -maxdepth 3 -type l \
      -wholename '*/bin/*' | xargs -n1 basename | sort | uniq)
    declare -a NODE_GLOBALS
    NODE_GLOBALS+=("node")
    NODE_GLOBALS+=("nvm")

    for cmd in "${NODE_GLOBALS[@]}"; do
      eval "${cmd}(){ unset -f ${NODE_GLOBALS}; load_nvm; ${cmd} \$@ }"
    done
  fi
}

init_nvm && unset -f init_nvm

init_rbenv () {
  if command -v rbenv &> /dev/null; then
    if which rbenv > /dev/null; then
      eval "$(rbenv init -)"
    fi
  fi
}

init_rbenv && unset -f init_rbenv

init_pyenv () {
  if [[ -d "$PYENV_ROOT" ]]; then
    if command -v pyenv 1>/dev/null 2>&1; then
      eval "$(pyenv init -)"
    fi

    eval "$(pyenv virtualenv-init -)"
  fi
}

init_pyenv && unset -f init_pyenv

# ----------------------------------------------------------------------
# Load local configuration file, if present, to override default settings

load_local_zshrc () {
  LOCAL_ZSHRC="$ZDOTDIR/.zshrc.local.zsh"

  if [[ -f "$LOCAL_ZSHRC" ]]; then
    . "$LOCAL_ZSHRC"
  fi
}

load_local_zshrc && unset -f load_local_zshrc

# No more code below this line
# ----------------------------------------------------------------------

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pnpm
export PNPM_HOME="/Users/bytedance/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm endexport PATH=/Users/bytedance/.local/bin:$PATH
# export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles
