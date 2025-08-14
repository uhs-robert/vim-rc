
" Maintainer:
"       Robert Hill - @uhs-robert
"
" Sections:
"    ## General
"    ## VIM User Interface
"    ## Colors and Fonts
"    ## Files and backups
"    ## Text, tab and indent related
"    ## Moving around, tabs and buffers
"    ## Custom Key Mappings
"    ## Theme and Status Line
"    ## Plugin Replacements
"    ### Visual Indent Guides
"    ### Netrw (Explorer)
"    ### Toggle Comments
"    ### Leader Key / Which Key Mappings
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = " "

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ## General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread
au FocusGained,BufEnter * silent! checktime

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
" ## VIM User Interface
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

" Faster CursorHold (linting, etc.)
set updatetime=300

" Better quickfix grep (works with :grep)
if executable('rg')
  set grepprg=rg\ --vimgrep\ --smart-case\ --hidden
  set grepformat=%f:%l:%c:%m
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ## Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

" Set regular expression engine automatically
set regexpengine=0

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
" ## Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ## Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Insert 'tabstop' number of spaces when the 'tab' key is pressed.
set smarttab

" 1 tab == n spaces
set shiftwidth=2
set tabstop=2

" Linebreak on x characters
set lbr

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ## Moving around, tabs, windows and buffers
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
" ## Custom Key Mappings
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
" ## Theme and Status Line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Built-in colorscheme fallbacks
if exists('+termguicolors')
  set termguicolors
endif

" Try built-in themes in order of preference
set background=dark
silent! colorscheme lunaperche
if !exists('g:colors_name')
  silent! colorscheme elflord
endif

" Git branch info
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

" Parse git branch info for status line
function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

" Optimized status line with autocommand-based mode colors
" Mode dictionary
let g:currentmode={
  \ 'n'  : 'NORMAL',
  \ 'no' : 'NORMAL',
  \ 'v'  : 'VISUAL',
  \ 'V'  : 'V-LINE',
  \ "\<C-V>" : 'V-BLOCK',
  \ 's'  : 'SELECT',
  \ 'S'  : 'S-LINE',
  \ "\<C-S>" : 'S-BLOCK',
  \ 'i'  : 'INSERT',
  \ 'R'  : 'REPLACE',
  \ 'Rv' : 'V-REPLACE',
  \ 'c'  : 'COMMAND',
  \ 'cv' : 'VIM-EX',
  \ 'ce' : 'EX',
  \ 'r'  : 'PROMPT',
  \ 'rm' : 'MORE',
  \ 'r?' : 'CONFIRM',
  \ '!'  : 'SHELL',
  \ 't'  : 'TERMINAL'
  \}

" Modular statusline construction
set laststatus=2
set noshowmode
set statusline=
set statusline+=%0*\ %{toupper(g:currentmode[mode()])}\  " The current mode
set statusline+=%4{StatuslineGit()}                      " Git branch
set statusline+=%1*\ %<%F%m%r%h%w\                       " File path, modified, readonly, helpfile, preview
set statusline+=%3*│                                     " Separator
set statusline+=%2*\ %Y\                                 " FileType
set statusline+=%3*│                                     " Separator
set statusline+=%2*\ %{''.(&fenc!=''?&fenc:&enc).''}     " Encoding
set statusline+=\ (%{&ff})                               " FileFormat (dos/unix..)
set statusline+=%=                                       " Right Side
set statusline+=%3*│                                     " Separator
set statusline+=%2*\ col:\ %02v\                         " Column number
set statusline+=%3*│                                     " Separator
set statusline+=%4*\ %3p%%\ %02l/%L\                     " Percentage of Doc, Line number / total lines
set statusline+=%0*\ %n\                                 " Buffer number

" Static highlight group colors
hi User1 ctermbg=15 ctermfg=0 guibg=#303030 guifg=#FFFFFF
hi User2 ctermfg=236 ctermbg=236 guibg=#252426 guifg=#FFFFFF
hi User3 ctermfg=236 ctermbg=236 guibg=#252426 guifg=#252426
hi User5 ctermfg=236 ctermbg=236 guibg=#252426 guifg=#F581F3

