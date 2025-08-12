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
"    => Theme and Status Line
"    => Leader Key Mappings
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
" => Theme and Status Line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Built-in colorscheme fallbacks
if exists('+termguicolors')
    set termguicolors
endif

" Try built-in themes in order of preference
silent! colorscheme lunaperche
if !exists('g:colors_name')
    silent! colorscheme elflord
endif

" Custom status line (replaces lightline)
set statusline=%F%m%r%h%w\ [%{&ff}]\ [%Y]\ [%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2

" Remove the mode status (statusline shows it)
set noshowmode

" Visual indentation (replaces indentLine plugin)
set list
set listchars=tab:│\ ,trail:·,extends:>,precedes:<,nbsp:+

" Enable netrw (built-in file explorer) - replaces NERDTree
let g:netrw_banner = 0        " Hide banner
let g:netrw_liststyle = 3     " Tree view
let g:netrw_browse_split = 4  " Open in previous window
let g:netrw_altv = 1          " Open splits to the right
let g:netrw_winsize = 25      " Set width to 25%

" Enhanced file finding
set path+=**                    " Search down into subfolders
set wildmenu                    " Display all matching files when tab completing
set wildignore+=*/node_modules/*,*/dist/*,*/.git/*

" Manual comment toggle (replaces vim-commentary)
function! ToggleComment()
    let comment_char = {
        \ 'vim': '"',
        \ 'python': '#',
        \ 'shell': '#',
        \ 'bash': '#',
        \ 'javascript': '//',
        \ 'typescript': '//',
        \ 'c': '//',
        \ 'cpp': '//',
        \ 'java': '//',
        \ 'php': '//',
        \ 'ruby': '#',
        \ 'perl': '#',
        \ 'sql': '--',
        \ 'lua': '--',
        \ 'html': '<!--',
        \ 'css': '/*'
    \ }
    
    let char = get(comment_char, &filetype, '#')
    
    if getline('.') =~ '^\s*' . escape(char, '/*')
        execute 's/^\(\s*\)' . escape(char, '/*') . '\s*/\1/'
    else
        execute 's/^\(\s*\)/\1' . char . ' /'
    endif
endfunction

nnoremap gcc :call ToggleComment()<CR>
vnoremap gc :call ToggleComment()<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Leader Key Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Simple help function for leader key mappings
function! ShowLeaderHelp()
    echo "Leader Key Mappings (<Space> as leader):"
    echo "  e          - File explorer (:Explore)"
    echo "  ?          - Show this help"
    echo ""
    echo "  q + key    - Quit operations:"
    echo "    qq       - Quit all"
    echo "    qs       - Save and quit"
    echo "    qo       - Open quickfix"
    echo "    qc       - Close quickfix"
    echo ""
    echo "  w + key    - Window operations:"
    echo "    ww       - Switch to other window"
    echo "    wd       - Delete window"
    echo "    w-       - Split horizontal"
    echo "    w|       - Split vertical"
    echo "    wh/j/k/l - Navigate windows"
    echo "    wH/J/K/L - Resize windows"
    echo "    w=       - Balance windows"
    echo ""
    echo "  t + key    - Tab operations:"
    echo "    tn       - New tab"
    echo "    tc       - Close tab"
    echo "    th/tl    - Previous/next tab"
    echo "    to       - Close other tabs"
    echo ""
    echo "  g + key    - Git operations:"
    echo "    gs       - Git status"
    echo "    gd       - Git diff"
    echo "    gl       - Git log"
    echo "    gb       - Git branches"
    echo "    ga       - Git add all"
    echo "    gc       - Git commit"
    echo "    gp       - Git push"
    echo ""
    echo "  f + key    - File operations:"
    echo "    ff       - Find file"
    echo "    fe       - File explorer"
    echo "    fv       - Vertical explorer"
    echo ""
    echo "  s + key    - Search operations:"
    echo "    sf       - Find file"
    echo "    sg       - Grep in files"
    echo "    sb       - List buffers"
    echo "    sl       - Search lines in buffer"
    echo "    sv       - Vim grep"
    echo ""
    echo "  u + key    - UI toggles:"
    echo "    us       - Toggle spelling"
    echo "    uw       - Toggle wrap"
    echo "    un       - Toggle line numbers"
    echo "    uh       - Clear highlights"
    echo "    ul       - Toggle listchars"
    echo ""
    echo "  b + key    - Buffer operations:"
    echo "    bb       - List buffers"
    echo "    bl/bh    - Next/previous buffer"
    echo "    bo       - Close other buffers"
    echo "    bd       - Delete buffer"
    echo ""
    echo "  c + key    - Change operations:"
    echo "    cd       - Change directory to current file"
endfunction

" Leader key mappings
nnoremap <silent> <leader> :call ShowLeaderHelp()<CR>

" One-key actions
nnoremap <leader>e :Explore<CR>

" Help
nnoremap <leader>? :call ShowLeaderHelp()<CR>

" Quit / Quickfix
nnoremap <leader>qq :qall!<CR>
nnoremap <leader>qo :copen<CR>
nnoremap <leader>qc :cclose<CR>
nnoremap <leader>qs :wq!<CR>

" Windows
nnoremap <leader>ww <C-W>w
nnoremap <leader>wd <C-W>c
nnoremap <leader>w- <C-W>s
nnoremap <leader>w<Bar> <C-W>v
nnoremap <leader>w2 <C-W>v
nnoremap <leader>wh <C-W>h
nnoremap <leader>wj <C-W>j
nnoremap <leader>wl <C-W>l
nnoremap <leader>wk <C-W>k
nnoremap <leader>wH <C-W>5<
nnoremap <leader>wJ :resize +5<CR>
nnoremap <leader>wL <C-W>5>
nnoremap <leader>wK :resize -5<CR>
nnoremap <leader>w= <C-W>=
nnoremap <leader>ws <C-W>s
nnoremap <leader>wv <C-W>v

" Tabs
nnoremap <leader>tn :tabnew<CR>
nnoremap <leader>to :tabonly<CR>
nnoremap <leader>tc :tabclose<CR>
nnoremap <leader>th :tabprevious<CR>
nnoremap <leader>tl :tabnext<CR>
nnoremap <leader>tz :tablast<CR>

" Git (shell-based commands)
nnoremap <leader>gs :!git status<CR>
nnoremap <leader>gd :!git diff<CR>
nnoremap <leader>gl :!git log --oneline -10<CR>
nnoremap <leader>gb :!git branch -a<CR>
nnoremap <leader>gp :!git push<CR>
nnoremap <leader>gc :!git commit<CR>
nnoremap <leader>ga :!git add .<CR>

" Files
nnoremap <leader>ff :find 
nnoremap <leader>fe :Explore<CR>
nnoremap <leader>fv :Vexplore<CR>

" Search
nnoremap <leader>sf :find 
nnoremap <leader>sg :vimgrep // **/*<Left><Left><Left><Left><Left><Left>
nnoremap <leader>sb :ls<CR>
nnoremap <leader>sl :g//<Left>
nnoremap <leader>sv :vimgrep 

" User Interface Settings
nnoremap <leader>us :setlocal spell!<CR>
nnoremap <leader>uw :setlocal wrap!<CR>
nnoremap <leader>un :setlocal number!<CR>
nnoremap <leader>uh :noh<CR>
nnoremap <leader>ul :setlocal list!<CR>

" Buffers
nnoremap <leader>bb :ls<CR>
nnoremap <leader>bl :bnext<CR>
nnoremap <leader>bh :bprevious<CR>
nnoremap <leader>bo :%bd<Bar>e#<CR>
nnoremap <leader>bd :bd<CR>

" Change commands
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" File Explorer (replaces NERDTree)
nnoremap <C-e> :Explore<CR>
nnoremap <C-f> :find 
