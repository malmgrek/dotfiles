" Vim-plug
"
" Run :PlugInstall to install
"
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'rakr/vim-one'
call plug#end()


" Colors
"
" Use 24-bit (true-color) mode in Vim when outside tmux
"
" NOTE: A longer if statement for Neovim is given e.g. in
"       https://github.com/joshdick/onedark.vim
"
if (has("termguicolors"))
  set termguicolors
endif
set t_Co=256  " Use 256 (uncomment if supported in terminal)
syntax on
let color = expand("~/.vim/color.vim")
if filereadable(color)
  exec "source" color
else
  colorscheme delek
endif


" Vim-airline
let g:airline_powerline_fonts = 1
let g:airline_theme='one'
set noshowmode  " Disable the default status line


" Additional file type definitions
autocmd BufRead,BufNewFile *.zsh-theme set filetype=zsh
