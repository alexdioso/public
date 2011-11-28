" JavaScript - Run spidermonkey on entire file
map <leader>j :setlocal makeprg=js\ %<cr>:set errorformat=%f:%l:%m<cr>:set errorformat+=%m\ at\ %f\ line\ %l.<cr>:make<cr>:cope<cr>
" JavaScript - Run closure compiler on entire file
map <leader>c :setlocal makeprg=closure\ --compilation_level\ ADVANCED_OPTIMIZATIONS\ --js\ %\ --js_output_file\ %:r.tiny.js\ --externs\ %:r.externs.js<cr>:make<cr><cr>

" ISC License with JavaScript comments
iab jiscl <esc>:r ~/git/public/templates/js/isc_license.js<cr><esc>kdd
" JavaScript class/function initial comments template
iab jclass <esc>:r ~/git/public/templates/js/class.js<cr><esc>kdd
" JavaScript initial externs template
iab jexterns <esc>:r ~/git/public/templates/js/externs.js<cr><esc>kdd
