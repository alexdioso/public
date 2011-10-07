"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" C++ Source Code
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" If this is a really wide window then split the screen vertically
if winwidth(0) >= 160
    setlocal winwidth=80
    " go programs with Makefiles
    map ,c :setlocal makeprg=g++<cr>:set errorformat=%f:%l:%m<cr>:set errorformat+=%m\ at\ %f\ line\ %l.<cr>:make<cr>:vert cope<cr>

else
    " go programs with Makefiles
    map ,c :setlocal makeprg=g++<cr>:set errorformat=%f:%l:%m<cr>:set errorformat+=%m\ at\ %f\ line\ %l.<cr>:make<cr>:cope<cr>

endif

" Tidy C++ source code
map ,i 1G!Gindent