" Mode-based statusline color changes
augroup StatusLineModeColors
  autocmd!
    let s:last_bucket = ''

    " Get mode
    function! s:BucketForMode(m) abort
      let m = a:m
      " Insert modes: i, ic, ix
      if m[0] ==# 'i'
        return 'insert'
        " Replace modes: R, Rc, Rv, Rx (NB: case-sensitive)
      elseif m[0] ==# 'R'
        return 'replace'
        " Visual & Select: v, V, ^V, s, S, ^S
      elseif m =~# '^\%(v\|V\|\x16\|s\|S\|\x13\)'
        return 'visual'
        " Terminal
      elseif m ==# 't'
        return 'terminal'
        " Command-line & prompts: c, cv, ce, r, rm, r?, !
      elseif m[0] =~# '^\%(c\|r\|!\)'
        return 'cmdline'
        " Normal and operator-pending fall here
      else
        return 'normal'
      endif
    endfunction

    " Apply mode colors
    function! s:ApplyModeColor(bucket) abort
      if s:last_bucket ==# a:bucket | return | endif

      if a:bucket ==# 'insert'
        hi StatusLine guibg=#FFFFFF guifg=#4CAF50 ctermbg=15 ctermfg=2
        hi User0      guibg=#3E3C3B guifg=#4CAF50 ctermbg=15 ctermfg=2
        hi User4      guibg=#3E3C3B guifg=#4CAF50 ctermbg=15 ctermfg=2
      elseif a:bucket ==# 'visual'
        hi StatusLine guibg=#000000 guifg=#FF9800 ctermbg=0  ctermfg=3
        hi User0      guibg=#3E3C3B guifg=#FF9800 ctermbg=0  ctermfg=3
        hi User4      guibg=#3E3C3B guifg=#FF9800 ctermbg=0  ctermfg=3
      elseif a:bucket ==# 'replace'
        hi StatusLine guibg=#FFFFFF guifg=#F44336 ctermbg=15 ctermfg=1
        hi User0      guibg=#3E3C3B guifg=#F44336 ctermbg=15 ctermfg=1
        hi User4      guibg=#3E3C3B guifg=#F44336 ctermbg=15 ctermfg=1
      elseif a:bucket ==# 'cmdline'
        hi StatusLine guibg=#3E3C3B guifg=#F686FC ctermbg=15 ctermfg=5
        hi User0      guibg=#3E3C3B guifg=#F686FC ctermbg=15 ctermfg=5
        hi User4      guibg=#3E3C3B guifg=#F686FC ctermbg=15 ctermfg=5
      elseif a:bucket ==# 'terminal'
        hi StatusLine guibg=#FFFFFF guifg=#FF8800 ctermbg=15 ctermfg=208
        hi User0      guibg=#3E3C3B guifg=#FF8800 ctermbg=15 ctermfg=208
        hi User4      guibg=#3E3C3B guifg=#FF8800 ctermbg=15 ctermfg=208
      else " normal
        hi StatusLine guibg=#FFFFFF guifg=#2196F3 ctermbg=15 ctermfg=4
        hi User0      guibg=#3E3C3B guifg=#2196F3 ctermbg=15 ctermfg=4
        hi User4      guibg=#3E3C3B guifg=#2196F3 ctermbg=15 ctermfg=4
      endif

      let s:last_bucket = a:bucket
    endfunction

    " Prep before entering cmdline so colors flip immediately
    function! s:CmdlinePrep(ch) abort
    call <SID>ApplyModeColor('cmdline')
    silent! redrawstatus!
    return a:ch
    endfunction

    " Instant flip on :, /, ?
    nnoremap <expr> : <SID>CmdlinePrep(':')
    nnoremap <expr> / <SID>CmdlinePrep('/')
    nnoremap <expr> ? <SID>CmdlinePrep('?')

    " Use <SID> to call script-local functions from autocommands
    autocmd ModeChanged *:* call <SID>ApplyModeColor(<SID>BucketForMode(get(v:event,'new_mode',mode(1))))
    autocmd VimEnter *  call <SID>ApplyModeColor(<SID>BucketForMode(mode(1)))
augroup END

" Tab color scheme
set showtabline=2
highlight TabLine     guifg=#ffffff guibg=#252426 ctermfg=15 ctermbg=235
highlight TabLineSel  guifg=#000000 guibg=#FFD54F ctermfg=0  ctermbg=221
highlight TabLineFill  guifg=NONE guibg=#252426 ctermfg=NONE  ctermbg=235
augroup TablinePreserve
  autocmd!
  autocmd ColorScheme * highlight TabLine     guifg=#ffffff guibg=#252426 ctermfg=15 ctermbg=235
  autocmd ColorScheme * highlight TabLineSel  guifg=#000000 guibg=#FFD54F ctermfg=0  ctermbg=221
  autocmd ColorScheme * highlight TabLineFill guifg=NONE    guibg=#252426 ctermfg=NONE ctermbg=235
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ## Plugin Replacements
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ### Visual Indent Guides
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual indentation for space-indented files + hide $ at EOL
set list

