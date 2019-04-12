" vim: set expandtab:

" TODO:
" Configure ultisnips (snippet plugin).
" Configure YouCompleteMe (autocompletion plugin), deprecate jedi-vim (python)?


  syntax on


  " PACKAGES (PLUG)
  "======================

  " install curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
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

  " Autocompletion
  Plug 'Valloric/YouCompleteMe'
  let g:ycm_goto_buffer_command = 'vertical-split'

  "Better syntax highlighting
  Plug 'sheerun/vim-polyglot'

  " Nerdcomenter setup
  Plug 'scrooloose/nerdcommenter'
  let NERDSpaceDelims = 1

  " Nerdtree setup
  Plug 'scrooloose/nerdtree'
  let NERDTreeWinPos = 'right'
  let NERDTreeWinSize = '60'

  " Jedi-vim setup
  " Plug 'davidhalter/jedi-vim'
  " set noshowmode
  " let g:jedi#show_call_signatures = 2
  " let g:jedi#use_splits_not_buffers = 'right'

  " Vim git plugin
  Plug 'tpope/vim-fugitive'

  " Fuzzy file search.
  Plug 'kien/ctrlp.vim'
  let g:ctrlp_cmd = 'CtrlPMixed'
  let g:ctrlp_working_path_mode = 'ra'
  let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn|sync)$',
  \ 'file': '\v\.(exe|so|dll|pyc|pyo|swp|swo|out)$',
  \ }

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

  " Secondary colorscheme, requires its own terminal pallete.
  Plug 'altercation/vim-colors-solarized'

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
  " enables cursor to always be in the center of the screen when scrolling (when possible)
  set scrolloff=999
  set autoindent
  set smarttab
  set softtabstop=4
  set tabstop=4
  set shiftwidth=4
  " Trailing whitespace is intentional.
  set listchars=tab:\|\ ,trail:\ 
  let g:show_special_chars=0
  set list
  set number
  set relativenumber
  set autochdir
  set splitright
  set splitbelow
  set ffs=unix
  set diffopt+=vertical

  " Show trailing white spaces & tabs with the Curosr HL group color.
  match Cursor '\s\+$'


  " FUNCTIONS
  "======================

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

  " Solarized has an issue that prevents it from
  " being able to be switched to-from
  function! ToggleColorScheme()
  " mapped to F10
      if g:colors_name == 'PaperColor'
          colorscheme solarized
          syntax on
      elseif g:colors_name  == 'solarized'
          colorscheme PaperColor
          syntax on
      endif
  endfunction


  " REMAPS
  "======================

  map                 <c-j>   <c-w>j
  map                 <c-k>   <c-w>k
  map                 <c-l>   <c-w>l
  map                 <c-h>   <c-w>h
  nmap    <silent>    ]l      :lne<CR>
  nmap    <silent>    [l      :lp<CR>
  nmap    <silent>    <F3>    :call ProperPaste()<CR>
  nmap    <silent>    <F4>    :set hlsearch!<CR>
  nmap    <silent>    <F5>    :call ToggleSpecialChars()<CR>
  nmap    <silent>    <F6>    :call ToggleDiff()<CR>
  nmap    <silent>    <F7>    :NERDTreeToggle<CR>
  nmap    <silent>    <F8>    :call ToggleWrap()<CR>
  nmap    <silent>    <F9>    :call ToggleLight()<CR>
  nmap    <silent>    Q       <Nop>
  nmap    <silent>    <Up>    :ls<CR>
  nmap    <silent>    <Left>  :bp<CR>
  nmap    <silent>    <Right> :bn<CR>
  nmap    <silent>    H       :tabprevious<CR>
  nmap    <silent>    L       :tabnext<CR>
  " YouCompleteMe (still testing)
  nmap    <silent>    <Leader>d    :YcmCompleter GoToDefinition<CR>
  nmap    <silent>    <Leader>g    :YcmCompleter GoToDeclaration<CR>
  nmap    <silent>    <Leader>i    :YcmCompleter GoToInclude<CR>
  nmap    <silent>    K            :YcmCompleter GetDoc<CR>
