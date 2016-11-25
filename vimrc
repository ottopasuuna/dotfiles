"===========================================
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

"allow plugins to read filetypes
filetype plugin indent on
" filetype off

au FileType txt set tw=80 spell

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

set shiftwidth=4
set tabstop=4
set expandtab
" set noexpandtab
set softtabstop=4
set autoindent

"Highlight search items
" set hlsearch
set incsearch

set completeopt-=preview

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

"vim-plug initialization{{{


call plug#begin()
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'flazz/vim-colorschemes'
Plug '4Evergreen4/vim-hardy'
Plug 'Arduino-syntax-file'
Plug 'kien/ctrlp.vim'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/syntastic'
Plug 'xolox/vim-easytags'
Plug 'xolox/vim-misc' "for vim-easytags
Plug 'Valloric/ListToggle'
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'benekastah/neomake', {'on': 'Neomake'}
Plug 'majutsushi/tagbar'
Plug 'vim-scripts/TaskList.vim', {'on': 'TaskList'}
Plug 'edkolev/tmuxline.vim'
Plug 'jpalardy/vim-slime'
Plug 'jalvesaq/Nvim-R'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'jiangmiao/auto-pairs'
Plug 'tomtom/tcomment_vim'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'ntpeters/vim-better-whitespace'
Plug 'mhinz/vim-signify'
Plug 'bling/vim-bufferline'
if !has('nvim')
   Plug 'Shougo/neocomplete.vim'
else
   Plug 'Shougo/deoplete.nvim'
   Plug 'zchee/deoplete-clang'
   Plug 'zchee/deoplete-jedi'
   Plug 'davidhalter/jedi'
   let g:deoplete#enable_at_startup = 1
   let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
   let g:deoplete#sources#clang#clang_header = '/usr/lib/clang'
endif

call plug#end()
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
" plugin manager to install colorschemes)
syntax on
" colorscheme luna-term
" colorscheme Tomorrow-Night-Eighties
colorscheme molokai
"colorscheme ottopasuuna
" colorscheme badwolf
highlight Normal ctermbg=None

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
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"

let g:syntastic_mode_map = {"mode": "active"} "need to manually SyntasticCheck()

let g:task_rc_override = 'rc.defaultwidth=0'

"Neomake
" let g:neomake_c_gcc_maker = {
"    \ 'args': ['-Wall'],
"    \}
" let g:neomake_c_enabled_markers = ['gcc']
let g:neomake_warning_sign = {
   \ 'text': 'W',
   \ 'texthl': 'WarningMsg',
   \ }
let g:neomake_error_sign = {
   \ 'text': '✗',
   \ 'texthl': 'ErrorMsg',
   \ }

"neocomplete
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#max_list = 25
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

"}}}

" =========== Keyboard mappings ============ {{{

"Make it so we don't have to press shift when entering command mode
nnoremap ; :
vnoremap ; :

inoremap jk <ESC>

"quit vim
:nnoremap <leader><leader> :wq<CR>

"Saving keybinds
:nnoremap <C-s> :w<CR>
:inoremap <C-s> <ESC>:w<CR>a

"space in normal mode toggles folding
nnoremap <space> za

"switch to indent folding
nnoremap <leader>fi :set foldmethod=indent<CR>
"switch to marker folding
nnoremap <leader>fm :set foldmethod=marker<CR>

"insert computer science header
:nnoremap <leader>h :call CS_header()<CR>

"edit a file in new tab INTENTIONAL WHITESPACE
:nnoremap <leader>t :tabe 

"switch between buffers
:nnoremap <leader>n :bp<CR>
:nnoremap <leader>m :bn<CR>

"close buffer
:nnoremap <leader>q :bd<CR>

"move beween windows
:nnoremap <C-k> <C-w>k
:nnoremap <C-j> <C-w>j
:nnoremap <C-h> <C-w>h " doesn't work in neovim
:nnoremap <C-l> <C-w>l
:nnoremap <C-\<> 5<C-w><
:nnoremap <C-\>> 5<C-w>>

"Move line up or down
nnoremap - ddp
nnoremap _ ddkP

"Join line above (like J)
nnoremap K ddkPJ

"change function parameter
nnoremap cp ct,

"Move to begining and end of line
nnoremap H ^
nnoremap L $

"Insert newlines without leaving normal mode
"nnoremap <S-CR> O<Esc> Doesn't work....
nnoremap <CR> o<Esc>

"Edit vimrc in new tab
nnoremap <leader>ev :tabe $MYVIMRC<cr>

nnoremap <F1> :SCCompile<cr>
nnoremap <F2> :SCCompileRun<cr>.
nnoremap <F5> :NERDTreeToggle<CR>
nnoremap <F8> :TagbarToggle<cr>

"syntax checking
nnoremap <leader>sc :SyntasticCheck<CR>
let g:lt_location_list_toggle_map = '<leader>l'
let g:lt_quickfix_list_toggle_map = '<leader>p'


"Toggle spelling
nnoremap <leader>sp :set spell!<CR>

"better-whitespace plugin:
:nnoremap <leader>w :ToggleWhitespace<cr>
:nnoremap <leader>sw :StripWhitespace<cr>
let g:better_whitespace_filetypes_blacklist=['txt']

"Search for visually selected text
vnoremap // y/<C-R>"<CR>

"Java print hotkey
inoremap <C-p> System.out.println(

"append a period to the end of a line.
:nnoremap <leader>. A.<esc>0
"Capitalize current word in insert mode.
:inoremap <c-c> <esc>g~iwea

"put space around operator
nnoremap <leader><space> i <esc>la <esc>h

"abbreviations (auto insert/correct text)
iabbrev tehn then
iabbrev incldue include
iabbrev enld endl
iabbrev teh the

"}}}

" =============== Functions ================ {{{

"puts my header I need to include for school assignments. (confidential info
"removed) (oops, nevermind, I forgot to remove my info for many commits...).
function! CS_header()
    put ='/*'
    put ='    Carl Hofmeister'
    put ='    11162955' "Student number
    put ='    clh104' "NSID
    put ='*/'
    :normal 5kdd5jp
endfunction

"}}}