function! SetIndentGuides() abort
  let sw = (&shiftwidth > 0 ? &shiftwidth : &tabstop)
  let bar = '│'                         " use '\|' if you prefer ASCII
  let lead = bar . repeat('\ ', max([sw - 1, 0]))
  let lcs = 'tab:' . bar . '\ ' .
        \ ',trail:·,extends:>,precedes:<,nbsp:+,eol:\ ' .
        \ ',leadmultispace:' . lead
  try
    execute 'set listchars=' . lcs
  catch /^Vim\%((\a\+)\)\=:E/
    " fallback if leadmultispace isn't supported
    execute 'set listchars=tab:' . bar . '\ ,trail:·,extends:>,precedes:<,nbsp:+,eol:\ ,lead:·'
  endtry
endfunction

augroup IndentGuides
  autocmd!
  autocmd VimEnter,ColorScheme * call SetIndentGuides()
  autocmd OptionSet shiftwidth call SetIndentGuides()
  autocmd OptionSet tabstop    call SetIndentGuides()
augroup END

" --- Colors ---
highlight IndentGuides     guifg=#555555 ctermfg=240
highlight IndentActive     guifg=#08436C ctermfg=220
highlight! link SpecialKey  IndentGuides
highlight! link Whitespace  IndentGuides
highlight! link NonText     IndentGuides

augroup IndentGuideColors
  autocmd!
  autocmd ColorScheme * highlight IndentGuides guifg=#555555 ctermfg=240
  autocmd ColorScheme * highlight IndentActive guifg=#ffcc00 ctermfg=220
  autocmd ColorScheme * highlight! link SpecialKey  IndentGuides
  autocmd ColorScheme * highlight! link Whitespace  IndentGuides
  autocmd ColorScheme * highlight! link NonText     IndentGuides
augroup END

