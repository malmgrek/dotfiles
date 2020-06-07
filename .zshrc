# Zsh init file
#
# Stratos Staboulis, 2020

export ZSH="$HOME/.zsh"

#
# Misc/own
# --------
alias conda="$HOME/miniconda/bin/conda"
export TERM=xterm-256color  # Makes colors work in Tmux
alias ls="ls --color=auto"  # Enable directory colors

#
# Vi style editing mode
# ---------------------
bindkey -v
export KEYTIMEOUT=1  # Make mode change faster

#
# Fzf
# ---
export HISTFILE="$HOME/.zsh_history"
source /usr/share/fzf/shell/key-bindings.zsh

# ==================================
# Zsh packages
# 
# NOTE:
#  - Autojump:
#    > sudo dnf install autojump-zsh
# ==================================

# Git-autosuggestions
function updateZshAutosuggestions () {
  cd $ZSH/zsh-autosuggestions
  git pull
}
source $ZSH/zsh-autosuggestions/zsh-autosuggestions.zsh

# Zsh-syntax-highlighting
function updateZshSyntaxHighlighting () {
  cd $ZSH/zsh-syntax-highlighting
  git pull
}
source $ZSH/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ==================
# Pure theme package
# ==================
function updatePure () {
  cd $ZSH/pure
  git pull
}
fpath+=$ZSH/pure
autoload -U promptinit; promptinit
prompt pure


# Update packages
function updateZshPackages () {
  updateZshAutosuggestions
  updateZshSyntaxHighlighting
  updatePure
  cd $HOME
  print -P "%F{green} ✓ All .zsh packages updated, please re-source .zshrc %f"
}
