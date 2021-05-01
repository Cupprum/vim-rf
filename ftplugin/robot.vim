let s:path = expand('<sfile>:p:h')
let s:commands = []

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

" Source command only if robot is installed and in PATH
if executable('robot') == 1
    " Test current testcase
    command! -nargs=? RFTestCase call robot#TestCase(<q-args>)
    call add(s:commands, 'RFTestCase')
endif

" Source command only if python and robot are installed and in PATH
if executable('python') == 1 && executable('robot') == 1
    " Test current file
    command! -nargs=? RFTestFile call robot#TestFile(<q-args>, s:path)
    call add(s:commands, 'RFTestFile')
endif

" Source command only if python and robot are installed and in PATH
if executable('python') == 1 && executable('robot') == 1
    " Test current directory
    command! -nargs=? RFTestDir call robot#TestDir(<q-args>, s:path)
    call add(s:commands, 'RFTestDir')
endif

" Source command only if rflint is installed and in PATH
if executable('rflint') == 1
    " Print all Errors and Warnings
    command! RFLint call robot#Lint()
    call add(s:commands, 'RFLint')
endif

command -range RFCommentLine <line1>,<line2>call robot#CommentLine()
call add(s:commands, 'RFCommentLine')
command -range RFUncommentLine <line1>,<line2>call robot#UncommentLine()
call add(s:commands, 'RFUncommentLine')

" Print all possible commands
call add(s:commands, 'RFDebug')
command RFDebug call RFPutToNewBuffer(s:commands)
