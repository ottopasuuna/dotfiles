"===========================================
"
"               Carl's .vimrc
"===========================================

" ============ General settings ============= {{{

"Disable vi support
"Some features don't work otherwise
set nocompatible

"Enable hidden buffers
set hidden

"Disable the swapfile and backups
set noswapfile
set nobackup

set enc=utf8

"Automatically load vimrc after saving
autocmd! bufwritepost ~/.vimrc source %

set rtp+=~/.vim/bundle/Vundle.vim

"allow plugins to read filetypes
filetype plugin indent on
filetype off

"Allow mouse support
set mouse=a

set clipboard=unnamedplus

"Set leader key to ','
let mapleader=','
let maplocalleader = "\\"

"Turn on line numbers
set number

"Don't wrap lines
" set nowrap


"Show some nonprinting characters
set list lcs=tab:»·,eol:¬

"Tab settings
"set shiftwidth=4
"set expandtab
"set softtabstop=4
set autoindent

"Highlight search items
" set hlsearch
set incsearch

"Create code folds via '{{{ <code> }}}'
" zo   open fold
" zc   clse fold
" za   toggle fold
set foldmethod=marker

"slimv configuration
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "1"}

"}}}

" =========== Plugin settings ============== {{{
"

"Vundle initialization{{{
call vundle#begin()
Plugin 'gmark/Vundle.vim'
Plugin 'bling/vim-airline'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/syntastic'
Plugin 'edkolev/tmuxline.vim'
Plugin 'sjl/gundo.vim'
Plugin 'jpalardy/vim-slime'
Plugin 'tpope/vim-surround'
Plugin 'SingleCompile'
Plugin 'majutsushi/tagbar'
"Plugin 'techlivezheng/vim-plugin-minibufexpl'
Plugin 'tomtom/tcomment_vim'
Plugin 'jeffkreeftmeijer/vim-numbertoggle'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'mhinz/vim-signify'
Plugin 'bling/vim-bufferline'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'Shougo/neocomplete.vim'

call vundle#end()
"}}}

" turn on vim airline
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline_theme='powerlineish'
let g:airline#extensions#tmuxline#enabled = 0
let g:airline#extensions#bufferline#enabled = 0
" Hide vim's default mode indicator
set noshowmode

"syntax highlighting (added here to allow for
" pathogeten to install colorschemes)
syntax on
" colorscheme luna-term
colorscheme Tomorrow-Night-Eighties
"colorscheme ottopasuuna
"colorscheme badwolf
let g:tmuxline_preset = {
    \'a' : '#S',
    \'win' : ['#I #W'],
    \'cwin' : ['#I:#P #W'],
    \'y' : '%H:%M|%b%d',
    \'z' : ['#(whoami)@#H'],
    \'options' : {'status-justify' : 'left'}}

"recomended settings for syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"neocomplete
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

"}}}

" =========== Keyboard mappings ============ {{{

"Make it so we don't have to press shift when entering command mode
nnoremap ; :
vnoremap ; :

inoremap jk <ESC>

"Saving keybinds
:nnoremap <C-s> :w<CR>
:inoremap <C-s> <ESC>:w<CR>a

:nnoremap <C-q> :wq<CR>
:inoremap <C-q> <ESC>:wq<CR>

"space in normal mode toggles folding
nnoremap <space> za

"insert computer science header
:nnoremap <leader>h :call CS_header()<CR>

"edit a file in new tab
:nnoremap <leader>t :tabe

"Move line up or down
nnoremap - ddp
nnoremap _ ddkP

"Insert newlines without leaving normal mode
"nnoremap <S-CR> O<Esc> Doesn't work....
nnoremap <CR> o<Esc>

nnoremap <leader>ev :tabe $MYVIMRC<cr>

nnoremap <F1> :SCCompile<cr>
nnoremap <F2> :SCCompileRun<cr>
nnoremap <F5> :GundoToggle<CR>
nnoremap <F8> :TagbarToggle<cr>

"better-whitespace plugin:
:nnoremap <leader>w :ToggleWhitespace<cr>
:nnoremap <leader>sw :StripWhitespace<cr>
let g:better_whitespace_filetypes_blacklist=['txt']


"toggle case of current word in insert
":inoremap <c-u> <esc>g~iwea

:nnoremap <leader>. A.<esc>0
:inoremap <c-c> <esc>g~iwea

"abbreviations (auto insert/correct text)
iabbrev tehn then

"}}}

" =============== Functions ================ {{{

"puts my header I need to include for school assignments. (confidential info
"removed).
function! CS_header()
    put ='/*'
    put ='    Carl Hofmeister'
    put ='    11162955' "Student number
    put ='    clh104' "NSID
    put ='    Lecture Sec. 02B'
    put ='    Lab Sec. L02'
    put ='*/'
    :normal 7kdd7jp
endfunction

"}}}

