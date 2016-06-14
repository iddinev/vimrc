"   main plugin 
"   for now mainly used for small file-specific file insertions ( too small to
"   warant a whole skeleton file ), put in here because /plugin are loaded
"   once and can actually write with BufNewFile.

"   FORTRAN header insertion
"!  seems like the best ( as in easiest ) solution for the filetype insertions
"!  even if using 1 skeleton for the whole filetype
    autocmd BufNewFile *.f08,*.f03,*.f95,*.f90,*.for,*.f,*.F,*.f77,*.ftn,*.fpp      normal i      program 
    autocmd FileType fortran set textwidth=90

"   BASH header insertion
    autocmd BufNewFile *.sh     normal i#!/bin/bash

"   PYTHON header insertion
    autocmd BufNewFile *.py     normal i#!/usr/bin/env python3
