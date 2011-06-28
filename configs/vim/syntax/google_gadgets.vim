" Vim syntax file for Google gadgets module files.
" Maintainer: Guy Rutenberg <http://www.guyrutenberg.com>
" Last Change: 2008 Mar 28
"
 
:syntax clear
 
runtime! syntax/xml.vim
 
unlet b:current_syntax
:syntax include @HTML syntax/html.vim
:syntax region HTMLcode matchgroup=CDATA start=/<Content\s\+type="html"\s*>\_s*<!\[CDATA\[/ end=/\]\]>\_s*<\/Content>/ contains=@HTML
 
syn keyword javaScriptReserved _IG_Prefs getString getInt getBool getArray set setArray dump _IG_FetchContent _IG_FetchXmlContent _IG_FetchFeedAsJSON _IG_RegisterOnloadHandler _gel _gelstn _esc _unesc _trim _uc _min _max _hesc _args _toggle _IG_GetImage _IG_GetCachedUrl
let b:current_syntax = "google_gadgets"
