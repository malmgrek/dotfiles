function conda_prompt_info(){
  [[ -n ${CONDA_DEFAULT_ENV} ]] || return
  echo "${ZSH_THEME_CONDA_PROMPT_PREFIX:=}${CONDA_DEFAULT_ENV:t}${ZSH_THEME_CONDA_PROMPT_SUFFIX:=}"
}
