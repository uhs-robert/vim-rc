"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
" --- Which Key settings (user config) --------------------------------------
let g:LeaderMenuPos    = 'botright'     " one of: center, botright, topright, botleft, topleft, cursor
let g:LeaderMenuMargin = [1, 2, 1, 2] " top, right, bottom, left (only used for screen-anchored positions)

" Make mappings not rush you; keep fast terminal keycodes
set timeout timeoutlen=300
set ttimeout ttimeoutlen=50

" Overlay menu if Vim supports popups; otherwise fall back to split
function! s:Which(title, menu) abort
  if has('popupwin')
    call s:WhichPopup(a:title, a:menu)
  else
    call s:WhichSplit(a:title, a:menu)
  endif
endfunction

" --- Popup implementation (no layout shift) -------------------------------
function! s:WhichPopup(title, menu) abort
  " Build lines
  let lines = [a:title, '']
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
  let pos    = get(g:, 'LeaderMenuPos', 'center')
  let m      = get(g:, 'LeaderMenuMargin', [1, 2, 1, 2]) " t r b l
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
  let ch = nr2char(getchar())
  call popup_close(id)

  if has_key(a:menu, ch)
    execute a:menu[ch][1]
  endif
endfunction

" --- Split fallback (used on older Vim) -----------------------------------
function! s:WhichSplit(title, menu) abort
  botright 10new
  setlocal buftype=nofile bufhidden=wipe noswapfile nobuflisted
  setlocal modifiable
  let lines = [a:title, '']
  for k in sort(keys(a:menu))
    call add(lines, printf('  %-3s %s', k, a:menu[k][0]))
  endfor
  call setline(1, lines)
  setlocal nomodifiable
  normal! gg
  redraw!
  let ch = nr2char(getchar())
  bwipeout!
  if has_key(a:menu, ch)
    execute a:menu[ch][1]
  endif
endfunction


" --- Sub-menus ---------------------------------------------------------------
function! s:WinMenu() abort
  call s:Which('Windows (press key):', {
  \ 'w': ['Other window',          'wincmd w'],
  \ 'd': ['Delete window',         'wincmd c'],
  \ '-': ['Split horizontal',      'wincmd s'],
  \ '|': ['Split vertical',        'wincmd v'],
  \ 'h': ['Go left',               'wincmd h'],
  \ 'j': ['Go down',               'wincmd j'],
  \ 'k': ['Go up',                 'wincmd k'],
  \ 'l': ['Go right',              'wincmd l'],
  \ 'H': ['Resize wider',          'execute "vertical resize -5"'],
  \ 'L': ['Resize narrower',       'execute "vertical resize +5"'],
  \ 'K': ['Resize shorter',        'execute "resize -5"'],
  \ 'J': ['Resize taller',         'execute "resize +5"'],
  \ '=': ['Balance',               'wincmd ='],
  \ })
endfunction

function! s:TabMenu() abort
  call s:Which('Tabs (press key):', {
  \ 'n': ['New tab',               'tabnew'],
  \ 'c': ['Close tab',             'tabclose'],
  \ 'o': ['Close other tabs',      'tabonly'],
  \ 'h': ['Prev tab',              'tabprevious'],
  \ 'l': ['Next tab',              'tabnext'],
  \ 'z': ['Last tab',              'tablast'],
  \ })
endfunction

function! s:BufMenu() abort
  call s:Which('Buffers (press key):', {
  \ 'b': ['List buffers',          'ls'],
  \ 'l': ['Next buffer',           'bnext'],
  \ 'h': ['Prev buffer',           'bprevious'],
  \ 'd': ['Delete buffer',         'bd'],
  \ 'o': ['Only this buffer',      'execute "%bd | e# | bd #"'],
  \ })
endfunction

function! s:FileMenu() abort
  call s:Which('Files (press key):', {
  \ 'e': ['Explore (netrw)',       'Explore'],
  \ 'v': ['Explore vertical',      'Lexplore'],
  \ 'f': ['Find file (:find)',     'normal :find '],
  \ })
endfunction

function! s:SearchMenu() abort
  call s:Which('Search (press key):', {
  \ 'b': ['List buffers',          'ls'],
  \ 'l': ['Search lines in buf',   'normal :g//'],
  \ 'g': ['vimgrep in project',    'normal :vimgrep // **/*'],
  \ 'v': [':vimgrep (manual)',     'normal :vimgrep '],
  \ })
endfunction

