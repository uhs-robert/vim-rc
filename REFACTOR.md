# REFACTOR.md

Guide for refactoring the plugin-enabled .vimrc configuration to be safer for server environments while maintaining plugin functionality.

## Overview

This document outlines steps to make the current plugin-enabled configuration at `src/with-plugins/.vimrc` safer for server use by removing automatic installation/update scripts and adding better error handling. The goal is to create a safer version while the `src/no-plugins/.vimrc` already provides a minimal alternative.

## Current Security Concerns

1. **Automatic curl execution**: Downloads vim-plug without user consent in the with-plugins version
2. **Automatic plugin installation**: Downloads plugins on vim startup
3. **Network dependency assumptions**: Assumes internet access and external domains
4. **Silent failures**: Some errors may go unnoticed
5. **Privilege assumptions**: May attempt operations requiring elevated permissions

## Refactoring Steps

### 1. Remove Auto-Installation Scripts

**Current problematic code in `src/with-plugins/.vimrc`:**
```vim
" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif
```

**Replace with safe detection:**
```vim
" Check if vim-plug is available
if empty(glob('~/.vim/autoload/plug.vim'))
  echohl WarningMsg
  echo "vim-plug not found. Install manually with:"
  echo "curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  echohl None
  finish  " Exit early if vim-plug not available
endif

" Check for missing plugins and notify user
function! s:CheckPlugins()
  if exists('g:plugs') && len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
    echohl WarningMsg
    echo "Missing plugins detected. Run :PlugInstall to install them."
    echohl None
  endif
endfunction

autocmd VimEnter * call s:CheckPlugins()
```

### 2. Add Plugin Availability Guards

**Wrap plugin configurations with existence checks:**

```vim
" Safe plugin loading - only configure if plugin exists
function! s:PluginExists(plugin_name)
  return has_key(g:plugs, a:plugin_name) && isdirectory(g:plugs[a:plugin_name].dir)
endfunction

" Lightline config (only if available)
if s:PluginExists('lightline.vim')
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
else
  " Fallback status line
  set statusline=%F%m%r%h%w\ [%{&ff}]\ [%Y]\ [%04l,%04v][%p%%]\ [LEN=%L]
endif

" IndentLine config (only if available)
if s:PluginExists('indentLine')
  let g:indentLine_setColors = 0
  let g:indentLine_char_list = ['|', '¦', '┆', '┊']
else
  " Fallback visual indentation
  set list
  set listchars=tab:│\ ,trail:·,extends:>,precedes:<,nbsp:+
endif

" FZF config (only if available)
if s:PluginExists('fzf.vim')
  let g:fzf_vim = {}
endif
```

### 3. Safe Leader Key Mappings

**Replace plugin-dependent mappings with conditional ones:**

```vim
" Safe leader key mappings
let g:leader_map = {}

" Files - conditional based on plugin availability
if s:PluginExists('fzf.vim')
  let g:leader_map['f'] = {
        \ 'name' : '+files' ,
        \ '/' : ['Files', 'fzf-files'],
        \ }
else
  let g:leader_map['f'] = {
        \ 'name' : '+files' ,
        \ 'f' : [':find ', 'find-file'],
        \ 'e' : [':Explore', 'file-explorer'],
        \ }
endif

" Search - conditional mappings
if s:PluginExists('fzf.vim')
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
else
  let g:leader_map['s'] = {
        \ 'name' : '+search',
        \ 'f' : [':find ', 'find-file'],
        \ 'g' : [':vimgrep // **/*', 'grep-files'],
        \ 'b' : [':ls', 'list-buffers'],
        \ 'l' : [':g//', 'lines-in-buffer'],
        \ }
endif

" Git - conditional fugitive vs shell commands
if s:PluginExists('vim-fugitive')
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
else
  let g:leader_map['g'] = {
        \ 'name' : '+git',
        \ 's' : [':!git status', 'git-status'],
        \ 'd' : [':!git diff', 'git-diff'],
        \ 'l' : [':!git log --oneline -10', 'git-log'],
        \ 'b' : [':!git branch -a', 'git-branches'],
        \ 'p' : [':!git push', 'git-push'],
        \ }
endif

" One-key actions - conditional
if s:PluginExists('nerdtree')
  let g:leader_map['e'] = [ 'NERDTreeToggle', 'nerdtree' ]
  nnoremap <C-e> :NERDTreeToggle<CR>
  nnoremap <C-f> :NERDTreeFind<CR>
else
  let g:leader_map['e'] = [ 'Explore', 'file-explorer' ]
  nnoremap <C-e> :Explore<CR>
  nnoremap <C-f> :Explore %:p:h<CR>
endif

" Which-key registration (only if available)
if s:PluginExists('vim-which-key')
  nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
  call which_key#register('<Space>', "g:leader_map")
endif
```

### 4. Safer Theme Loading

**Replace current theme section with fallback chain:**

