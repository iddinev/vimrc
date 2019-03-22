  set t_Co=256
  set encoding=utf-8
  filetype on

  set mouse=a
  set omnifunc=syntaxcomplete#Complete
  set backspace=2
  set nohlsearch
  set ignorecase
  set smartcase
  set ruler
  set numberwidth=2

  " colorscheme elflord
" Override of some specific color groups, override is independant of the selected scheme.
  " augroup mycolortweaks
      " au!
      " au ColorScheme * highlight Pmenu      ctermfg=214 ctermbg=237 guibg=Magenta
      " au ColorScheme * highlight PmenuSel   ctermfg=15  ctermbg=0   guibg=DarkGrey
      " au ColorScheme * highlight PmenuSbar              ctermbg=255 guibg=Grey
      " au ColorScheme * highlight PmenuThumb             ctermbg=243 guibg=White
      " au ColorScheme * highlight LineNr ctermfg=247
  " augroup END

  syntax on
  set nopaste
  set wrap
  set textwidth=105
  set scrolloff=999         " enables cursor to always be in the center of the screen when scrolling (when possible)
  " set formatoptions+=t      enables autowraping of line for all files (for python in its own file)
  set autoindent
  set smarttab
  set expandtab
  set softtabstop=4
  set tabstop=4
  set shiftwidth=4
  set listchars=tab:>-,trail:-,eol:$
  set number
  "set autochdir
  set splitright
  set splitbelow
  set ffs=unix
  set diffopt+=vertical


  function! ProperPaste()
        :set number!
        :set paste!
  endfunction

  function! ToggleDiff()
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
      set wrap!
      echo "wrap is set to:" &wrap
  endfunction


  match ErrorMsg '\s\+$'


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
  nmap    <silent>    Q       <Nop>
  nmap    <silent>    <Up>    :ls<CR>
  nmap    <silent>    <Left>  :bp<CR>
  nmap    <silent>    <Right> :bn<CR>
  nmap    <silent>    Q       :tabprevious<CR>
  nmap    <silent>    W       :tabnext<CR>




" VUNDLE
  set nocompatible
  filetype off

  set rtp+=~/.vim/bundle/Vundle.vim
  call vundle#begin()

" let Vundle manage Vundle
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  Plugin 'VundleVim/Vundle.vim'

" The bundles you install will be listed here

" Powerline setup
  Plugin 'vim-airline/vim-airline'
  set laststatus=2
  let g:airline#extensions#tabline#show_buffers = 0
  let g:airline#extensions#tabline#tab_min_count = 2
  let g:airline#extensions#tabline#enabled = 1
  let g:airline_symbols = {'maxlinenr': ''}

" Nerdcomenter setup
  Plugin 'scrooloose/nerdcommenter'
  let NERDSpaceDelims = 1

" Nerdtree setup
  Plugin 'scrooloose/nerdtree'
  let NERDTreeWinPos = 'right'
  let NERDTreeWinSize = '60'

" Jedi-vim setup
  Plugin 'davidhalter/jedi-vim'
  set noshowmode
  let g:jedi#show_call_signatures = 2
  let g:jedi#use_splits_not_buffers = 'right'

" Vim git plugin
  Plugin 'tpope/vim-fugitive'

  call vundle#end()
  filetype plugin indent on

" Vim nord colorscheme
  Plugin 'arcticicestudio/nord-vim'
  " colorscheme nord
  Plugin 'drewtempelmeyer/palenight.vim'
  Plugin 'mhartington/oceanic-next'
" VUNDLE */