function! s:GitMenu() abort
  call s:Which('Git (press key):', {
  \ 's': ['git status',            '!git status'],
  \ 'd': ['git diff',              '!git diff'],
  \ 'l': ['git log --oneline',     '!git log --oneline -10'],
  \ 'b': ['git branch -a',         '!git branch -a'],
  \ 'a': ['git add .',             '!git add .'],
  \ 'c': ['git commit',            '!git commit'],
  \ 'p': ['git push',              '!git push'],
  \ })
endfunction

function! s:UIMenu() abort
  call s:Which('UI toggles (press key):', {
  \ 's': ['Toggle spell',          'setlocal spell!'],
  \ 'w': ['Toggle wrap',           'setlocal wrap!'],
  \ 'n': ['Toggle number',         'setlocal number!'],
  \ 'h': ['Clear highlights',      'noh'],
  \ 'l': ['Toggle listchars',      'setlocal list!'],
  \ })
endfunction

function! s:QuitMenu() abort
  call s:Which('Quit / Quickfix (press key):', {
  \ 'q': ['Quit all!',             'qall!'],
  \ 's': ['Save & quit',           'wq!'],
  \ 'o': ['Open quickfix',         'copen'],
  \ 'c': ['Close quickfix',        'cclose'],
  \ })
endfunction

function! CheatSheet() abort
  " Persistent cheat sheet that stays open until you press q
  tabnew
  setlocal buftype=nofile bufhidden=wipe noswapfile
  call setline(1, [
  \ 'Leader cheatsheet (press q to close)',
  \ '',
  \ '<Space>w  → Windows menu',
  \ '<Space>t  → Tabs menu',
  \ '<Space>b  → Buffers menu',
  \ '<Space>f  → Files menu',
  \ '<Space>s  → Search menu',
  \ '<Space>g  → Git menu',
  \ '<Space>u  → UI toggles',
  \ '<Space>q  → Quit/Quickfix menu',
  \ '<Space>?  → This cheatsheet',
  \ ])
  nnoremap <silent><buffer> q :bwipeout!<CR>
endfunction

" --- Root menu and top-level leader bindings -------------------------------
function! LeaderRoot() abort
  call s:Which('Leader menu (press key):', {
  \ 'w': ['Windows', 'call s:WinMenu()'],
  \ 't': ['Tabs',    'call s:TabMenu()'],
  \ 'b': ['Buffers', 'call s:BufMenu()'],
  \ 'f': ['Files',   'call s:FileMenu()'],
  \ 's': ['Search',  'call s:SearchMenu()'],
  \ 'g': ['Git',     'call s:GitMenu()'],
  \ 'u': ['UI',      'call s:UIMenu()'],
  \ 'q': ['Quit',    'call s:QuitMenu()'],
    \ '?': ['Cheatsheet',      'call CheatSheet()'],
  \ })
endfunction

" Leader = open root menu; Leader? = sticky cheatsheet
nnoremap <silent> <leader><leader> :<C-u>call LeaderRoot()<CR>
nnoremap <silent> <leader> :call LeaderRoot()<CR>
nnoremap <silent> <leader>? :call CheatSheet()<CR>

" Simple help function for leader key mappings
" function! ShowLeaderHelp()
  " echo "Leader Key Mappings (<Space> as leader):"
  " echo "  e          - File explorer (:Explore)"
  " echo "  ?          - Show this help"
  " echo ""
  " echo "  q + key    - Quit operations:"
  " echo "    qq       - Quit all"
  " echo "    qs       - Save and quit"
  " echo "    qo       - Open quickfix"
  " echo "    qc       - Close quickfix"
  " echo ""
  " echo "  w + key    - Window operations:"
  " echo "    ww       - Switch to other window"
  " echo "    wd       - Delete window"
  " echo "    w-       - Split horizontal"
  " echo "    w|       - Split vertical"
  " echo "    wh/j/k/l - Navigate windows"
  " echo "    wH/J/K/L - Resize windows"
  " echo "    w=       - Balance windows"
  " echo ""
  " echo "  t + key    - Tab operations:"
  " echo "    tn       - New tab"
  " echo "    tc       - Close tab"
  " echo "    th/tl    - Previous/next tab"
  " echo "    to       - Close other tabs"
  " echo ""
  " echo "  g + key    - Git operations:"
  " echo "    gs       - Git status"
  " echo "    gd       - Git diff"
  " echo "    gl       - Git log"
  " echo "    gb       - Git branches"
  " echo "    ga       - Git add all"
  " echo "    gc       - Git commit"
  " echo "    gp       - Git push"
  " echo ""
  " echo "  f + key    - File operations:"
  " echo "    ff       - Find file"
  " echo "    fe       - File explorer"
  " echo "    fv       - Vertical explorer"
  " echo ""
  " echo "  s + key    - Search operations:"
  " echo "    sf       - Find file"
  " echo "    sg       - Grep in files"
  " echo "    sb       - List buffers"
  " echo "    sl       - Search lines in buffer"
  " echo "    sv       - Vim grep"
  " echo ""
  " echo "  u + key    - UI toggles:"
  " echo "    us       - Toggle spelling"
  " echo "    uw       - Toggle wrap"
  " echo "    un       - Toggle line numbers"
  " echo "    uh       - Clear highlights"
  " echo "    ul       - Toggle listchars"
  " echo ""
  " echo "  b + key    - Buffer operations:"
  " echo "    bb       - List buffers"
  " echo "    bl/bh    - Next/previous buffer"
  " echo "    bo       - Close other buffers"
  " echo "    bd       - Delete buffer"
  " echo ""
  " echo "  c + key    - Change operations:"
  " echo "    cd       - Change directory to current file"
