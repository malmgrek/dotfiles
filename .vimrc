autocmd BufRead,BufNewFile *.zsh-theme set filetype=zsh

" Vim-plug
"
" Run :PlugInstall to install
"
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

" Vim-airline
let g:airline_powerline_fonts = 1
let g:airline_theme='powerlineish'
set noshowmode  " Disable the default status line

" Use 256 colors (use only if temrinal emulator supports 256 colors)
set t_Co=256
colorscheme delek

