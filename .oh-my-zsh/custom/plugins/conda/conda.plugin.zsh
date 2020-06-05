function conda_prompt_info(){
  [[ -n ${CONDA_DEFAULT_ENV} ]] || return
  echo "${CONDA_DEFAULT_ENV:t}"
}
