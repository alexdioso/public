" Android development
" vim must be run from project root
" Install current project
map ,ai :!ant install<cr>
map ,ad :!ant debug<cr>
map ,at :!ant run-tests<cr>

" If this is a really wide window then split the screen vertically
if winwidth(0) >= 160
    setlocal winwidth=80
    "map ,c :setlocal makeprg=javac\ %<cr>:set errorformat=%f:%l:%m<cr>:set errorformat+=%m\ at\ %f\ line\ %l.<cr>:make<cr>:vert cope<cr>
    map ,c :setlocal makeprg=make<cr>:set errorformat=%f:%l:%m<cr>:set errorformat+=%m\ at\ %f\ line\ %l.<cr>:make<cr>:vert cope<cr>
else
    "map ,c :setlocal makeprg=javac\ %<cr>:set errorformat=%f:%l:%m<cr>:set errorformat+=%m\ at\ %f\ line\ %l.<cr>:make<cr>:cope<cr>
    map ,c :setlocal makeprg=make<cr>:set errorformat=%f:%l:%m<cr>:set errorformat+=%m\ at\ %f\ line\ %l.<cr>:make<cr>:cope<cr>
endif
