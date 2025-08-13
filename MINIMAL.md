# MINIMAL.md

Guide for understanding and using the minimal plugin-free vim configuration for restricted servers.

## Overview

This document describes the minimal vim configuration available at `src/no-plugins/.vimrc`. This version provides the same organizational structure and key mappings as the plugin-enabled version but uses only built-in vim functionality.

## Configuration Comparison

The `src/no-plugins/.vimrc` differs from `src/with-plugins/.vimrc` in these key areas:

### 1. Plugin Setup Section
**Removed entirely:**
- vim-plug installation and auto-download
- Plugin list and initialization  
- All `Plug` declarations

### 2. Plugin-Dependent Configurations
**Replaced with built-in alternatives:**
- Lightline config → Native statusline
- IndentLine config → Built-in list characters
- FZF config → Native file finding

### 3. Plugin-Specific Key Mappings
**Mapped to built-in equivalents:**
- NERDTree commands → netrw file explorer
- Fugitive git commands → Shell git commands
- FZF commands → Native vim finding

## Built-in Replacements

### File Navigation
Replace NERDTree with netrw:
```vim
" Enable netrw (built-in file explorer)
let g:netrw_banner = 0        " Hide banner
let g:netrw_liststyle = 3     " Tree view
let g:netrw_browse_split = 4  " Open in previous window
let g:netrw_altv = 1          " Open splits to the right
let g:netrw_winsize = 25      " Set width to 25%
```

### Status Line
Replace lightline with native vim status:
```vim
" Custom status line (replaces lightline)
set statusline=%F%m%r%h%w\ [%{&ff}]\ [%Y]\ [%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2
```

### Git Integration
Replace fugitive commands with shell equivalents:
```vim
" Git shortcuts (shell-based)
nnoremap <leader>gs :!git status<CR>
nnoremap <leader>gd :!git diff<CR>
nnoremap <leader>gl :!git log --oneline -10<CR>
nnoremap <leader>gb :!git branch -a<CR>
```

### Fuzzy Finding
Replace fzf with native vim commands:
```vim
" File finding (replaces fzf)
nnoremap <leader>ff :find 
nnoremap <leader>fg :vimgrep // **/*<Left><Left><Left><Left><Left><Left>
nnoremap <leader>fb :ls<CR>:b<Space>
```

### Commenting
Replace vim-commentary with manual toggle:
```vim
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
```

## Updated Leader Key Mappings

### Files (Replace fzf commands)
```vim
let g:leader_map['f'] = {
        \ 'name' : '+files' ,
        \ 'f' : [':find ', 'find-file'],
        \ 'e' : [':Explore', 'file-explorer'],
        \ 'v' : [':Vexplore', 'vertical-explorer'],
        \ }
```

### Search (Replace fzf/rg commands)
```vim
let g:leader_map['s'] = {
        \ 'name' : '+search',
        \ 'f' : [':find ', 'find-file'],
        \ 'g' : [':vimgrep // **/*', 'grep-files'],
        \ 'b' : [':ls', 'list-buffers'],
        \ 'l' : [':g//', 'lines-in-buffer'],
        \ }
```

### Git (Replace fugitive commands)
```vim
let g:leader_map['g'] = {
        \ 'name' : '+git',
        \ 's' : [':!git status', 'git-status'],
        \ 'd' : [':!git diff', 'git-diff'],
        \ 'l' : [':!git log --oneline -10', 'git-log'],
        \ 'b' : [':!git branch -a', 'git-branches'],
        \ 'p' : [':!git push', 'git-push'],
        \ }
```

### Remove Plugin-Only Mappings
Remove these from the leader maps:
- Any references to `NERDTreeToggle`
- Any references to `Fugitive*` commands
- Any references to `Files`, `GFiles`, `Buffers`, `BLines`, etc. (fzf commands)
- Any references to `Colors` (colorscheme picker)

## Theme Fallbacks

Replace high-contrast theme with built-in alternatives:
```vim
" Built-in colorscheme fallbacks
if exists('+termguicolors')
    set termguicolors
endif

" Try built-in themes in order of preference
silent! colorscheme desert
if !exists('g:colors_name')
    silent! colorscheme default
endif
```

## Additional Built-in Features to Enable

### Better File Finding
```vim
" Enhanced file finding
set path+=**                    " Search down into subfolders
set wildmenu                    " Display all matching files when tab completing
set wildignore+=*/node_modules/*,*/dist/*,*/.git/*
```

### Better Grep
```vim
" Use ripgrep if available, otherwise grep
if executable('rg')
    set grepprg=rg\ --vimgrep\ --smart-case\ --hidden
    set grepformat=%f:%l:%c:%m
elseif executable('ag')
    set grepprg=ag\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif
```

### Manual Indentation Guides
```vim
" Visual indentation (replaces indentLine plugin)
set list
set listchars=tab:│\ ,trail:·,extends:>,precedes:<,nbsp:+
```

## Using the Minimal Configuration

### Installation
```bash
# Copy the minimal configuration to your vim directory
cp src/no-plugins/.vimrc ~/.vimrc
```

### Customization
The minimal configuration is already implemented at `src/no-plugins/.vimrc`. If you need to customize it further:

1. **Maintain the section structure** defined in the comments
2. **Use only built-in vim features** - no external dependencies
3. **Test on target servers** to ensure compatibility
4. **Keep key mappings consistent** with the plugin version where possible

## Converting Plugin Version to Minimal

If you need to create a new minimal version from the plugin configuration:

### Quick Conversion Commands
For creating a custom minimal version, search and replace these patterns:
- Remove lines matching: `/^.*Plug\s/d`
- Remove lines matching: `/^.*plug#/d`
- Replace `NERDTreeToggle` with `Explore`
- Replace `Files` with `find `
- Replace fugitive commands with shell equivalents

## When to Use the Minimal Configuration

Deploy `src/no-plugins/.vimrc` when:
- Server lacks internet access
- curl/wget are unavailable  
- Security policies prevent plugin installation
- Working on minimal/embedded systems
- Quick edits on unfamiliar systems
- Container environments with size constraints

## Benefits

The minimal configuration at `src/no-plugins/.vimrc`:
- **Zero external dependencies** - works with vanilla vim
- **Same key bindings** - maintains muscle memory from plugin version
- **Instant deployment** - no installation or setup required
- **Universal compatibility** - works on any system with vim
- **Security compliant** - no network access or external downloads

This preserves your workflow and key bindings while using only vim's built-in capabilities.