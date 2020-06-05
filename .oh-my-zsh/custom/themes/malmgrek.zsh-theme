PROMPT="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
PROMPT+='$(conda_prompt_info)'
PROMPT+=' %{$fg[blue]%}📁%c%{$reset_color%} $(git_prompt_info)'

ZSH_THEME_CONDA_PROMPT_PREFIX="%{$fg_bold[magenta]%}🐍%{%}"
ZSH_THEME_CONDA_PROMPT_SUFFIX="%{%}"
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[cyan]%}%{%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{%} %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{%}"
