" set leader key
let mapleader = " "

" go to previous buffer with C-p
nnoremap <C-p> <C-6>

" This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>

" rebind netrw
nnoremap <leader>pv :Ex<CR>

" fzf bind
nnoremap <C-f> :Files<space><CR>

" fix for instant markdown
set shell=bash\ -i

" Set shift width to 4 spaces.
set shiftwidth=4

" Set tab width to 8 columns.
set tabstop=4

" Use space characters instead of tabs.
set expandtab

" remove whitespace faster i guess
set softtabstop=4

" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

set backspace=indent,eol,start

" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

" Turn syntax highlighting on.
syntax on

" Do not save backup files.
set nobackup

" Do not let cursor scroll below or above N number of lines when scrolling.
set scrolloff=10

" While searching though a file incrementally highlight matching characters as you type.
set incsearch

" Ignore capital letters during search.
set ignorecase

" Override the ignorecase option if searching for capital letters.
" This will allow you to search specifically for capital letters.
set smartcase

" Show partial command you type in the last line of the screen.
set showcmd

" Show the mode you are on the last line.
set showmode

" Show matching words during a search.
set showmatch

" Use highlighting when doing a search.
set hlsearch

" Set the commands to save in history default number is 20.
set history=100

" set cursor to blinking line
let &t_EI = "\e[5 q"

" set hybrid line numbers
set number
set relativenumber

" enable custom colorscheme
colorscheme molokai
set t_Co=256

" templates
autocmd BufNewFile *.html 0r ~/.vim/skeletons/page.html
autocmd BufNewFile *.java 0r ~/.vim/skeletons/template.java

" plugins
call plug#begin()
    Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown', 'do': 'yarn install'}
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'vim-scripts/AutoComplPop'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'prabirshrestha/vim-lsp'
    Plug 'mattn/vim-lsp-settings'
    Plug 'tpope/vim-surround'
call plug#end()

" plugin settings
" turning off instant update for vim markdown
let g:instant_markdown_autostart = 0
let g:instant_markdown_slow = 1
let g:instant_markdown_theme = 'dark'

" mapping to start up instant markdown node server
nnoremap <C-i> :InstantMarkdownPreview<CR>
nnoremap <C-e> :InstantMarkdownStop<CR>

"autcomplete options
set complete+=kspell
set completeopt=menuone,preview
set shortmess+=c

" use spell dictionary for autocomplete with ctrl-p
set spell
highlight clear SpellBad
highlight clear SpellCap

" lsp config
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> K <plug>(lsp-hover)
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
" disable diagnostics support
let g:lsp_diagnostics_enabled = 0         
