"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Go Source Code
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" gofmt defaults
setlocal shiftwidth=8
setlocal noexpandtab
setlocal tabstop=8
setlocal shiftwidth=8
setlocal softtabstop=8

" If this is a really wide window then split the screen vertically
if winwidth(0) >= 160
    setlocal winwidth=80
    " go programs with Makefiles
    map <leader>c :setlocal makeprg=make<cr>:set errorformat=%f:%l:%m<cr>:set errorformat+=%m\ at\ %f\ line\ %l.<cr>:make<cr>:vert cope<cr>
    " go programs with Makefiles with debugging
    map <leader>d :setlocal makeprg=make\ debug<cr>:set errorformat=%f:%l:%m<cr>:set errorformat+=%m\ at\ %f\ line\ %l.<cr>:make<cr>:vert cope<cr>
    " go programs with testing
    map <leader>t :setlocal makeprg=make\ test<cr>:set errorformat=%f:%l:%m<cr>:set errorformat+=%m\ at\ %f\ line\ %l.<cr>:make<cr>:vert cope<cr>

else
    " go programs with Makefiles
    map <leader>c :setlocal makeprg=make<cr>:set errorformat=%f:%l:%m<cr>:set errorformat+=%m\ at\ %f\ line\ %l.<cr>:make<cr>:cope<cr>
    " go programs with Makefiles with debugging
    map <leader>d :setlocal makeprg=make\ debug<cr>:set errorformat=%f:%l:%m<cr>:set errorformat+=%m\ at\ %f\ line\ %l.<cr>:make<cr>:cope<cr>
    map <leader>t :setlocal makeprg=make\ test<cr>:set errorformat=%f:%l:%m<cr>:set errorformat+=%m\ at\ %f\ line\ %l.<cr>:make<cr>:cope<cr>
endif

" Go Lang - standard format
map <leader>f :Fmt<cr>
map <leader>i :setlocal makeprg=make\ install<cr>:set errorformat=%f:%l:%m<cr>:set errorformat+=%m\ at\ %f\ line\ %l.<cr>:make<cr>:cope<cr>
