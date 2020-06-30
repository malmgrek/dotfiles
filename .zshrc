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

updateZshPackage () {
  # Git pull with logging message
  print -P "%F{blue}⏳Updating $1 %f"
  cd $ZSH/$1
  git pull
  cd $HOME
}
sourceZshPackage () {
  # Source a zsh package
  source $ZSH/$1
}

sourcePure () {
  # source the Pure style
  fpath+=$ZSH/pure
  autoload -U promptinit; promptinit
  prompt pure
}


# -------------------
# Update zsh packages
# -------------------
updateZshPackages () {
  updateZshPackage "zsh-autosuggestions"
  updateZshPackage "zsh-syntax-highlighting"
  updateZshPackage "pure"
  updateZshPackage "powerlevel10k"
  print -P "%F{green}✓ All .zsh packages updated, please re-source .zshrc %f"
}

# -------------------
# Source zsh packages
# -------------------
sourceZshPackages () {
  sourceZshPackage "zsh-autosuggestions/zsh-autosuggestions.zsh"
  sourceZshPackage "zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  # sourceZshPackage "powerlevel10k/powerlevel10k.zsh-theme"
  sourcePure
}

###################
sourceZshPackages #
###################


# =============
# Miscellaneous
# =============

# Zmv
autoload zmv
alias zcp="zmv -C"
alias zln="zmv -L"

# Conda
alias conda="$HOME/miniconda/bin/conda"

# Exa


# Alacritty: it seems hard to have all
#            ls colors show up correctly.
#            cf. also /etc/DIR_COLORS.
#            The below seems to do it
#            in a satisfactory way..
alias ls="ls --color=auto"
export TERM=xterm-256color
eval $(dircolors)

