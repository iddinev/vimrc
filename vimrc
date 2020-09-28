" vim: set expandtab shiftwidth=2:

  syntax enable

  " PACKAGES (PLUG)
  "======================

  " Auto(ish) install.
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  endif

  call plug#begin('~/.vim/plugged')

  " Statusline
  Plug 'vim-airline/vim-airline'
  set laststatus=1
  let g:airline#extensions#tabline#show_buffers = 0
  let g:airline#extensions#tabline#tab_min_count = 2
  let g:airline#extensions#tabline#tabs_label = ''
  let g:airline#extensions#tabline#tab_nr_type = 2 " splits and tab number
  let g:airline#extensions#tabline#show_splits = 0
  let g:airline#extensions#tabline#show_tab_type = 0
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#ale#enabled = 1
  let g:airline_powerline_fonts = 1

  Plug 'vim-airline/vim-airline-themes'
  let g:airline_theme='dark'

  " Syntax highlighting
  Plug 'sheerun/vim-polyglot'

  " Commenter
  Plug 'scrooloose/nerdcommenter'
  let NERDSpaceDelims = 1

  " Directory tree viewer
  Plug 'scrooloose/nerdtree'
  let NERDTreeWinPos = 'right'
  let NERDTreeWinSize = '60'
  let NERDTreeChDirMode = 3
  " Mirror FZF's hotkeys.
  let NERDTreeMapOpenInTab = '<c-t>'
  let NERDTreeMapOpenSplit = '<c-x>'
  let NERDTreeMapOpenVSplit = '<c-v>'

  let NERDTreeHighlightCursorline = 0

  " Completion
  " Requires 'pynvim', 'msgpack'.
  Plug 'Shougo/deoplete.nvim'
  let g:deoplete#enable_at_startup = 1

  Plug 'roxma/nvim-yarp'

  Plug 'roxma/vim-hug-neovim-rpc'

  Plug 'Shougo/neco-syntax'

  " Linter
  " Some language servers are not yet up to speed with the diagnostics,
  " hence the additional stylers/linters/diagnostics tools.

  Plug 'dense-analysis/ale'
  " Shell linter requires 'shellcheck'.
  let g:ale_linters = {
  \ 'sh': ['shellcheck', 'shell'],
  \ }
  let g:ale_echo_msg_error_str = 'E'
  let g:ale_echo_msg_warning_str = 'W'
  let g:ale_echo_msg_format = '[%linter%] [%code%] [%severity%] %s'

  " Used as a styler, requires 'vint'.
  Plug 'Vimjas/vint'

  " Language server client
  " Requres language servers.
  Plug 'autozimu/LanguageClient-neovim', {
  \ 'branch': 'next',
  \ 'do': 'bash install.sh',
  \ }
  let g:LanguageClient_selectionUI = 'fzf'
  let g:LanguageClient_serverCommands = {
  \ 'sh': ['bash-language-server', 'start'],
  \ 'vim': ['vim-language-server', '--stdio'],
  \ 'python': ['pyls'],
  \ }
  let g:markdown_fenced_languages = [
  \ 'vim',
  \ 'help'
  \ ]

  " Snippets
  Plug 'SirVer/ultisnips'
  let g:UltiSnipsExpandTrigger='<c-s>'
  let g:UltiSnipsJumpForwardTrigger='<c-f>'
  let g:UltiSnipsJumpBackwardTrigger='<c-b>'

  Plug 'honza/vim-snippets'

  " GIT
  Plug 'tpope/vim-fugitive'

  Plug 'junegunn/gv.vim'
  command! -bang -nargs=* -range=0 GVA :GV --all

  " Fuzzy search.
  Plug 'junegunn/fzf'
  let g:fzf_layout = {'right': '~40%'}
  let g:fzf_colors = {
  \ 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'Exception', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'LineNr', 'LineNr'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Conditional'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

  Plug 'junegunn/fzf.vim'
  let g:fzf_command_prefix = 'FZF'
  let g:fzf_preview_window = 'down:60%'
  let g:fzf_buffers_jump = 1
  let g:fzf_commits_log_options = '--graph --all --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

  command! -bar -bang -nargs=? -complete=buffer FZFBuffers
  \ call fzf#vim#buffers(<q-args>,
  \     fzf#vim#with_preview({'options': ['--height=100%', '--bind=f1:abort'],
  \         'window':{'width': 0.3, 'height': 0.6}}, 'down:50%'), <bang>0)
  command! -bang -nargs=? -complete=dir FZFFiles
  \ call fzf#vim#files(<q-args>,
  \     fzf#vim#with_preview({'options':
  \         ['--height=100%', '--bind=f7:abort']}, 'down:70%'), <bang>0)
  " Requires Rg.
  command! -bang -nargs=* FZFRg
  \ call fzf#vim#grep(
  \     'rg --column --line-number --no-heading --color=always --smart-case -- '
  \     .shellescape(<q-args>), 1,
  \     fzf#vim#with_preview({'options': ['--height=100%', '--bind=ctrl-f:abort', '--delimiter=:', '--nth=4..']},
  \     'down:50%'), <bang>0)
  command! -bang -nargs=* FZFRgAll
  \ call fzf#vim#grep(
  \     'rg --column --no-ignore --line-number --no-heading --color=always --smart-case '
  \     .shellescape(<q-args>), 1,
  \     fzf#vim#with_preview({'options': ['--height=100%', '--delimiter=:', '--nth=4..']},
  \     'down:50%'), <bang>0)
  command! -bar -bang FZFCommits
  \ call fzf#vim#commits({'options':
  \     ['--preview',
  \     'echo {} | grep -o "[a-f0-9]\{7,\}" | head -1 | xargs git show --stat --format=fuller --color=always',
  \     '--preview-window=down:50%']}, <bang>0)
  command! -bar -bang FZFBCommits
  \ call fzf#vim#buffer_commits({'options':
  \     ['--preview',
  \     'echo {} | grep -o "[a-f0-9]\{7,\}" | head -1 | xargs git show --stat --format=fuller --color=always',
  \     '--preview-window=down:50%']}, <bang>0)

  " Main colorscheme
  Plug 'NLKNguyen/papercolor-theme'
  " This theme forces colours (if the term emulator allows it)
  " so it is independant of the terminal pallette .
  " The terminal pallete can still be used through the override functionality.
  " Force set the background to use the terminal one.
  let g:PaperColor_Theme_Options = {
  \     'theme': {
  \       'default.dark': {
  \         'transparent_background' : 1,
  \         'allow_bold' : 1
  \       },
  \       'default.light': {
  \         'transparent_background' : 1,
  \         'allow_bold' : 1
  \       }
  \     },
  \     'language': {
  \       'python': {
  \         'highlight_builtins' : 1
  \       },
  \       'cpp': {
  \         'highlight_standard_library': 1
  \       },
  \       'c': {
  \         'highlight_builtins' : 1
  \       }
  \     }
  \   }

  " Misc
  Plug 'junegunn/vim-peekaboo'

  Plug 'tpope/vim-dispatch'

  Plug 'drmingdrmer/vim-toggle-quickfix'

  Plug 'Asheq/close-buffers.vim'

  Plug 'Shougo/echodoc.vim'
  let g:echodoc#enable_at_startup = 1
  let g:echodoc#type = 'popup'

  " Works only with git.
  Plug 'airblade/vim-gitgutter'
  let g:gitgutter_preview_win_floating = 1

  Plug 'mhinz/vim-startify'

  " Local plugins
  if filereadable(glob('$HOME/.vim/vimrc_local_plugins'))
    source $HOME/.vim/vimrc_local_plugins
  endif

  call plug#end()

  call deoplete#custom#option('ignore_sources', {'_': ['around']})
  call deoplete#custom#source('_',
  \ 'max_abbr_width', 0)
  call deoplete#custom#source('_',
  \ 'max_menu_width', 0)


  " GENERAL
  "======================

  set encoding=utf-8
  set modeline

  set background=dark
  colorscheme PaperColor
  " Do not highlight the relative line number.
  highlight! link CursorLineNr LineNr
  highlight! link Pmenu MatchParen
  highlight! link DiffRemoved Repeat
  highlight! link DiffAdded Type
  highlight! clear SignColumn

  set mouse=a
  set backspace=2
  set nohlsearch
  set ignorecase
  set smartcase
  set ruler
  set numberwidth=2

  set nopaste
  set wrap
  set textwidth=105
  " enables cursor to always be in the center of the screen when scrolling (when possible).
  set scrolloff=29
  set autoindent
  set smarttab
  set softtabstop=4
  set tabstop=4
  set shiftwidth=4
  " Trailing whitespace is intentional.
  set listchars=tab:\|\ ,trail:\ 
  let g:show_special_chars=1
  set list
  set number
  set relativenumber
  set splitright
  set splitbelow
  set fileformats=unix
  set diffopt+=vertical
  set wildmenu
  " set signcolumn=auto
  set noshowmode
  set completeopt=menu,popup
  set completepopup=align:menu,border:off

  " Show trailing white spaces & tabs with the Curosr HL group color.
  match Cursor '\s\+$'

  " Change dir to be that of the (first) open file.
  " Plays better with my current fzf and NERDtree config than autochdir.
  cd %:p:h


  " FUNCTIONS
  "======================

  function! ProperPaste()
  " mapped to F3
    :set number!
    :set paste!
  endfunction

  function! ToggleSpecialChars()
  " mapped to F5
    if g:show_special_chars == 0
      set listchars=tab:\|\ ,trail:\ 
      let g:show_special_chars = 1
    elseif g:show_special_chars == 1
      set listchars=tab:>-,trail:-,eol:$
      let g:show_special_chars = 0
    endif
  endfunction

  function! ToggleDiff()
  " mapped to F6
    let l:save_cursor = getcurpos()
    if &diff
      diffoff!
    else
      windo diffthis
    endif
    call setpos('.',save_cursor)
  endfunction

  function! TrimWhiteSpace()
    let l:save = winsaveview()
    " vint: next-line -ProhibitCommandWithUnintendedSideEffect -ProhibitCommandRelyOnUser
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
  endfunction

  function! ToggleWrap()
  " mapped to F8
    set wrap!
    echo 'wrap is set to:' &wrap
  endfunction

  function! ToggleLight()
  " mapped to F9
    if &background ==# 'dark'
      let g:airline_theme='papercolor'
      set background=light
      highlight! link CursorLineNr LineNr
    elseif &background ==# 'light'
      let g:airline_theme='dark'
      set background=dark
      highlight! link CursorLineNr LineNr
    endif
  endfunction


  " AUTOCMD
  "======================
  augroup bash
    autocmd!
    " The bash language server is still having problems with some syntax.
    autocmd FileType sh let g:LanguageClient_diagnosticsEnable = 0
  augroup END



  " REMAPS
  "======================

  map                   J             <c-w>j
  map                   K             <c-w>k
  map                   L             <c-w>l
  map                   H             <c-w>h
  " All the FZF commands are modified in the plugins part above.
  nmap      <silent>    <Leader>d     <Plug>(lcn-definition)
  nmap      <silent>    <Leader>r     <Plug>(lcn-rename)
  nmap      <silent>    <Leader>h     <Plug>(lcn-hover)
  nmap      <silent>    <Leader>x     <Plug>(lcn-references)
  nmap      <silent>    <Leader>s     <Plug>(lcn-symbols)
  nmap      <silent>    <Leader>l     <Plug>(lcn-highlight)
  nmap      <silent>    <Leader>m     <Plug>(lcn-menu)
  nmap      <silent>    [q            :cprevious<CR>
  nmap      <silent>    ]q            :cnext<CR>
  nmap      <silent>    [l            :lprevious <CR>
  nmap      <silent>    ]l            :lnext<CR>
  nmap      <silent>    <c-f>         :FZFRg<CR>
  nmap      <silent>    <c-g>         :FZFRgAll<CR>
  nmap      <silent>    <c-r>         :FZFHistory:<CR>
  nmap      <silent>    <F1>          :FZFBuffers <CR>
  nmap      <silent>    <F3>          :call ProperPaste()<CR>
  nmap      <silent>    <F4>          :set hlsearch!<CR>
  nmap      <silent>    <F5>          :call ToggleSpecialChars()<CR>
  nmap      <silent>    <F6>          :call ToggleDiff()<CR>
  nmap      <silent>    <F7>          :FZFFiles<CR>
  nmap      <silent>    <F8>          :call ToggleWrap()<CR>
  nmap      <silent>    <F9>          :call ToggleLight()<CR>
  nmap      <silent>    <F10>         :NERDTreeToggle<CR> <bar> :NERDTreeRefreshRoot<CR>
  nmap      <silent>    Q             <Nop>
  nmap      <silent>    <c-h>         :tabprevious<CR>
  nmap      <silent>    <c-l>         :tabnext<CR>
  nmap      <silent>    <c-q>         <Plug>window:quickfix:loop


  " OVERRIDES
  "======================

  if filereadable(glob('$HOME/.vim/vimrc_override'))
    source $HOME/.vim/vimrc_override
  endif
