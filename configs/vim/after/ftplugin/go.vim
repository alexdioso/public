"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Go Source Code
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" gofmt defaults
setlocal noexpandtab
setlocal tabstop=8

" If this is a really wide window then split the screen vertically
if winwidth(0) >= 160
    setlocal winwidth=80
    " go programs with Makefiles
    map ,c :setlocal makeprg=make<cr>:set errorformat=%f:%l:%m<cr>:set errorformat+=%m\ at\ %f\ line\ %l.<cr>:make<cr>:vert cope<cr>
    " go programs with Makefiles with debugging
    map ,d :setlocal makeprg=make\ debug<cr>:set errorformat=%f:%l:%m<cr>:set errorformat+=%m\ at\ %f\ line\ %l.<cr>:make<cr>:vert cope<cr>

else
    " go programs with Makefiles
    map ,c :setlocal makeprg=make<cr>:set errorformat=%f:%l:%m<cr>:set errorformat+=%m\ at\ %f\ line\ %l.<cr>:make<cr>:cope<cr>
    " go programs with Makefiles with debugging
    map ,d :setlocal makeprg=make\ debug<cr>:set errorformat=%f:%l:%m<cr>:set errorformat+=%m\ at\ %f\ line\ %l.<cr>:make<cr>:cope<cr>
endif

" Go Lang - standard format
map ,f :Fmt<cr>