" --- Active indent (block-bounded) ---
function! s:ActiveIndentUpdate() abort
  let sw = (&shiftwidth > 0 ? &shiftwidth : &tabstop)
  if sw <= 0
    if exists('w:activeindent_id') | call matchdelete(w:activeindent_id) | unlet w:activeindent_id | endif
    return
  endif

  let lnum = line('.')
  let ind  = indent(lnum)

  " No indent on current line → clear and bail
  if ind <= 0
    if exists('w:activeindent_id') | call matchdelete(w:activeindent_id) | unlet w:activeindent_id | endif
    return
  endif

  " Active guide column for this indent level (1, 1+sw, 1+2*sw, ...)
  let level = (ind - 1) / sw
  let col   = level * sw + 1

  " Contiguous block [top..bot] where indent >= col OR the line is blank
  let top = lnum
  while top > 1 && (indent(top - 1) >= col || getline(top - 1) =~# '^\s*$')
    let top -= 1
  endwhile
  let bot = lnum
  let last = line('$')
  while bot < last && (indent(bot + 1) >= col || getline(bot + 1) =~# '^\s*$')
    let bot += 1
  endwhile

  " Highlight the leading SPACE at that column inside the block
  let pat = '\%>' . (top - 1) . 'l\%<' . (bot + 1) . 'l^ \{' . (col - 1) . '}\zs '
  if exists('w:activeindent_id') | call matchdelete(w:activeindent_id) | endif
  let w:activeindent_id = matchadd('IndentActive', pat, 100)
endfunction

augroup ActiveIndent
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * call <SID>ActiveIndentUpdate()
  autocmd CursorMoved,CursorMovedI      * call <SID>ActiveIndentUpdate()
  autocmd OptionSet shiftwidth          * call <SID>ActiveIndentUpdate()
  autocmd OptionSet tabstop             * call <SID>ActiveIndentUpdate()
augroup END


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ### Netrw (Explorer)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable netrw (built-in file explorer) - replaces NERDTree
let g:netrw_banner = 0        " 0=hide banner, 1=show (default: 1)
let g:netrw_liststyle = 3     " 0=thin, 1=long, 2=wide, 3=tree (default: 0)
let g:netrw_browse_split = 3  " 0=same win, 1=hsplit, 2=vsplit, 3=tab, 4=prev win (default: 0)
let g:netrw_altv = 1          " 0=vertical split left, 1=right (default: 0)
let g:netrw_winsize = 33      " 0=use 'equalalways', 1–99=split size percent (~33%)

" Key mapping for netrw
function! NetrwMapping()
  " Go back in history
  nmap <buffer> H u
  " Go up a dir
  nmap <buffer> h -^
  " Open dir or file
  nmap <buffer> l <CR>
  " Toggle dot files
  nmap <buffer> . gh
  " Close preview
  nmap <buffer> P <C-w>z
  " Open file then close
  nmap <buffer> L <CR>:Lexplore<CR>
  " Mark file
  nmap <buffer> <TAB> mf
  " Unmark file
  nmap <buffer> <S-TAB> mF
  " Unmark all files
  nmap <buffer> <Leader><TAB> mu
  " Close
  nmap <buffer> q :Lexplore<CR>
endfunction

" Apply keymapping
augroup netrw_mapping
  autocmd!
  autocmd filetype netrw call NetrwMapping()
augroup END

" Enhanced file finding
set path+=**                    " Search down into subfolders
set wildmenu                    " Display all matching files when tab completing
set wildignore+=*/node_modules/*,*/dist/*,*/.git/*


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ### Toggle Comments
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
" ### Leader Key / Which Key Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --- Which Key Settings (user config) --------------------------------------
let g:LeaderMenuPos    = 'botright'     " one of: center, botright, topright, botleft, topleft, cursor
let g:LeaderMenuMargin = [1, 2, 1, 2] " top, right, bottom, left (only used for screen-anchored positions)
let g:LeaderMenuLabel = '␣'          " how to display the leader key in breadcrumbs

" State (script-local)
let s:crumbs = []   " display labels, e.g. ['␣','Windows']
let s:stack  = []   " function names, e.g. ['LeaderRoot','WinMenu']

" Make mappings not rush you; keep fast terminal keycodes
set timeout timeoutlen=300
set ttimeout ttimeoutlen=50


" --- Tiny nav helpers ---------------------------------------------------
" Get key pressed as string
function! s:getkey() abort
  return exists('*getcharstr') ? getcharstr() : nr2char(getchar())
endfunction

" Go back to previous sub menu
function! s:Back() abort
  if len(s:stack) > 1
    call remove(s:crumbs, -1)
    call remove(s:stack,  -1)
    let parent = s:stack[-1]
    execute 'call <SID>' . parent . '()'
  endif
endfunction

" Add crumb label, call function
function! s:Push(label, fname) abort
  call add(s:crumbs, a:label)
  call add(s:stack,  a:fname)
  execute 'call <SID>' . a:fname . '()'
endfunction

" Build a submenu entry that *navigates* (calls Push with label+fn)
function! s:Go(label, fn) abort
  return [a:label, 'call <SID>Push(' . string(a:label) . ',' . string(a:fn) . ')']
endfunction

" Build a simple command entry (runs an ex-cmd)
function! s:Cmd(label, ex) abort
  return [a:label, a:ex]
endfunction

" Type a cmdline stub and leave the user at the prompt (no <CR>)
function! s:TypeCmd(stub) abort
  " :<C-u> clears any leftovers; 'n' = no-remap, immediate
  call feedkeys(':' . "\<C-u>" . a:stub, 'n')
endfunction

" Toggle any local option by name
function! s:Toggle(opt) abort
  execute 'setlocal ' . a:opt . '!'
endfunction

" Resize helpers using a single knob
let g:LeaderResizeStep = 5
function! s:Resize(delta) abort
  execute 'resize ' . (a:delta)
endfunction
function! s:VResize(delta) abort
  execute 'vertical resize ' . (a:delta)
endfunction

" Build a dict menu from a compact spec: [ [key, entry], ... ]
function! s:BuildMenu(spec) abort
  let m = {}
  for [k, entry] in a:spec
    let m[k] = entry
  endfor
  return m
endfunction

" --- Core selector (popup if available, split otherwise) ----------------
" Overlay menu if Vim supports popups; otherwise fall back to split
function! s:Which(title, menu) abort
  if has('popupwin') | call s:WhichPopup(a:title, a:menu)
  else               | call s:WhichSplit(a:title, a:menu)
  endif
endfunction

" Set title
function! s:_title(base) abort
  return !empty(s:crumbs) ? join(s:crumbs, ' › ') : a:base
endfunction

" --- Popup Selector (Modern Vim) ----------------------------------
function! s:WhichPopup(title, menu) abort
  " Build lines
  let lines = [s:_title(a:title), '']
  for k in sort(keys(a:menu))
    call add(lines, printf('  %-3s %s', k, a:menu[k][0]))
  endfor

  " Compute width for nicer centering
  let w = 0
  for l in lines
    let w = max([w, strdisplaywidth(l)])
  endfor
  let w = min([&columns - 4, w + 4])  " padding
  let h = len(lines)

    " Resolve position
  let pos = get(g:, 'LeaderMenuPos', 'center')
  let m = get(g:, 'LeaderMenuMargin', [1, 2, 1, 2]) " top, right, bottom, left
  let [mt, mr, mb, ml] = [m[0], m[1], m[2], m[3]]

  if pos ==# 'center'
    let line = max([1, float2nr((&lines - h)/2)])
    let col  = max([1, float2nr((&columns - w)/2)])
  elseif pos ==# 'botright'
    let line = max([1, &lines  - h - mb])
    let col  = max([1, &columns - w - mr])
  elseif pos ==# 'topright'
    let line = max([1, 1 + mt])
    let col  = max([1, &columns - w - mr])
  elseif pos ==# 'botleft'
    let line = max([1, &lines  - h - mb])
    let col  = max([1, 1 + ml])
  elseif pos ==# 'topleft'
    let line = max([1, 1 + mt])
    let col  = max([1, 1 + ml])
  elseif pos ==# 'cursor'
    " anchor to cursor; margins act as offsets
    let line = 'cursor+' . string(max([0, mt]))
    let col  = 'cursor+' . string(max([0, ml]))
  else
    " fallback: center
    let line = max([1, float2nr((&lines - h)/2)])
    let col  = max([1, float2nr((&columns - w)/2)])
  endif

 " Create popup
  let id = popup_create(lines, {
    \ 'line': line,
    \ 'col':  col,
    \ 'minwidth': w,
    \ 'maxwidth': w,
    \ 'padding': [0,1,0,1],
    \ 'border': [1,1,1,1],
    \ 'borderchars': ['─','│','─','│','┌','┐','┘','└'],
    \ 'zindex': 300,
    \ 'highlight': 'Pmenu',
    \ 'borderhighlight': ['PmenuSel'],
    \ })

  redraw!
  let key = s:getkey()
  call popup_close(id)

  " Escape or go back to previous menu
  if key ==# "\<Esc>" | return | endif
  if key ==# "\<BS>" || key ==# "\<C-h>" | call s:Back() | return | endif

  " Go to sub menu or execute command
  if has_key(a:menu, key)
    " item = [label, ex-command string]
    execute a:menu[key][1]
  endif
endfunction

" --- Split fallback (used on older Vim) -----------------------------------
function! s:WhichSplit(title, menu) abort
  botright 10new
  setlocal buftype=nofile bufhidden=wipe noswapfile nobuflisted
  setlocal modifiable
  let lines = [s:_title(a:title), '']
  for k in sort(keys(a:menu))
    call add(lines, printf('  %-3s => %s', k, a:menu[k][0]))
  endfor
  call setline(1, lines)
  setlocal nomodifiable
  normal! gg
  redraw!
  let key = s:getkey()
  bwipeout!

  if key ==# "\<Esc>" | return | endif
  if key ==# "\<BS>" || key ==# "\<C-h>" | call s:Back() | return | endif

  if has_key(a:menu, key)
    execute a:menu[key][1]
  endif
endfunction


" --- Sub-menus ---------------------------------------------------------------
function! s:WinMenu() abort
  let step = get(g:, 'LeaderResizeStep', 10)
  let spec = [
    \ ['w', s:Cmd('Other window',      'wincmd w')],
    \ ['d', s:Cmd('Delete window',     'wincmd c')],
    \ ['-', s:Cmd('Split horizontal',  'wincmd s')],
    \ ['|', s:Cmd('Split vertical',    'wincmd v')],
    \ ['h', s:Cmd('Go left',           'wincmd h')],
    \ ['j', s:Cmd('Go down',           'wincmd j')],
    \ ['k', s:Cmd('Go up',             'wincmd k')],
    \ ['l', s:Cmd('Go right',          'wincmd l')],
    \ ['H', s:Cmd('Wider  ←',          'call <SID>VResize(-'.step.')')],
    \ ['L', s:Cmd('Narrower →',        'call <SID>VResize('.step.')')],
    \ ['K', s:Cmd('Shorter ↑',         'call <SID>Resize(-'.step.')')],
    \ ['J', s:Cmd('Taller  ↓',         'call <SID>Resize('.step.')')],
    \ ['=', s:Cmd('Balance',           'wincmd =')],
    \ ['x', s:Cmd('Exchange with next','wincmd r')],
    \ ['m', s:Cmd('Move to new tab',   'tab split | wincmd T')],
    \ ]
  call s:Which('Windows', s:BuildMenu(spec))
endfunction

function! s:TabMenu() abort
  let spec = [
    \ ['n', s:Cmd('New tab',          'tabnew')],
    \ ['c', s:Cmd('Close tab',        'tabclose')],
    \ ['o', s:Cmd('Close other tabs', 'tabonly')],
    \ ['h', s:Cmd('Prev tab',         'tabprevious')],
    \ ['l', s:Cmd('Next tab',         'tabnext')],
    \ ['z', s:Cmd('Last tab',         'tablast')],
    \ ['<', s:Cmd('Move left',        'tabmove -1')],
    \ ['>', s:Cmd('Move right',       'tabmove +1')],
    \ ['1', s:Cmd('Go to tab 1',      'tabfirst')],
    \ ['2', s:Cmd('Go to tab 2',      'execute "tabnext 2"')],
    \ ['3', s:Cmd('Go to tab 3',      'execute "tabnext 3"')],
    \ ['4', s:Cmd('Go to tab 4',      'execute "tabnext 4"')],
    \ ['5', s:Cmd('Go to tab 5',      'execute "tabnext 5"')],
    \ ['6', s:Cmd('Go to tab 6',      'execute "tabnext 6"')],
    \ ['7', s:Cmd('Go to tab 7',      'execute "tabnext 7"')],
    \ ['8', s:Cmd('Go to tab 8',      'execute "tabnext 8"')],
    \ ['9', s:Cmd('Go to tab 9',      'execute "tabnext 9"')],
    \ ]
  call s:Which('Tabs', s:BuildMenu(spec))
endfunction

function! s:BufMenu() abort
  let spec = [
    \ ['b', s:Cmd('List buffers',       'ls')],
    \ ['l', s:Cmd('Next buffer',        'bnext')],
    \ ['h', s:Cmd('Prev buffer',        'bprevious')],
    \ ['a', s:Cmd('Alternate buffer',   'buffer #')],
    \ ['d', s:Cmd('Delete buffer',      'bd')],
    \ ['D', s:Cmd('Wipeout buffer',     'bwipeout')],
    \ ['o', s:Cmd('Only this buffer',   'execute "%bd | e# | bd #"')],
    \ ['p', s:Cmd('Pick by number :b ', 'call <SID>TypeCmd("b ")')],
    \ ]
  call s:Which('Buffers', s:BuildMenu(spec))
endfunction

function! s:FileMenu() abort
  let spec = [
    \ ['e', s:Cmd('Explore (netrw)',     'Explore')],
    \ ['v', s:Cmd('Explore vertical',    'Lexplore')],
    \ ['f', s:Cmd('Find file (:find)',   'call <SID>TypeCmd("find ")')],
    \ ['w', s:Cmd('Write',               'write')],
    \ ['W', s:Cmd('Save As (:w )',       'call <SID>TypeCmd("w ")')],
    \ ['r', s:Cmd('Edit alternate file', 'e #')],
    \ ]
  call s:Which('Files', s:BuildMenu(spec))
endfunction

function! s:SearchMenu() abort
  let spec = [
    \ ['/', s:Cmd('Forward search',       'call <SID>TypeCmd("/")')],
    \ ['?', s:Cmd('Backward search',      'call <SID>TypeCmd("?")')],
    \ ['*', s:Cmd('Search word under *',  'normal *')],
    \ ['#', s:Cmd('Search word under #',  'normal #')],
    \ ['b', s:Cmd('vimgrep current %',    'call <SID>TypeCmd("vimgrep /%")')],
    \ ['g', s:Cmd('vimgrep project',      'call <SID>TypeCmd("vimgrep ")')],
    \ ['l', s:Cmd('Global :g// (print)',  'call <SID>TypeCmd("g/")')],
    \ ]
  call s:Which('Search', s:BuildMenu(spec))
endfunction

function! s:GitMenu() abort
  let spec = [
    \ ['s', s:Cmd('status',          '!git status')],
    \ ['d', s:Cmd('diff',            '!git diff')],
    \ ['l', s:Cmd('log --oneline',   '!git log --oneline -10')],
    \ ['b', s:Cmd('branch -a',       '!git branch -a')],
    \ ['a', s:Cmd('add .',           '!git add .')],
    \ ['A', s:Cmd('add -p',          '!git add -p')],
    \ ['c', s:Cmd('commit',          '!git commit')],
    \ ['p', s:Cmd('push',            '!git push')],
    \ ['P', s:Cmd('pull',            '!git pull --rebase')],
    \ ['o', s:Cmd('checkout/switch', 'call <SID>TypeCmd("!git switch ")')],
    \ ['t', s:Cmd('stash',           'call <SID>TypeCmd("!git stash ")')],
    \ ]
  call s:Which('Git', s:BuildMenu(spec))
endfunction

function! s:UIMenu() abort
  let spec = [
    \ ['s', s:Cmd('Toggle spell',        'call <SID>Toggle("spell")')],
    \ ['w', s:Cmd('Toggle wrap',         'call <SID>Toggle("wrap")')],
    \ ['n', s:Cmd('Toggle number',       'call <SID>Toggle("number")')],
    \ ['r', s:Cmd('Toggle relativenumber','call <SID>Toggle("relativenumber")')],
    \ ['c', s:Cmd('Toggle cursorline',   'call <SID>Toggle("cursorline")')],
    \ ['g', s:Cmd('Toggle signcolumn',   'setlocal signcolumn='.
    \                                     (&l:signcolumn ==# 'yes' ? 'no' : 'yes'))],
    \ ['l', s:Cmd('Toggle listchars',    'call <SID>Toggle("list")')],
    \ ['h', s:Cmd('Clear highlights',    'noh')],
    \ ]
  call s:Which('UI toggles', s:BuildMenu(spec))
endfunction

function! s:QuitMenu() abort
  let spec = [
    \ ['q', s:Cmd('Quit all!',        'qall!')],
    \ ['s', s:Cmd('Save & quit',      'wq!')],
    \ ]
  call s:Which('Quit / Quickfix', s:BuildMenu(spec))
endfunction

function! s:QuickfixMenu() abort
  let spec = [
    \ ['o', s:Cmd('Open quickfix',     'copen')],
    \ ['c', s:Cmd('Close quickfix',    'cclose')],
    \ ['n', s:Cmd('Next quickfix',     'cnext')],
    \ ['p', s:Cmd('Prev quickfix',     'cprev')],
    \ ['l', s:Cmd('Open loclist',      'lopen')],
    \ ['x', s:Cmd('Close loclist',     'lclose')],
    \ ]
  call s:Which('Quickfix/Loclist', s:BuildMenu(spec))
endfunction


" --- Root menu and top-level leader bindings -------------------------------
function! s:LeaderRoot() abort
  let s:crumbs = [get(g:, 'LeaderMenuSpaceLabel', '␣')]
  let s:stack  = ['LeaderRoot']

  let spec = [
    \ ['b', s:Go('+Buffers', 'BufMenu')],
    \ ['e', s:Cmd('Explorer', 'Lexplore')],
    \ ['f', s:Go('+Files',   'FileMenu')],
    \ ['g', s:Go('+Git',     'GitMenu')],
    \ ['q', s:Go('+Quit',    'QuitMenu')],
    \ ['s', s:Go('+Search',  'SearchMenu')],
    \ ['t', s:Go('+Tabs',    'TabMenu')],
    \ ['u', s:Go('+UI',      'UIMenu')],
    \ ['w', s:Go('+Windows', 'WinMenu')],
    \ ['x', s:Go('+Quickfix', 'QuickfixMenu')],
    \ ]

  call s:Which('Leader', s:BuildMenu(spec))
endfunction

" Leader = open root menu
nnoremap <silent> <leader><leader> :call <SID>LeaderRoot()<CR>
nnoremap <silent> <leader> :call <SID>LeaderRoot()<CR>

" File Explorer (replaces NERDTree)
nnoremap <C-e> :Lexplore<CR>
nnoremap <C-f> :find

