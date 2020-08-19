" Vim-plug
"
" Run :PlugInstall to install
"
call plug#begin('~/.vim/plugged')
Plug 'connorholyday/vim-snazzy'
Plug 'dracula/vim', {'as':'dracula'}
Plug 'eigenfoo/stan-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'lifepillar/vim-solarized8'
Plug 'LnL7/vim-nix'
Plug 'tomasiser/vim-code-dark'
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

" Additional file type definitions
autocmd BufRead,BufNewFile *.zsh-theme set filetype=zsh
autocmd BufRead,BufNewFile .spacemacs set filetype=lisp

" Remove trailing whitespace on saving
autocmd BufWritePre * :%s/\s\+$//e
