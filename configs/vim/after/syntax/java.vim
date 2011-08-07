" Fold Javadoc
syn region foldJavadoc start="/\*" end="\*/" transparent fold keepend extend
" Fold Java imports
syn region foldImports start=/\(^\s*\n^import\)\@<= .\+;/ end="^\s*$" transparent fold keepend
