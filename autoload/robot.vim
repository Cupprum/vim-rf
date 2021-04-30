function! robot#TestCase(arg)
    let l:file_path = expand('%:p')

    let l:test_case_name = RFFindTestCaseName()

    if a:arg == '-l'
        let l:output = l:test_case_name
    else
        let l:output = system('robot -t "' . l:test_case_name . '" ' . l:file_path)
    endif

    call RFPutToNewBuffer(l:output)
endfunction

function! robot#TestFile(arg, path)
    let l:file_path = expand('%:p')

    if a:arg == '-l'
        let l:output = system('python ' . a:path . '/list_tests.py ' . l:file_path)
    else
        let l:output = system('robot ' . l:file_path)
    endif

    call RFPutToNewBuffer(l:output)
endfunction

function! robot#TestDir(arg, path)
    let l:dir_path = expand('%:p:h')

    if a:arg == '-l'
        let l:output = system('python ' . a:path . '/list_tests.py ' . l:dir_path)
    else
        let l:output = system('robot ' . l:dir_path)
    endif

    call RFPutToNewBuffer(l:output)
endfunction

function! robot#CommentLine() range
    let l:wrapscan = &wrapscan
    set nowrapscan

    let l:cursor_pos = getpos('.')
    execute a:firstline . ',' . a:lastline . 's/^/\# /'

    call setpos('.', l:cursor_pos)
    let &wrapscan = l:wrapscan
endfunction

function! robot#UncommentLine() range
    let l:wrapscan = &wrapscan
    set nowrapscan

    let l:cursor_pos = getpos('.')
    execute a:firstline . ',' . a:lastline . 's/^\# \?//'

    call setpos('.', l:cursor_pos)
    let &wrapscan = l:wrapscan
endfunction

function! robot#Lint()
    let l:file_path = expand('%:p')

    let l:output = system('rflint ' . l:file_path)

    call RFPutToNewBuffer(l:output)
endfunction
