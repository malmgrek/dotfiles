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
HISTFILE="$HOME/.zsh_history"
HISTSIZW=1000
SAVEHIST=1000
source /usr/share/fzf/shell/key-bindings.zsh

# ==================================
# Zsh packages
# 
# NOTE:
#  - Autojump:
#    > sudo dnf install autojump-zsh
# ==================================

# Git-autosuggestions
updateZshAutosuggestions () {
  cd $ZSH/zsh-autosuggestions
  git pull
  cd $HOME
}
useZshAutosuggestions () {
  source $ZSH/zsh-autosuggestions/zsh-autosuggestions.zsh
}

# Zsh-syntax-highlighting
updateZshSyntaxHighlighting () {
  cd $ZSH/zsh-syntax-highlighting
  git pull
  cd $HOME
}
useZshSyntaxHighlighting () {
  source $ZSH/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
}

# Pure theme
updatePure () {
  cd $ZSH/pure
  git pull
  cd $HOME
}
usePure () {
  fpath+=$ZSH/pure
  autoload -U promptinit; promptinit
  prompt pure
}


# Update packages
updateZshPackages () {
  updateZshAutosuggestions
  updateZshSyntaxHighlighting
  updatePure
  print -P "%F{green} ✓ All .zsh packages updated, please re-source .zshrc %f"
}

useZshAutosuggestions
useZshSyntaxHighlighting
usePure