```vim
" => Theme and Status Line
" Enable true colors if supported
if has('termguicolors') && &term !~# '^screen\|^tmux'
  set termguicolors
endif

" Theme loading with fallbacks
function! s:LoadColorscheme()
  " Try plugin theme first
  if s:PluginExists('high-contrast')
    try
      colorscheme high_contrast
      return 1
    catch
      " Plugin theme failed, continue to fallbacks
    endtry
  endif
  
  " Try built-in themes
  let fallback_themes = ['desert', 'slate', 'murphy', 'default']
  for theme in fallback_themes
    try
      execute 'colorscheme ' . theme
      return 1
    catch
      continue
    endtry
  endfor
  
  " If all fail, just use default
  echohl WarningMsg
  echo "Warning: No colorscheme could be loaded, using vim defaults"
  echohl None
  return 0
endfunction

call s:LoadColorscheme()
```

### 5. Add Server Environment Detection

**Add function to detect server environment:**

```vim
" Detect server environment
function! s:IsServerEnvironment()
  " Check for common server indicators
  return $SSH_CONNECTION != '' || 
       \ $TERM == 'screen' || 
       \ $TERM =~ '^tmux' ||
       \ executable('systemctl') && system('systemctl is-system-running') =~ 'running'
endfunction

" Adjust settings for server environments
if s:IsServerEnvironment()
  " More conservative settings for servers
  set timeoutlen=1000          " Longer timeout for slow connections
  set updatetime=1000          " Less frequent updates
  set lazyredraw               " Don't redraw during macros
  
  " Disable resource-intensive features
  set foldmethod=manual        " Manual folding instead of indent
  
  " Inform user of server mode
  echohl InfoMsg
  echo "Server environment detected - using conservative settings"
  echohl None
endif
```

### 6. Add Manual Plugin Installation Helper

**Add function to help with manual plugin setup:**

```vim
" Helper function for manual plugin installation
function! s:ShowPluginInstallInstructions()
  echo "=== Manual Plugin Installation ==="
  echo "1. Install vim-plug:"
  echo "   curl -fLo ~/.vim/autoload/plug.vim --create-dirs \\"
  echo "     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  echo ""
  echo "2. Open vim and run :PlugInstall"
  echo ""
  echo "3. Restart vim to load plugins"
  echo ""
  echo "Current plugins to be installed:"
  if exists('g:plugs')
    for plugin in keys(g:plugs)
      echo "   - " . plugin
    endfor
  endif
endfunction

command! PluginHelp call s:ShowPluginInstallInstructions()
```

## Implementation Checklist

### For `src/with-plugins/.vimrc`:
- [ ] Remove automatic curl execution for vim-plug
- [ ] Remove automatic plugin installation on startup
- [ ] Add plugin existence checks before configurations
- [ ] Wrap all plugin-dependent leader mappings in conditionals
- [ ] Add safer theme loading with fallbacks
- [ ] Add server environment detection
- [ ] Add manual installation helper function
- [ ] Test configuration with and without plugins
- [ ] Verify fallbacks work correctly
- [ ] Document new commands and functions

### Project Structure:
- [ ] Consider creating `src/with-plugins-safe/.vimrc` as a third option
- [ ] Update documentation to reflect three-tier approach:
  - `src/no-plugins/.vimrc` - Minimal, no external dependencies
  - `src/with-plugins-safe/.vimrc` - Plugins with manual installation
  - `src/with-plugins/.vimrc` - Current auto-installing version

## Benefits of This Refactor

1. **No automatic network access** - User must explicitly install plugins
2. **Graceful degradation** - Works with or without plugins
3. **Better error handling** - Clear messages when things are missing
4. **Server awareness** - Adjusts behavior for server environments
5. **Security** - No surprise executions or downloads
6. **Maintainability** - Easier to debug when plugins are missing

## Migration Strategy

1. **Create safe variant**: Implement `src/with-plugins-safe/.vimrc` based on current `src/with-plugins/.vimrc`
2. **Test in safe environment** first (personal dev machine)
3. **Deploy to development servers** for testing
4. **Update documentation** to reflect three configuration options
5. **Gradually migrate** users to appropriate variant based on their environment

## Current User Workflow Options

### Option 1: Minimal Configuration
```bash
cp src/no-plugins/.vimrc ~/.vimrc
```
- No external dependencies
- Built-in vim functionality only
- Safe for all environments

### Option 2: Manual Plugin Management (Proposed)
```bash
cp src/with-plugins-safe/.vimrc ~/.vimrc
vim  # Run :PluginHelp for installation instructions
```
- Full plugin functionality when installed
- Manual plugin installation required
- Graceful fallbacks when plugins missing

### Option 3: Auto-Installing (Current)
```bash
cp src/with-plugins/.vimrc ~/.vimrc
```
- Automatic plugin installation
- Requires internet access and curl
- Security implications for server environments

This refactored approach provides users with appropriate choices based on their environment and security requirements while maintaining the power and convenience of the plugin-enabled setup.