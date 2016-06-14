"   BASH specific options and other

"   note that this is not put in /after as to not override vim's default
"   options.


"   BASH doesnt like here-documents having spaces, so we use tabs.

    set noexpandtab
    filetype indent off
    inoremap <silent> <C-V><Tab> <Space><Space><Space><Space>


"   wq remap so that it automatically gives 'x' permissions to the files
"   located in $HOME/bin. w + CTRL-V q can still be used to exit without giving
"   permisions. ':redraw!' because vim doesn't redraw the screen if we have
"   more than 1 buffer when we close some buffer (buffers showing .sh). 'function!' is used, because
"   otherwise if we open more than 1 .sh file vim will return error - trying
"   to define an already existing function. ':w' before 'execute' for when we edit a new file - explicitly create it, before modifying its permissions.
 
    cnoremap wq call Givex() 
        function! Givex() 
            :w
            :execute 'silent ![[ "$PWD" =~ ^${HOME}/bin ]] && chmod u+x '.expand('%:t').' 2>/dev/null'
            :q
            :redraw!
        endfunction