" endfunction
"
" Leader key mappings
" nnoremap <silent> <leader> :call ShowLeaderHelp()<CR>
"
" One-key actions
" nnoremap <leader>e :Lexplore<CR>
"
" Help
" nnoremap <leader>? :call ShowLeaderHelp()<CR>
"
" Quit / Quickfix
" nnoremap <leader>qq :qall!<CR>
" nnoremap <leader>qo :copen<CR>
" nnoremap <leader>qc :cclose<CR>
" nnoremap <leader>qs :wq!<CR>
"
" Windows
" nnoremap <leader>ww <C-W>w
" nnoremap <leader>wd <C-W>c
" nnoremap <leader>w- <C-W>s
" nnoremap <leader>w<Bar> <C-W>v
" nnoremap <leader>w2 <C-W>v
" nnoremap <leader>wh <C-W>h
" nnoremap <leader>wj <C-W>j
" nnoremap <leader>wl <C-W>l
" nnoremap <leader>wk <C-W>k
" nnoremap <leader>wH <C-W>5<
" nnoremap <leader>wJ :resize +5<CR>
" nnoremap <leader>wL <C-W>5>
" nnoremap <leader>wK :resize -5<CR>
" nnoremap <leader>w= <C-W>=
" nnoremap <leader>ws <C-W>s
" nnoremap <leader>wv <C-W>v
"
" Tabs
" nnoremap <leader>tn :tabnew<CR>
" nnoremap <leader>to :tabonly<CR>
" nnoremap <leader>tc :tabclose<CR>
" nnoremap <leader>th :tabprevious<CR>
" nnoremap <leader>tl :tabnext<CR>
" nnoremap <leader>tz :tablast<CR>
"
" Git (shell-based commands)
" nnoremap <leader>gs :!git status<CR>
" nnoremap <leader>gd :!git diff<CR>
" nnoremap <leader>gl :!git log --oneline -10<CR>
" nnoremap <leader>gb :!git branch -a<CR>
" nnoremap <leader>gp :!git push<CR>
" nnoremap <leader>gc :!git commit<CR>
" nnoremap <leader>ga :!git add .<CR>
"
" Files
" nnoremap <leader>ff :find
" nnoremap <leader>fe :Explore<CR>
" nnoremap <leader>fv :Lexplore<CR>
"
" Search
" nnoremap <leader>sf :find
" nnoremap <leader>sg :vimgrep // **/*<Left><Left><Left><Left><Left><Left>
" nnoremap <leader>sb :ls<CR>
" nnoremap <leader>sl :g//<Left>
" nnoremap <leader>sv :vimgrep
"
" User Interface Settings
" nnoremap <leader>us :setlocal spell!<CR>
" nnoremap <leader>uw :setlocal wrap!<CR>
" nnoremap <leader>un :setlocal number!<CR>
" nnoremap <leader>uh :noh<CR>
" nnoremap <leader>ul :setlocal list!<CR>
"
" Buffers
" nnoremap <leader>bb :ls<CR>
" nnoremap <leader>bl :bnext<CR>
" nnoremap <leader>bh :bprevious<CR>
" nnoremap <leader>bo :%bd<Bar>e#<CR>
" nnoremap <leader>bd :bd<CR>
"
" Change commands
" nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" File Explorer (replaces NERDTree)
nnoremap <C-e> :Lexplore<CR>
nnoremap <C-f> :find

