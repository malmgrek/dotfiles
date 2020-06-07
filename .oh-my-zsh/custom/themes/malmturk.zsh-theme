# PROMPT="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
# PROMPT+=' %{$fg[cyan]%}%c%{$reset_color%} $(git_super_status)'

# PROMPT='%B%m%~%b$(git_super_status) \$ '
PROMPT='$(conda_prompt_info)'
PROMPT+='%(?:%{$fg_bold[green]%} ⟶ :%{$fg_bold[red]%} ⟶ )'
# PROMPT+='%B%n%b'
PROMPT+='%{$fg_bold[blue]%}%c%{$reset_color%}'
PROMPT+=' $(git_super_status)'
PROMPT+='$ % '

ZSH_THEME_CONDA_PROMPT_PREFIX="[%{$fg_bold[cyan]%}"
ZSH_THEME_CONDA_PROMPT_SUFFIX="%{$reset_color%}]"

ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_bold[magenta]%}"
# ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
# ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[blue]%}) "
# ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
# ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
