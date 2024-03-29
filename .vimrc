" Vim-plug
"
" Run :PlugInstall to install
"


function! EnsurePlugInstalled()
  let plugfile = $HOME.'/.vim/autoload/plug.vim'
  if !filereadable(plugfile)
    let url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    let curl = 'curl -fLo '.plugfile.' --create-dirs'
    echom system(curl.' '.url)
  endif
endfunction


call EnsurePlugInstalled()


" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif


call plug#begin('~/.vim/plugged')
Plug 'connorholyday/vim-snazzy'
Plug 'dracula/vim', {'as':'dracula'}
" Plug 'eigenfoo/stan-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'lifepillar/vim-solarized8'
Plug 'LnL7/vim-nix'
Plug 'mhartington/oceanic-next'
Plug 'rakr/vim-one'
Plug 'tomasiser/vim-code-dark'
Plug 'tomasr/molokai'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
call plug#end()



" Colors
"
" Use 24-bit (true-color) mode in Vim when outside tmux
"
" NOTE: A longer if statement for Neovim is given e.g. in
"       https://github.com/joshdick/onedark.vim
"
if exists("+termguicolors")
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
" set t_Co=256  " Use 256 (uncomment if supported in terminal)
syntax on

" Load colorscheme from a file so we can swap it
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
