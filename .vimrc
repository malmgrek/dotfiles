" Enable powerline backed statusbar
" set rtp+=$HOME/.local/lib/python3.7/site-packages/powerline/bindings/vim/
" set laststatus=2  " always show statusline

" Use 256 colors (use only if temrinal emulator supports 256 colors)
set t_Co=256

" Color scheme
colorscheme default

autocmd BufRead,BufNewFile *.zsh-theme set filetype=zsh
