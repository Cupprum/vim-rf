let s:path = expand('<sfile>:p:h')

" TEST CURRENT TESTCASE
function! s:TestCase(arg)
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

    if a:arg == "-l"
        let l:output = l:test_case_name
    else
        let l:output = system('robot -t "' . l:test_case_name . '" ' . l:file_path)
    endif
    put = l:output

    setlocal nomodifiable
    let &wrapscan = l:wrapscan
endfunction
command! -nargs=? RFTestCase call s:TestCase(<q-args>)

" TEST CURRENT FILE
function! s:TestFile(arg)
    let l:file_path = expand('%:p')

    if a:arg == "-l"
        let l:output = system('python ' . s:path . '/list_tests.py ' . l:file_path)
    else
        let l:output = system('robot ' . l:file_path)
    endif

    botright vnew
    setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap

    put = l:output

    setlocal nomodifiable
endfunction
command! -nargs=? RFTestFile call s:TestFile(<q-args>)

" TEST CURRENT DIRECTORY
function! s:TestDir(arg)
    let l:dir_path = expand('%:p:h')

    if a:arg == "-l"
        let l:output = system('python ' . s:path . '/list_tests.py ' . l:dir_path)
    else
        let l:output = system('robot ' . l:dir_path)
    endif

    botright vnew
    setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap

    put = l:output

    setlocal nomodifiable
endfunction
command! -nargs=? RFTestDir call s:TestDir(<q-args>)
