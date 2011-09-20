" Tidy xml
map ,x :%!xmllint --format --recover - 2>/dev/null<cr>

" ISC License with XML comments
iab xiscl <esc>:r ~/git/public/templates/xml/isc_license.xml<cr><esc>kdd
