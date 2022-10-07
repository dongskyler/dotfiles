#!/bin/sh

DOTFILE_DIR="$HOME/dotfiles"

# -- Zsh --
TARGET_ZSH_DIR="$HOME/.zsh"
ln -s "$DOTFILE_DIR/zsh" "$TARGET_ZSH_DIR"
ln -s "$DOTFILE_DIR/zsh/.zshenv" "$HOME/.zshenv"
ln -s "$DOTFILE_DIR/zsh/.zshrc" "$HOME/.zshrc"

# -- VIM --
TARGET_VIM_DIR="$HOME/.vim"
ln -s "$DOTFILE_DIR/vim" "$TARGET_VIM_DIR"
ln -s "$DOTFILE_DIR/.vimrc" "$HOME/.vimrc"

NVIM_CONFIG_DIR="$HOME/.config/nvim"
if [[ ! -d "$NVIM_CONFIG_DIR" ]]; then
  mkdir -p "$NVIM_CONFIG_DIR"
fi
ln -s "$TARGET_VIM_DIR/init.vim" "$NVIM_CONFIG_DIR/init.vim"

# -- Git --
TARGET_GITCONFIG_FILE="$HOME/.gitconfig"
if [[ -e "$TARGET_GITCONFIG_FILE" ]]; then
  mv "$TARGET_GITCONFIG_FILE" "$TARGET_GITCONFIG_FILE.backup"
fi
ln -s "$DOTFILE_DIR/gitconfig" "$TARGET_GITCONFIG_FILE"

# -- Ctags --
TARGET_CTAGS_DIR="$HOME/.ctags"
ln -s "$DOTFILE_DIR/ctags" "$TARGET_CTAGS_DIR"

# -- Tmux --
ln -s "$DOTFILE_DIR/tmux.conf" "$HOME/.tmux.conf"
