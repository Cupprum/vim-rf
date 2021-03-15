autocmd BufRead,BufNewFile *.robot setlocal tabstop=4 softtabstop=4 shiftwidth=4 filetype=robot 

let b:ale_linters = ['rflint']

" TEST CURRENT FILE
function! s:TestFile()
    let l:file_path = expand('%:p')
    let l:output = system('sudo robot ' . l:file_path)

    botright vnew
    setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap

    put = l:output

    setlocal nomodifiable
endfunction

command! RFTestFile call s:TestFile()

" TEST CURRENT TESTCASE
function! s:TestCase()
    let l:file_path = expand('%:p')
    let l:wrapscan = &wrapscan
    set nowrapscan

    let l:cursor_pos = getpos('.')
    call cursor(line('.') + 1, 0)

    try
        execute '?^[[:alnum:]]'
    catch
        echom("Possition cursor on Test Case 1")
        call setpos('.', l:cursor_pos)
        let &wrapscan = l:wrapscan
        return 0
    endtry

    let l:test_case_name = getline('.')

    try
        execute '?\*\*\* Test Cases \*\*\*'
    catch
        echom("Possition cursor on Test Case")
        call setpos('.', l:cursor_pos)
        let &wrapscan = l:wrapscan
        return 0
    endtry
        
    call setpos('.', l:cursor_pos)

    botright vnew
    setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap

    let l:output = system('sudo robot -t "' . l:test_case_name . '" ' . l:file_path)
    put = l:output

    setlocal nomodifiable
    let &wrapscan = l:wrapscan
endfunction

command! RFTestCase call s:TestCase()
