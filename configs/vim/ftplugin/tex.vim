let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_CompileRule_pdf = 'pdflatex -output-dir tmp -interaction=nonstopmode $*'
let g:Tex_ViewRule_pdf = 'cd tmp/ && xdg-open'
