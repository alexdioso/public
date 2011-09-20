" using 'compiler perl' with 'makeprg perl -c' seemed to cause perl -Wc which
" would include errors from modules (especially from Readonly)

" If this is a really wide window then split the screen vertically
if winwidth(0) >= 160
    setlocal winwidth=80
    " Perl scripts - check for errors
    map ,C :set makeprg=perl\ -wc\ %<cr>:set errorformat=%f:%l:%m<cr>:set errorformat+=%m\ at\ %f\ line\ %l.<cr>:make<cr>:vert cope<cr>
    " Perl scripts - run perlcritic on entire file
    map ,c :compiler perlcritic<cr>:make<cr>:vert cope<cr>

else
    " Perl scripts - check for errors
    map ,C :set makeprg=perl\ -wc\ %<cr>:set errorformat=%f:%l:%m<cr>:set errorformat+=%m\ at\ %f\ line\ %l.<cr>:make<cr>:cope<cr>
    " Perl scripts - run perlcritic on entire file
    map ,c :compiler perlcritic<cr>:make<cr>:cope<cr>

endif

" Perl scripts - tidy line
map ,t :let save_cursor = getpos(".")<cr>:.!perltidy -q<cr>:call setpos('.', save_cursor)<cr>
" Perl scripts - tidy entire file
map ,T :let save_cursor = getpos(".")<cr>:%!perltidy -q<cr>:call setpos('.', save_cursor)<cr>
" Perl scripts - Deparse single line of obfuscated perl code
map ,d :.!perl -MO=Deparse 2>/dev/null<cr>
" Perl scripts - Deparse entire file of obfuscated perl code
map ,D :%!perl -MO=Deparse 2>/dev/null<cr>

" Entire perl modulino template
iab ptemplate <esc>:r ~/git/public/templates/perl/Template.pm<cr><esc>kdd
" ISC License with Perl comments
iab piscl <esc>:r ~/git/public/templates/perl/isc_license.pl<cr><esc>kdd
" Perl subroutine initial comments template
iab psub <esc>:r ~/git/public/templates/perl/subroutine.pl<cr><esc>kdd
