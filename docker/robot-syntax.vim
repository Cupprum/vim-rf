" Vim syntax file
" Language: Robot Framework
" Maintainer: Samuel Braniša
" Latest Revision: 22 October 2020

if exists("b:current_syntax")
  finish
endif

" Sections
syn match sections '^\*\*\* \(Settings\|Variables\|Test Cases\|Tasks\|Keywords\|Comments\) \*\*\*'

" Settings
syn match multiSpace nextgroup=argument '[[:blank:]]\+' contained
syn match argument nextgroup=multiSpace '[[:alnum:][:punct:]]\+' contained

syn match settings nextgroup=multiSpace skipwhite '^\.\.\.'
syn match settings nextgroup=multiSpace skipwhite '^\(Library\|Resource\|Variables\|Documentation\|Metadata\)'
syn match settings nextgroup=multiSpace skipwhite '^\(Force\|Default\) Tags'
syn match settings nextgroup=multiSpace skipwhite '^Suite \(Setup\|Teardown\)'
syn match settings nextgroup=multiSpace skipwhite '^\(Test\|Task\) \(Setup\|Teardown\|Template\|Timeout\)'

" Variables
syn match space nextgroup=word ' ' contained
syn match word nextgroup=space '[[:alnum:]-_.><]\+' contained

syn match variable nextgroup=word '${'
syn match variable nextgroup=word '%{'


" Test Cases
" --- Normal Standart Libraries
" * BuiltIn
syn match testCases '\(Call Method\|Catenate\|Comment\)'
syn match testCases 'Continue For Loop\( If\|\)'
syn match testCases 'Convert To \(Binary\|Boolean\|Bytes\|Hex\|Integer\|Number\|Octal\|String\)'
syn match testCases 'Create \(Dictionary\|List\)'
syn match testCases 'Evaluate'
syn match testCases 'Exit For Loop\( If\|\)'
syn match testCases '\(Fail\|Fatal Error\)'
syn match testCases 'Get \(Count\|Length\|Library Instance\|Time\|Variable Value\|Variables\)'
syn match testCases 'Import \(Library\|Resource\|Variables\)'
syn match testCases '\(Keyword Should Exist\|Length Should Be\)'
syn match testCases 'Log\( Many\| To Console\| Variables\|\)'
syn match testCases 'No Operation'
syn match testCases 'Pass Execution\( If\|\)'
syn match testCases '\(Regexp Escape\|Reload Library\|Remove Tags\|Repeat Keyword\|Replace Variables\)'
syn match testCases 'Return From Keyword\( If\|\)'
syn match testCases 'Run Keyword And Return\( If\| Status\|\)'
syn match testCases 'Run Keyword And \(Continue On Failure\|Expect Error\|Ignore Error\)'
syn match testCases 'Run Keyword If All \(Critical Tests Passed\|Tests Passed\|\)'
syn match testCases 'Run Keyword If Any \(Critical Tests Failed\|Tests Failed\|\)'
syn match testCases 'Run Keyword If Test \(Failed\|Passed\|\)'
syn match testCases 'Run Keyword If\( Timeout Occurred\|\)'
syn match testCases 'Run Keyword\( Unless\|s\|\)'
syn match testCases 'Set \(Global Variable\|Library Search Order\|Local Variable\|Log Level\)'
syn match testCases 'Set Suite \(Documentation\|Metadata\|Variable\)'
syn match testCases 'Set \(Tags\|Task Variable\)'
syn match testCases 'Set Test \(Documentation\|Message\|Variable\)'
syn match testCases 'Set Variable\( If\|\)'
syn match testCases 'Should Be Equal As \(Integers\|Numbers\|Strings\)'
syn match testCases 'Should Be \(Empty\|Equal\|True\)'
syn match testCases 'Should Contain\(Any\|X Times\|\)'
syn match testCases 'Should \(Not Start\|Not End\|Start\|End\) With'
syn match testCases 'Should Match\( Regexp\|\)'
syn match testCases 'Should Not Be Equal As \(Integers\|Numbers\|Strings\)'
syn match testCases 'Should Not Be \(Empty\|Equal\|True\)'
syn match testCases 'Should Not Contain\(Any\|\)'
syn match testCases 'Should Not Match\( Regexp\|\)'
syn match testCases 'Sleep'
syn match testCases 'Variable Should \(Not \|\)Exist'
syn match testCases 'Wait Until Keyword Succeeds'


hi def link sections        PreProc
hi def link settings        Type
" hi def link argument        Constant
hi def link word            Constant
hi def link testCases       Statement

