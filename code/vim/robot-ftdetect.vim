autocmd BufRead,BufNewFile *.robot setlocal tabstop=4 softtabstop=4 shiftwidth=4 filetype=robot 

let b:ale_linters = ['rflint']
