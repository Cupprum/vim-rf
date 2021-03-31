autocmd BufRead,BufNewFile *.robot setlocal tabstop=4 softtabstop=4 shiftwidth=4 filetype=robot omnifunc=syntaxcomplete#Complete

let b:ale_linters = ['rflint']

let g:tagbar_type_robot= {
    \ 'ctagstype' : 'robot',
    \ 'kinds'     : [
        \'t:testcases',
        \'k:keywords',
        \'v:variables'
  \]
\}
