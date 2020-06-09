autocmd BufRead,BufNewFile *.zsh-theme set filetype=zsh

" Vim-plug
"
" Run :PlugInstall to install
"
call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'

call plug#end()

" Vim-airline
let g:airline_powerline_fonts = 1
let g:airline_theme='powerlineish'

" Use 256 colors (use only if temrinal emulator supports 256 colors)
set t_Co=256
colorscheme pablo

