autocmd BufRead,BufNewFile *.robot setlocal tabstop=4 softtabstop=4 shiftwidth=4 filetype=robot 

let b:ale_linters = ['rflint']

function RunAllTests()
    let l = system('sudo robot exec-tests.robot')
    echo l
endfunction

command RFTestAll call RunAllTests()
