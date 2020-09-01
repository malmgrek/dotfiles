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

# ============
# Zsh packages
# ============

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
  # Source the Pure style
  fpath+=$ZSH/pure
  autoload -U promptinit; promptinit
  prompt pure
}

sourceGitCompletion() {
  # Install git-completion
  #
  # Source script is located at
  #
  #   https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh
  #
  # NOTE: On some systems might require also installing `git-completion.bash`
  #       around which the zsh-version wraps.
  #
  zstyle ":completion:*:*:git:*" script $ZSH/git-completion/git-completion.zsh
  fpath+=$ZSH
  autoload -Uz compinit && compinit
}

updateZshPackages () {
  updateZshPackage "zsh-autopair"
  updateZshPackage "zsh-autosuggestions"
  updateZshPackage "zsh-syntax-highlighting"
  updateZshPackage "pure"
  updateZshPackage "powerlevel10k"
  print -P "%F{green}✓ All .zsh packages updated, please re-source .zshrc %f"
}

sourceZshPackages () {
  sourceZshPackage "zsh-autopair/autopair.zsh"
  sourceZshPackage "zsh-autosuggestions/zsh-autosuggestions.zsh"
  sourceZshPackage "zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  # sourceZshPackage "powerlevel10k/powerlevel10k.zsh-theme"
  sourcePure
  sourceGitCompletion
  source "$ZSH/swapcolors/swapcolors.zsh"
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
alias ls="exa"
alias ll="exa -l"
alias lla="exa -la"
alias llt="exa -T"
alias llfu="exa -bghGliS --git"

# Colors
export TERM=xterm-256color
export LS_COLORS=""
# eval $(dircolors)  # Uncommenting defaults LS_COLORS

