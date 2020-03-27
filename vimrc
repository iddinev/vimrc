" vim: set expandtab:


  syntax on


  " PACKAGES (PLUG)
  "======================

  " install curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  call plug#begin('~/.vim/plugged')

  " Vim statusline
  Plug 'vim-airline/vim-airline'
  set laststatus=1
  let g:airline#extensions#tabline#show_buffers = 0
  let g:airline#extensions#tabline#tab_min_count = 2
  let g:airline#extensions#tabline#enabled = 1
  let g:airline_powerline_fonts = 1

  Plug 'vim-airline/vim-airline-themes'
  let g:airline_theme='dark'

  "Better syntax highlighting
  Plug 'sheerun/vim-polyglot'

  " Nerdcomenter setup
  Plug 'scrooloose/nerdcommenter'
  let NERDSpaceDelims = 1

  " Nerdtree setup
  Plug 'scrooloose/nerdtree'
  let NERDTreeWinPos = 'right'
  let NERDTreeWinSize = '60'
  let NERDTreeChDirMode = 3

  " Vim git plugin
  Plug 'tpope/vim-fugitive'

  " Fuzzy search.
  Plug 'junegunn/fzf'
  let g:fzf_layout = { 'right': '~40%' }

  Plug 'junegunn/fzf.vim'
  let g:fzf_command_prefix = 'FZF'
  let g:fzf_preview_window = 'down:60%'
  let g:fzf_buffers_jump = 1
  command! -bar -bang -nargs=? -complete=buffer FZFBuffers
  \ call fzf#vim#buffers(<q-args>,
  \     fzf#vim#with_preview({"options": ["-d", "\t", "--height=100%", "--bind=f1:abort"],
  \     "placeholder": "{1}", "window":{'width': 0.3, 'height': 0.6}}, "down:50%"), <bang>0)
  command! -bang -nargs=? -complete=dir FZFFiles
  \ call fzf#vim#files(<q-args>,
  \     fzf#vim#with_preview({"options":
  \         ['--bind=f7:abort']}, 'down:70%'), <bang>0)
  command! -bang -nargs=* FZFRg
  \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case "
  \     .shellescape(<q-args>), 1,
  \     fzf#vim#with_preview({"options": ["-d", "\t", "--height=100%", "--bind=ctrl-f:abort"],
  \     "placeholder": "{1}"}, 'down:50%'), <bang>0)
  command! -bang -nargs=* FZFRgAll
  \ call fzf#vim#grep("rg --column --no-ignore --line-number --no-heading --color=always --smart-case "
  \     .shellescape(<q-args>), 1,
  \     fzf#vim#with_preview({"options": ["-d", "\t", "--height=100%"],
  \     "placeholder": "{1}"}, 'down:50%'), <bang>0)

  " Main colorscheme
  " This theme forces colours (if the term emulator allows it)
  " so it is independant of the terminal pallette .
  " The terminal pallete can still be used through the override functionality.
  Plug 'NLKNguyen/papercolor-theme'
  " Force set the background to use the terminal one.
  let g:PaperColor_Theme_Options = {
  \     'theme': {
  \       'default.dark': {
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

  " Local plugins
   if filereadable(glob("$HOME/.vim/vimrc_local_plugins"))
       source $HOME/.vim/vimrc_local_plugins
   endif

  call plug#end()


  " GENERAL
  "======================

  set encoding=utf-8
  syntax on
  set modeline

  set background=dark
  colorscheme PaperColor
  " Do not highlight the relative line number.
  highlight! link CursorLineNr LineNr

  set mouse=a
  set omnifunc=syntaxcomplete#Complete
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
  set scrolloff=999
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
  set ffs=unix
  set diffopt+=vertical

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
      let l:save_cursor = getpos(".")
      if &diff
          diffoff!
      else
          windo diffthis
      endif
  endfunction

  function! TrimWhiteSpace()
      %s/\s\+$//e
  endfunction

  function! ToggleWrap()
  " mapped to F8
      set wrap!
      echo "wrap is set to:" &wrap
  endfunction

  function! ToggleLight()
  " mapped to F9
      if &background == 'dark'
          let g:airline_theme='papercolor'
          set background=light
          highlight! link CursorLineNr LineNr
      elseif &background == 'light'
          let g:airline_theme='dark'
          set background=dark
          highlight! link CursorLineNr LineNr
      endif
  endfunction


  " REMAPS
  "======================

  map                   J             <c-w>j
  map                   K             <c-w>k
  map                   L             <c-w>l
  map                   H             <c-w>h

  " All the FZF commands are modified in the plugins part above.
  nmap      <silent>    ]l            :lne<CR>
  nmap      <silent>    [l            :lp<CR>
  nmap      <silent>    <c-l>         :FZFLines<CR>
  nmap      <silent>    <c-f>         :FZFRg<CR>
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


  " OVERRIDES
  "======================

  if filereadable(glob("$HOME/.vim/vimrc_override"))
      source $HOME/.vim/vimrc_override
  endif
