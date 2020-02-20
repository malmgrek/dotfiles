# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
PATH="$HOME/.local/bin:$HOME/bin:$PATH"
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
alias conda="/home/stastr/miniconda/bin/conda"
# alias activate="/home/stastr/miniconda/bin/activate"
source /home/stastr/miniconda/bin/activate sandbox

# Netgen directory
export NETGENDIR="/opt/netgen/bin"
alias netgen="/opt/netgen/bin/netgen"

# Source fzf key bindings
source /usr/share/fzf/shell/key-bindings.bash

#
# Install color themes
# --------------------
#
# bash -c  "$(wget -qO- https://git.io/vQgMr)"
#

#
# Powerline
# ---------
#
# https://powerline.readthedocs.io/en/latest/installation.html#repository-root
#
# Source also */powerline/bindings/tmux/powerline.conf in .tmux.conf
#
if [ -f `which powerline-daemon` ]; then
  powerline-daemon -q
  POWERLINE_BASH_CONTINUATION=1
  POWERLINE_BASH_SELECT=1
  . /home/stastr/.local/lib/python3.7/site-packages/powerline/bindings/bash/powerline.sh
fi

export TERM=tmux-256color
