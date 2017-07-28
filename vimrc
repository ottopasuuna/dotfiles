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

"Automatically run syntax checks on saving
autocmd! BufWritePost * Neomake

"allow plugins to read filetypes
filetype plugin on
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

"don't redraw whle executing macros, for performance
set lazyredraw

"Don't wrap lines
" set nowrap

" hide the netrw banner
let g:netrw_banner=0
" don't show hidden files by default. gh to show
let g:netrw_list_hide='^\..*'
let g:netrw_hide=1
let g:netrw_liststyle=3

"Show some nonprinting characters
set list lcs=tab:»·,eol:¬

"Tab settings

set autoindent
set shiftwidth=4
set tabstop=4
set expandtab
set softtabstop=4

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
" Plug '4Evergreen4/vim-hardy', {'for': 'arduino'}
" Plug 'Arduino-syntax-file', {'for': 'arduino'}
" Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf', {'dir': '~/.fzf'}
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-github-dashboard', {'on': ['GHDashboard', 'GHActivity']}
" Plug 'Shougo/unite.vim'
" Plug 'Shougo/vimproc.vim', {'do': 'make'}
Plug 'rust-lang/rust.vim', {'for': 'rust'}
" Plug 'scrooloose/syntastic'
Plug 'xolox/vim-misc' | Plug 'xolox/vim-easytags'
Plug 'Valloric/ListToggle'
Plug 'jaxbot/github-Issues.vim', {'on': ['Gissues', 'Giadd']}
" Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
" Plug 'tpope/vim-vinegar'
Plug 'benekastah/neomake',
Plug 'majutsushi/tagbar'
Plug 'vim-scripts/TaskList.vim', {'on': 'TaskList'}
Plug 'mbbill/undotree', {'on': 'UndotreeToggle'}
Plug 'edkolev/tmuxline.vim'
Plug 'jpalardy/vim-slime'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'jiangmiao/auto-pairs'
Plug 'tomtom/tcomment_vim'
Plug 'mattn/emmet-vim'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'ntpeters/vim-better-whitespace'
Plug 'mhinz/vim-signify'
Plug 'bling/vim-bufferline'
Plug 'vimwiki/vimwiki'
" Plug 'tbabej/taskwiki'
Plug 'blindFS/vim-taskwarrior'
Plug 'powerman/vim-plugin-AnsiEsc'
if !has('nvim')
   Plug 'Shougo/neocomplete.vim'
else
   Plug 'Shougo/deoplete.nvim'
   Plug 'zchee/deoplete-clang'
   Plug 'zchee/deoplete-jedi', {'for': 'python'}
   Plug 'davidhalter/jedi', {'for': 'python'}
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
let g:airline#extensions#bufferline#enabled = 1
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#whitespace#trailing_format = 't[%s]'
let g:airline#extensions#whitespace#mixed_indent_format = 'm[%s]'
let g:airline#extensions#whitespace#mixed_indent_file_format = 'mf[%s]'
let g:airline_mode_map = {
      \ '__' : '-',
      \ 'n'  : 'N',
      \ 'i'  : 'I',
      \ 'R'  : 'R',
      \ 'c'  : 'C',
      \ 'v'  : 'V',
      \ 'V'  : 'V',
      \ '' : 'V',
      \ 's'  : 'S',
      \ 'S'  : 'S',
      \ '' : 'S',
      \ }
" Hide vim's default mode indicator
set noshowmode

"load github token for github plugins
" source $HOME/.githubtoken.vim
" let g:gissues_lazy_load = 1
" let g:github_dashboard = {'username': 'ottopasuuna', 'password': g:github_access_token }

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

"Unite settings
" call unite#filters#matcher_default#use(['matcher_fuzzy'])
" call unite#custom#profile('default', 'context', {
"             \   'start_insert': 1,
"             \   'winheight': 10,
"             \   'direction': 'botright',
"             \ })

autocmd FileType unite call s:unite_settings()

"recomended settings for syntastic
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
"
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 2
" let g:syntastic_check_on_open = 0
" let g:syntastic_check_on_wq = 0
" let g:syntastic_error_symbol = "✗"
" let g:syntastic_warning_symbol = "⚠"
"
" let g:syntastic_mode_map = {"mode": "active"} "need to manually SyntasticCheck()

let g:task_rc_override = 'rc.defaultwidth=0'

" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }"Neomake

let g:neomake_c_gcc_maker = {
   \ 'args': ['-Wall -Werror -pedantic'],
   \}

let g:neomake_c_enabled_makers = ['gcc']
let g:neomake_python_enabled_makers = ['python', 'flake8']

let g:neomake_warning_sign = {
   \ 'text': '⚠',
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
tnoremap <ESC><ESC> <C-\><C-n>

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
 "Requires terminal patch for nvim:
:nnoremap <C-h> <C-w>h
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

"Bind for fzf
nnoremap <C-p> :Files<CR>

"Move to begining and end of line
nnoremap H ^
nnoremap L $

"Insert newlines without leaving normal mode
"nnoremap <S-CR> O<Esc> Doesn't work....
nnoremap <CR> o<Esc>

"Edit vimrc in new tab
nnoremap <leader>ev :tabe $MYVIMRC<cr>

nnoremap <F1> :e.<cr>
nnoremap <F2> :UndotreeToggle<cr>
nnoremap <F5> :Neomake!<CR>
nnoremap <F8> :TagbarToggle<cr>

"syntax checking
" nnoremap <leader>sc :SyntasticCheck<CR>
let g:lt_location_list_toggle_map = '<leader>l'
let g:lt_quickfix_list_toggle_map = '<leader>p'

"Git add and commit
nnoremap <leader>gc :Git commit -a

"Unite
" nnoremap <C-p> :Unite file file_rec buffer<CR>

"Unite
" nnoremap <C-p> :Unite file file_rec buffer<CR>

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

"Git/fugitive hotkeys
nnoremap <leader>gc :Git commit -a<CR>

"abbreviations (auto insert/correct text)
iabbrev tehn then
iabbrev incldue include
iabbrev enld endl
iabbrev teh the

"}}}

" =============== Functions ================ {{{

"settings for unite interface
function! s:unite_settings()
    imap <buffer> <C-j> <Plug>(unite_select_next_line)
    imap <buffer> <C-k> <Plug>(unite_select_previous_line)
endfunction

function! Header_guard(var)
    put ='#ifndef __' . a:var . '__'
    put ='#define __' . a:var . '__'
    put =''
    put =''
    put ='#endif /* __' . a:var . '__ */'
endfunction

"}}}

