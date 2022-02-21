"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","

" Set to auto read when a file is changed from the outside
set autoread

" Make undo persist between sessions
set undofile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Display line nubmer
set number

"Always show current position
set ruler


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Switch to normal mode from terminal mode in terminal buffer
if has('nvim')
    tnoremap <Esc> <C-\><C-n>
    tnoremap <C-v><Esc> <Esc>
endif

" Smart way to move between windows
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

if has('nvim')
    tnoremap <C-j> <C-\><C-n><C-W>j
    tnoremap <C-k> <C-\><C-n><C-W>k
    tnoremap <C-h> <C-\><C-n><C-W>h
    tnoremap <C-l> <C-\><C-n><C-W>l
end


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins  
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim plug 
call plug#begin('~/.local/share/nvim/plugged')

Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-obsession'
Plug 'radenling/vim-dispatch-neovim'
Plug 'w0rp/ale'
Plug 'mhinz/vim-grepper'
Plug 'scrooloose/nerdtree'
Plug 'janko/vim-test'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'

call plug#end()

" fuzzy finder
nnoremap <Leader>f :<C-u>Files<CR>

" asynchronous lint engine
let g:ale_linters = {
\   'javascript': ['eslint'],
\ }

let g:ale_fixers = {
\   'javascript': ['eslint'],
\ }

nmap <silent> [W <Plug>(ale_first)
nmap <silent> [w <Plug>(ale_previous)
nmap <silent> ]w <Plug>(ale_next)
nmap <silent> ]W <Plug>(ale_last)

" grepper
let g:grepper = {}
let g:grepper.tools = ['grep', 'git', 'rg']

nnoremap <Leader>* :Grepper -cword -noprompt<CR>

nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

" NERDTree
"let NERDTreeWinSize=40
"
"autocmd VimEnter * NERDTree
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"
"map <C-o> :NERDTreeToggle<CR>

" test
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>
let test#strategy = "dispatch"
