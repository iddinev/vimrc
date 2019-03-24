  set encoding=utf-8
  syntax on

" Plug
  call plug#begin('~/.vim/plugged')

" Vim statusline
  Plug 'vim-airline/vim-airline'
  set laststatus=2
  let g:airline#extensions#tabline#show_buffers = 0
  let g:airline#extensions#tabline#tab_min_count = 2
  let g:airline#extensions#tabline#enabled = 1
  let g:airline_symbols = {'maxlinenr': ''}

  Plug 'vim-airline/vim-airline-themes'
  let g:airline_theme='dark'


" Nerdcomenter setup
  Plug 'scrooloose/nerdcommenter'
  let NERDSpaceDelims = 1

  Plug 'wincent/command-t'

" Nerdtree setup
  Plug 'scrooloose/nerdtree'
  let NERDTreeWinPos = 'right'
  let NERDTreeWinSize = '60'

" Jedi-vim setup
  Plug 'davidhalter/jedi-vim'
  set noshowmode
  let g:jedi#show_call_signatures = 2
  let g:jedi#use_splits_not_buffers = 'right'

" Vim git plugin
  Plug 'tpope/vim-fugitive'

  Plug 'arcticicestudio/nord-vim'
  Plug 'drewtempelmeyer/palenight.vim'
  Plug 'mhartington/oceanic-next'
  Plug 'kristijanhusak/vim-hybrid-material'

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
  Plug 'altercation/vim-colors-solarized'

  call plug#end()

  set background=dark
  colorscheme PaperColor

  set mouse=a
  set omnifunc=syntaxcomplete#Complete
  set backspace=2
  set nohlsearch
  set ignorecase
  set smartcase
  set ruler
  set numberwidth=2

  syntax on
  set nopaste
  set wrap
  set textwidth=105
  set scrolloff=999         " enables cursor to always be in the center of the screen when scrolling (when possible)
  set autoindent
  set smarttab
  set softtabstop=4
  set tabstop=4
  set shiftwidth=4
  set listchars=tab:\|\ ,trail:\ 
  set list
  set number
  set autochdir
  set splitright
  set splitbelow
  set ffs=unix
  set diffopt+=vertical

  function! ProperPaste()
  " mapped to F3
        :set number!
        :set paste!
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
      if g:airline_theme == 'dark'
          let g:airline_theme='papercolor'
          set background=light
      elseif g:airline_theme == 'papercolor'
          let g:airline_theme='dark'
          set background=dark
      endif
  endfunction

  " Show trailing white spaces & tabs with the Curosr HL group color.
  match Cursor '\s\+$'

  map                 <c-j>   <c-w>j
  map                 <c-k>   <c-w>k
  map                 <c-l>   <c-w>l
  map                 <c-h>   <c-w>h
  nmap    <silent>    ]l      :lne<CR>
  nmap    <silent>    [l      :lp<CR>
  nmap    <silent>    <F3>    :call ProperPaste()<CR>
  nmap    <silent>    <F4>    :set hlsearch!<CR>
  nmap    <silent>    <F5>    :set list!<CR>
  nmap    <silent>    <F6>    :call ToggleDiff()<CR>
  nmap    <silent>    <F7>    :NERDTreeToggle<CR>
  nmap    <silent>    <F8>    :call ToggleWrap()<CR>
  nmap    <silent>    <F9>    :call ToggleLight()<CR>
  nmap    <silent>    Q       <Nop>
  nmap    <silent>    <Up>    :ls<CR>
  nmap    <silent>    <Left>  :bp<CR>
  nmap    <silent>    <Right> :bn<CR>
  nmap    <silent>    Q       :tabprevious<CR>
  nmap    <silent>    W       :tabnext<CR>
  let g:deoplete#enable_at_startup = 1
