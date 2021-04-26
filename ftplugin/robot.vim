let s:path = expand('<sfile>:p:h')

function! RFPutToNewBuffer(output)
    botright vnew
    setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap

    put = a:output

    setlocal nomodifiable
endfunction

function! RFFindTestCaseName()
    let l:wrapscan = &wrapscan
    set nowrapscan

    let l:cursor_pos = getpos('.')
    call cursor(line('.') + 1, 0)

    try
        execute '?^[[:alnum:]]'
    catch
        echom('Possition cursor on Test Case 1')
        call setpos('.', l:cursor_pos)
        let &wrapscan = l:wrapscan
        return 0
    endtry

    let l:test_case_name = getline('.')

    try
        execute '?\*\*\* Test Cases \*\*\*'
    catch
        echom('Possition cursor on Test Case')
        call setpos('.', l:cursor_pos)
        let &wrapscan = l:wrapscan
        return 0
    endtry

    let &wrapscan = l:wrapscan
    call setpos('.', l:cursor_pos)
    return l:test_case_name
endfunction

" TEST CURRENT TESTCASE
command! -nargs=? RFTestCase call robot#TestCase(<q-args>)

" TEST CURRENT FILE
command! -nargs=? RFTestFile call robot#TestFile(<q-args>, s:path)

" TEST CURRENT DIRECTORY
command! -nargs=? RFTestDir call robot#TestDir(<q-args>, s:path)

command -range RFCommentLine <line1>,<line2>call robot#CommentLine()
command -range RFUncommentLine <line1>,<line2>call robot#UncommentLine()
