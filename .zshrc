# Zsh init file
#
# Stratos Staboulis, 2020

export ZSH="$HOME/.zsh"

#
# Vi style editing mode
# ---------------------
bindkey -v
export KEYTIMEOUT=1  # Make mode change faster

#
# Fzf
# ---
HISTFILE="$HOME/.zsh_history"
HISTSIZE=1000
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

# Powerlevel10k
updatePowerlevel10k () {
  cd $ZSH/powerlevel10k
  git pull
  cd $HOME
}
usePowerlevel10k () {
  source $ZSH/powerlevel10k/powerlevel10k.zsh-theme
}


# ---------------
# Update packages
# ---------------
updateZshPackages () {
  updatePowerlevel10k
  updatePure
  updateZshAutosuggestions
  updateZshSyntaxHighlighting
  print -P "%F{green} ✓ All .zsh packages updated, please re-source .zshrc %f"
}

# Use packages
useZshAutosuggestions
useZshSyntaxHighlighting
usePure
# usePowerlevel10k


# =============
# Miscellaneous
# =============

# Zmv
autoload zmv
alias zcp="zmv -C"
alias zln="zmv -L"

# Aliaases
alias conda="$HOME/miniconda/bin/conda"

# Alacritty: it seems hard to have all
#            ls colors show up correctly.
#            cf. also /etc/DIR_COLORS.
#            The below seems to do it
#            in a satisfactory way..
#            The below seems to do it
#            in a satisfactory way.
alias ls="ls --color=auto"
export TERM=xterm-256color
eval $(dircolors)

