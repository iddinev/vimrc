"   FORTRAN specific options and other

"   note that this is not put in /after as to not override vim's default
"   options.


"   imap <TAB> <Space><Space><Space><Space>

"   highlight everything past the 132rd column
    highlight Excess ctermfg=8 guibg=Black
    match Excess /\%132v.*/

"   let vim know that we're working with ONLY FREE FORMAT files, so that we can
"   use 80 char lines - as set in .vim/plugin/main.vim
    let fortran_free_source=1
