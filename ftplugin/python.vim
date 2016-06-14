"   PYTHON specific options and other

"   note that this is not put in /after as to not override vim's default
"   options.

"   highlight everything past the 120th column, dont wrap lines
   
    highlight Excess ctermfg=8 guibg=Black
    match Excess /\%120v.*/
    set wrap
    set formatoptions+=t
    set textwidth=90
    set foldmethod=indent
    set foldlevel=6
