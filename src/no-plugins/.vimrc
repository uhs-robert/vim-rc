"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer:
"       Robert Hill - @uhs-robert
"
" Sections:
"    => General
"    => VIM User Interface
"    => Colors and Fonts
"    => Files and backups
"    => Text, tab and indent related
"    => Moving around, tabs and buffers
"    => Editing mappings
"    => Plugin Setup
"    => Theme and Status Line
"    => Which Keys
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread
au FocusGained,BufEnter * silent! checktime

" With a map leader it's possible to do extra key combinations
let mapleader = " "

" Fast saving
nnoremap <C-s> :write<CR>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

" Enable mouse
set mouse=a

" Confirm on exit when closing unsaved file
set confirm

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM User Interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible

" Show line number on sidebar
set number

" Show line numbers on current line, releative numbers on others
set relativenumber

" Set 7 lines to the cursor - when moving vertically using j/k
set scrolloff=7

" Avoid garbled characters in Chinese language windows OS
let $LANG='en'
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Turn on the Wild menu
set wildmenu

" Wild mode setting
 set wildmode=list:longest

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Ignore modern dev files
set wildignore+=**/node_modules/**,**/dist/**,**/.next/**,**/build/**,**/target/**,**/.venv/**,**/__pycache__/**,**/.git/**

" Always show current position
set ruler

" Height of the command bar
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hidden

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" Automatically switch search to case-sensitive when search query contains an uppercase letter.
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set matchtime=2

" No annoying sound on errors
set belloff=all
set timeoutlen=500

" Add a bit extra margin to the left
set foldcolumn=1

" Fold based on indent levels
set foldmethod=indent

" Only fold up to x nested levels
set foldnestmax=3

" Disable folding by default
set nofoldenable

" Make signs stable (gitgutter won’t shift text)
set signcolumn=yes

" Faster CursorHold (gitgutter, linting, etc.)
set updatetime=300

" Better quickfix grep (works with :grep)
if executable('rg')
  set grepprg=rg\ --vimgrep\ --smart-case\ --hidden
  set grepformat=%f:%l:%c:%m
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

" Set regular expression engine automatically
set regexpengine=0

" " Enable 256 colors palette in Gnome Terminal
" if $COLORTERM == 'gnome-terminal'
"     set t_Co=256
" endif

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    " set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Insert 'tabstop' number of spaces when the 'tab' key is pressed.
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on x characters
set lbr

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart way to move between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Keep selection when indenting
vnoremap < <gv
vnoremap > >gv

" Move visual selection up/down
xnoremap J :move '>+1<CR>gv=gv
xnoremap K :move '<-2<CR>gv=gv

" Paste over selection without yanking it
xnoremap p "_dP

" System clipboard (only if available)
if has('clipboard')
  nnoremap <leader>y "+y
  vnoremap <leader>y "+y
  nnoremap <leader>Y "+Y
  nnoremap <leader>p "+p
  nnoremap <leader>P "+P
endif

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
au TabLeave * let g:lasttab = tabpagenr()

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set showtabline=2
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap H to first non-blank character
nnoremap H ^
xnoremap H ^

" Remap L to last non-blank character
nnoremap L g_
xnoremap L g_

" Remap J and K to scroll
nnoremap <silent> J :<C-u>execute 'normal!' (v:count1*20) . 'jzz'<CR>
nnoremap <silent> K :<C-u>execute 'normal!' (v:count1*20) . 'kzz'<CR>

" Move lines (Alt-j / Alt-k); non-recursive, works in visual mode
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
xnoremap <A-j> :m '>+1<CR>gv=gv
xnoremap <A-k> :m '<-2<CR>gv=gv

" --- Trim trailing whitespace on save (safe, opt-out capable)
function! s:TrimWhitespace() abort
  " allow b:keep_trailing_whitespace = 1 to skip
  if get(b:, 'keep_trailing_whitespace', 0)
    return
  endif
  let l:save = winsaveview()
  silent! keepjumps keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfunction

augroup TrimWhitespace
  autocmd!
  " Exclude filetypes where trailing spaces can be meaningful (e.g. markdown line breaks)
  autocmd BufWritePre * if &filetype !~# '^\%(markdown\|md\|rst\|help\)$' | call <SID>TrimWhitespace() | endif
augroup END


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin Setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" Plugin List
call plug#begin()
    " Status Line
    Plug 'itchyny/lightline.vim'
    " Github integration
    Plug 'tpope/vim-fugitive'
    " Show github gutter status
    Plug 'airblade/vim-gitgutter'
    " Comment/Uncommment selection via gcc
    Plug 'tpope/vim-commentary'
    " Nerdtree sidebar
    Plug 'preservim/nerdtree'
    " Indent link color
    Plug 'Yggdroot/indentLine'
    " Fzf
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    " Which key
    Plug 'liuchengxu/vim-which-key'
    " Syntax Highlighting
    Plug 'sheerun/vim-polyglot'
    " Themes
    Plug 'nelsyeung/high-contrast'
call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Theme and Status Line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Apply theme
set termguicolors
silent! colorscheme high_contrast

" Always show the status line
set laststatus=2

" Remove the mode status
set noshowmode

" Lightline config
let g:lightline = {
      \ 'colorscheme': 'powerlineish',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

" Indent Colors
let g:indentLine_setColors = 0
let g:indentLine_char_list = ['|', '¦', '┆', '┊']


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Which Keys
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Leader
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
let g:leader_map = {}

" One-key actions
let g:leader_map['e'] = [ 'NERDTreeToggle', 'nerdtree' ]

" Help
let g:leader_map['?'] = {
        \ 'name' : '+help' ,
        \ 'k' : ['Maps', 'show-keymaps'],
        \ 'c' : ['Commands', 'show-commands'],
        \ }

" Quit / Quickfix
let g:leader_map['q'] = {
        \ 'name' : '+quit' ,
        \ 'q' : [':qall!', 'quit-all'],
        \ 'o' : [':copen', 'quickfix-open'],
        \ 'c' : [':cclose', 'quickfix-close'],
        \ 's' : [':wq!', 'quit-and-save'],
        \ }

" Windows
let g:leader_map['w'] = {
        \ 'name' : '+windows' ,
        \ 'w' : ['<C-W>w', 'other-window'],
        \ 'd' : ['<C-W>c', 'delete-window'],
        \ '-' : ['<C-W>s', 'split-window-below'],
        \ '|' : ['<C-W>v', 'split-window-right'],
        \ '2' : ['<C-W>v', 'layout-double-columns'] ,
        \ 'h' : ['<C-W>h', 'window-left'],
        \ 'j' : ['<C-W>j', 'window-below'],
        \ 'l' : ['<C-W>l', 'window-right'],
        \ 'k' : ['<C-W>k', 'window-up'],
        \ 'H' : ['<C-W>5<', 'expand-window-left'],
        \ 'J' : [':resize +5', 'expand-window-below'],
        \ 'L' : ['<C-W>5>', 'expand-window-right'],
        \ 'K' : [':resize -5', 'expand-window-up'],
        \ '=' : ['<C-W>=', 'balance-window'],
        \ 's' : ['<C-W>s', 'split-window-below'],
        \ 'v' : ['<C-W>v', 'split-window-below'],
        \ '/' : ['Windows', 'fzf-window'],
    \ }

" Tabs
let g:leader_map['t'] = {
        \ 'name' : '+tabs',
        \ 'n' : [':tabnew', 'new-tab'],
        \ 'o' : [':tabonly', 'close-other-tabs'],
        \ 'c' : [':tabclose', 'close-tab'],
        \ 'h' : [':tabprevious', 'previous-tab'],
        \ 'l' : [':tabnext', 'next-tab'],
        \ 'z' : [':tablast', 'last-tab'],
    \ }

" Git
let g:leader_map['g'] = {
        \ 'name' : '+git',
        \ 'b' : ['Gblame', 'fugitive-blame'],
        \ 'c' : ['BCommits', 'commits-for-current-buffer'],
        \ 'C' : ['Gcommit', 'fugitive-commit'],
        \ 'd' : ['Gdiff', 'fugitive-diff'],
        \ 'e' : ['Gedit', 'fugitive-edit'],
        \ 'l' : ['Glog', 'fugitive-log'],
        \ 'r' : ['Gread', 'fugitive-read'],
        \ 's' : ['Gstatus', 'fugitive-status'],
        \ 'w' : ['Gwrite', 'fugitive-write'],
        \ 'p' : ['Git push', 'fugitive-push'],
        \ '/' : ['GFiles', 'find-gitfile'],
    \ }

" Files
let g:leader_map['f'] = {
        \ 'name' : '+files' ,
        \ 'b' : ['Gblame', 'fugitive-blame'],
        \ '/' : ['Files', 'fzf-files'],
    \ }

" Search
let g:leader_map['s'] = {
        \ 'name' : '+search',
        \ 'f' : ['Files', 'find-file'],
        \ 'g' : ['GFiles', 'find-gitfile'],
        \ 'b' : ['Buffers', 'find-buffer'],
        \ 'l' : ['BLines', 'find-in-buffer'],
        \ 'L' : ['Lines', 'find-in-all-buffers'],
        \ 'c' : ['Changes', 'changes-made'],
        \ 's' : ['Rg', 'rip-grep'],
        \ 'S' : ['RG', 'rip-grep-sensitive'],
    \ }

" User Interface Settings
let g:leader_map['u'] = {
        \ 'name' : '+ui',
        \ 'c' : ['Colors', 'set-colorscheme'],
        \ 's' : [':setlocal spell!', 'toggle-spelling'],
        \ 'w' : [':setlocal wrap!', 'toggle-wrap'],
        \ 'n' : [':setlocal number!', 'toggle-relative-number'],
        \ 'h' : [':noh', 'stop-highlight'],
    \ }

" Buffers
let g:leader_map['b'] = {
        \ 'name' : '+buffers',
        \ '/' : ['Buffers', 'search-buffers'],
        \ 'l' : ['bnext', 'next-buffer'],
        \ 'h' : ['bprevious', 'previous-buffer'],
        \ 'o' : [':%bd\|e#', 'close-other-buffers'],
    \ }


" Change commands
let g:leader_map['c'] = {
        \ 'name' : '+change',
        \ 'd' : [':cd %:p:h<cr>:pwd<', 'change-directory'],
    \ }

call which_key#register('<Space>', "g:leader_map")

" Nerd Tree
nnoremap <C-e> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" FZF
let g:fzf_vim = {}
