" Purpose: Vim syntax file for Robot Framework
" Last Change: 22 December 2020
" Maintainer: Samuel Braniša
" Language: Robot Framework
" License: This file is placed in the public domain.

if exists("b:current_syntax")
  finish
endif

" Sections
syn match sections '^\*\*\* \(Settings\|Variables\|Test Cases\|Tasks\|Keywords\|Comments\) \*\*\*'

" " Settings
" syn match multiSpace nextgroup=argument '[[:blank:]]\+' contained
" syn match argument nextgroup=multiSpace '[[:alnum:][:punct:]]\+' contained
" 
" syn match settings nextgroup=multiSpace skipwhite '^\.\.\.'
" syn match settings nextgroup=multiSpace skipwhite '^\(Library\|Resource\|Variables\|Documentation\|Metadata\)'
" syn match settings nextgroup=multiSpace skipwhite '^\(Force\|Default\) Tags'
" syn match settings nextgroup=multiSpace skipwhite '^Suite \(Setup\|Teardown\)'
" syn match settings nextgroup=multiSpace skipwhite '^\(Test\|Task\) \(Setup\|Teardown\|Template\|Timeout\)'
" 
" " Variables
" syn match space nextgroup=word ' ' contained
" syn match word nextgroup=space '[[:alnum:]-_.><]\+' contained
" 
" syn match variable nextgroup=word '${'
" syn match variable nextgroup=word '%{'
" 
" 
" " Test Cases
" " --- Normal Standart Libraries
" " * BuiltIn
" syn match testCases '\(Call Method\|Catenate\|Comment\)'
" syn match testCases 'Continue For Loop\( If\|\)'
" syn match testCases 'Convert To \(Binary\|Boolean\|Bytes\|Hex\|Integer\|Number\|Octal\|String\)'
" syn match testCases 'Create \(Dictionary\|List\)'
" syn match testCases 'Evaluate'
" syn match testCases 'Exit For Loop\( If\|\)'
" syn match testCases '\(Fail\|Fatal Error\)'
" syn match testCases 'Get \(Count\|Length\|Library Instance\|Time\|Variable Value\|Variables\)'
" syn match testCases 'Import \(Library\|Resource\|Variables\)'
" syn match testCases '\(Keyword Should Exist\|Length Should Be\)'
" syn match testCases 'Log\( Many\| To Console\| Variables\|\)'
" syn match testCases 'No Operation'
" syn match testCases 'Pass Execution\( If\|\)'
" syn match testCases '\(Regexp Escape\|Reload Library\|Remove Tags\|Repeat Keyword\|Replace Variables\)'
" syn match testCases 'Return From Keyword\( If\|\)'
" syn match testCases 'Run Keyword And Return\( If\| Status\|\)'
" syn match testCases 'Run Keyword And \(Continue On Failure\|Expect Error\|Ignore Error\)'
" syn match testCases 'Run Keyword If All \(Critical Tests Passed\|Tests Passed\)'
" syn match testCases 'Run Keyword If Any \(Critical Tests Failed\|Tests Failed\)'
" syn match testCases 'Run Keyword If Test \(Failed\|Passed\|\)'
" syn match testCases 'Run Keyword If\( Timeout Occurred\|\)'
" syn match testCases 'Run Keyword\( Unless\|s\|\)'
" syn match testCases 'Run Keyword\( And \(Return\( If\| Status\|\)\|Continue On Failure\|Expect Error\|Ignore Error\)\| If\( All \(Critical Tests Passed\|Tests Passed\)\| Any \(Critical Tests Failed\|Tests Failed\)\| Test \(Failed\|Passed\)\| Timeout Occurred\|\)\| Unless\|s\|\)'
" syn match testCases 'Set \(Global Variable\|Library Search Order\|Local Variable\|Log Level\)'
" syn match testCases 'Set Suite \(Documentation\|Metadata\|Variable\)'
" syn match testCases 'Set \(Tags\|Task Variable\)'
" syn match testCases 'Set Test \(Documentation\|Message\|Variable\)'
" syn match testCases 'Set Variable\( If\|\)'
" syn match testCases '\(Should Be Equal As \(Integers\|Numbers\|Strings\)\|Should Be \(Empty\|Equal\|True\)\)'
" syn match testCases 'Should Contain\( Any\| X Times\|\)'
" syn match testCases 'Should \(Not Start\|Not End\|Start\|End\) With'
" syn match testCases 'Should Match\( Regexp\|\)'
" syn match testCases '\(Should Not Be Equal As \(Integers\|Numbers\|Strings\)\|Should Not Be \(Empty\|Equal\|True\)\)'
" syn match testCases 'Should Not Contain\( Any\|\)'
" syn match testCases 'Should Not Match\( Regexp\|\)'
" syn match testCases 'Sleep'
" syn match testCases 'Variable Should \(Not \|\)Exist'
" syn match testCases 'Wait Until Keyword Succeeds'
" 
" " * Collections
" syn match testCases '\(Append To List\|Combine Lists\)'
" syn match testCases '\(Convert To\|Copy\) \(Dictionary\|List\)'
" syn match testCases '\(Count Values In List\|Dictionaries Should Be Equal\)'
" syn match testCases 'Dictionary Should \(Contain \(Item\|Key\|Sub Dictionary\|Value\)\|Not Contain \(Key\|Value\)\)'
" syn match testCases 'Get \(Dictionary \(Items\|Keys\|Values\)\|From \(Dictionary\|List\)\|Index From List\|Match Count\|Matches\|Slice From List\)'
" syn match testCases '\(Insert Into List\|Keep In Dictionary\)'
" syn match testCases 'List Should \(Contain \(Sub List\|Value\)\|Not Contain \(Duplicates\|Value\)\)'
" syn match testCases 'Lists Should Be Equal'
" syn match testCases 'Log \(Dictionary\|List\)'
" syn match testCases 'Pop From Dictionary'
" syn match testCases 'Remove \(Duplicates\|From \(Dictionary\|List\)\|Values From List\)'
" syn match testCases 'Reverse List'
" syn match testCases 'Set \(List Value\|To Dictionary\)'
" syn match testCases 'Should \(Not \|\)Contain Match'
" syn match testCases 'Sort List'
" 
" " * DateTime
" syn match testCases 'Add Time To \(Date\|Time\)'
" syn match testCases 'Convert \(Date\|Time\)'
" syn match testCases 'Get Current Date'
" syn match testCases 'Subtract \(Date From Date\|Time From \(Date\|Time\)\)'
" 
" " * Dialogs
" syn match testCases 'Execute Manual Step'
" syn match testCases 'Get \(Selection\|Selections\|Value\) From User'
" syn match testCases 'Pause Execution'
" 
" " * OperatingSystem
" syn match testCases 'Append To \(Environment Variable\|File\)'
" syn match testCases 'Copy \(Directory\|Files\|File\)'
" syn match testCases 'Count \(Directories\|Files\|Items\) In Directory'
" syn match testCases 'Create \(Binary File\|Directory\|File\)'
" syn match testCases 'Directory Should \(Not \|\)\(Be Empty\|Exist\)'
" syn match testCases 'Empty Directory'
" syn match testCases 'Environment Variable Should \(Not \|\)Be Set'
" syn match testCases 'File Should \(Not \|\)\(Be Empty\|Exist\)'
" syn match testCases 'Get Binary File'
" syn match testCases 'Get Environment \(Variables\|Variable\)'
" syn match testCases 'Get \(File Size\|File\|Modified Time\)'
" syn match testCases 'Grep File'
" syn match testCases 'Join \(Paths\|Path\)'
" syn match testCases 'List \(Directories In Directory\|Directory\|Files In Directory\)'
" syn match testCases 'Log \(Environment Variables\|File\)'
" syn match testCases 'Move \(Directory\|Files\|File\)'
" syn match testCases 'Normalize Path'
" syn match testCases 'Remove \(Directory\|Environment Variable\|Files\|File\)'
" syn match testCases 'Run\( And Return Rc\( And Output\|\)\|\)'
" syn match testCases 'Set \(Environment Variable\|Modified Time\)'
" syn match testCases 'Should \(Not \|\)Exist'
" syn match testCases 'Split \(Extension\|Path\)'
" syn match testCases 'Touch'
" syn match testCases 'Wait Until \(Created\|Removed\)'
" 
" " * Process
" syn match testCases 'Get Process \(Id\|Object\|Result\)'
" syn match testCases '\(Is Process Running\|Is Process Running\|Join Command Line\)'
" syn match testCases 'Process Should Be \(Running\|Stopped\)'
" syn match testCases '\(Run Process\|Send Signal To Process\|Split Command Line\|Start Process\|Switch Process\)'
" syn match testCases 'Terminate \(All Processes\|Process\)'
" syn match testCases 'Wait For Process'
" 
" " * Screenshot
" syn match testCases 'Set Screenshot Directory'
" syn match testCases 'Take Screenshot\( Without Embedding\|\)'
" 
" hi def link sections        PreProc
" hi def link settings        Type
" " hi def link argument        Constant
" hi def link word            Constant
" hi def link testCases       Statement
" 
