PROMPT='%(?:%{$fg_bold[green]%}:%{$fg_bold[red]%})'
PROMPT+='$(conda_prompt_info)➜ '
PROMPT+='%{$fg_bold[blue]%}%c%{$reset_color%}'
PROMPT+=' $(git_super_status)'
PROMPT+='$ % '

ZSH_THEME_CONDA_PROMPT_PREFIX=""
ZSH_THEME_CONDA_PROMPT_SUFFIX=""

ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_bold[magenta]%}"
