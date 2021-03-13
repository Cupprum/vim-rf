" Purpose: Vim syntax file for Robot Framework
" Last Change: 22 December 2020
" Maintainer: Samuel Braniša
" Language: Robot Framework
" License: This file is placed in the public domain.

if exists("b:current_syntax")
  finish
endif

syntax sync minlines=100

" Constant
" Special
" Identifier
" Statement
" PreProc
" Type

syntax match variableName '\([[:alnum:]_] \{0,1}\)\+' contained
syntax region variable start='\(\$\|%\|@\|&\){' end='}\(=\|\)' contains=variableName keepend
syntax match path '\(\.\|\)/[[:punct:][:alnum:][:punct:]]\+' contained

" Sections
syntax match sections '^\*\*\*[[:alpha:][:blank:]]\+\*\*\*'

" Settings
syntax keyword and AND contained nextgroup=blank
syntax match blank '[[:blank:]]\+' contained nextgroup=and,path,settingValue

syntax match threeDotsImports '^\.\.\.' contained nextgroup=blank

syntax match settingName '^\([[:alnum:]] \{0,1}\)\+' contained nextgroup=blank
syntax match settingValue '\([[:alnum:]] \{0,1}\)\+' contained nextgroup=settingParams
syntax match settingParams '.\+$' contained

syntax region importsBorders start='^\*\*\* Settings \*\*\*' end='\(^\*\*\*\)\@=' 
    \ contains=settingName,sections,threeDotsImports keepend

syntax match settingName '^\(Library\|Resource\|Variables\|Documentation\|Metadata\)' nextgroup=blank
syntax match settingName '^\(Force\|Default\) Tags' nextgroup=blank
syntax match settingName '^Suite \(Setup\|Teardown\)' nextgroup=blank
syntax match settingName '^\(Test\|Task\) \(Setup\|Teardown\|Template\|Timeout\)' nextgroup=blank


" Test Cases
syntax match strings '\".\+\"'
syntax match threeDotsTestCases '\.\.\.' contained
syntax match testCaseName '^\([[:alnum:]_] \{0,1}\)\+' contained
syntax match testCaseCall '^[[:blank:]]\+\([[:alnum:]] \{0,1}\)\+' contained
syntax match testCaseCallAfterVar '[[:blank:]]\+\([[:alnum:]] \{0,1}\)\+' contained
syntax region variableTestCase start='^[[:blank:]]\+\(\$\|%\|@\|&\){' end='}\(=\|\)' contains=variableName keepend nextgroup=testCaseCallAfterVar

syntax region testCaseBorders start='^\*\*\* Test Cases \*\*\*' end='\%$'
    \ contains=testCaseName,testCaseCall,sections,variableTestCase,variable,threeDotsTestCases,strings

" --- Normal Standart Libraries
" * BuiltIn
syntax match testCaseCall 'Call Method\|Catenate\|Comment' contained
syntax match testCaseCall 'Continue For Loop\( If\|\)' contained
syntax match testCaseCall 'Convert To \(Binary\|Boolean\|Bytes\|Hex\|Integer\|Number\|Octal\|String\)' contained
syntax match testCaseCall 'Create \(Dictionary\|List\)' contained
syntax match testCaseCall 'Evaluate' contained
syntax match testCaseCall 'Exit For Loop\( If\|\)' contained
syntax match testCaseCall 'Fail\|Fatal Error' contained
syntax match testCaseCall 'Get \(Count\|Length\|Library Instance\|Time\|Variable Value\|Variables\)' contained
syntax match testCaseCall 'Import \(Library\|Resource\|Variables\)' contained
syntax match testCaseCall 'Keyword Should Exist\|Length Should Be' contained
syntax match testCaseCall 'Log\( Many\| To Console\| Variables\|\)' contained
syntax match testCaseCall 'No Operation' contained
syntax match testCaseCall 'Pass Execution\( If\|\)' contained
syntax match testCaseCall 'Regexp Escape\|Reload Library\|Remove Tags\|Repeat Keyword\|Replace Variables' contained
syntax match testCaseCall 'Return From Keyword\( If\|\)' contained
syntax match testCaseCall 'Run Keyword And Return\( If\| Status\|\)' contained
syntax match testCaseCall 'Run Keyword And \(Continue On Failure\|Expect Error\|Ignore Error\)' contained
syntax match testCaseCall 'Run Keyword If All \(Critical Tests Passed\|Tests Passed\)' contained
syntax match testCaseCall 'Run Keyword If Any \(Critical Tests Failed\|Tests Failed\)' contained
syntax match testCaseCall 'Run Keyword If Test \(Failed\|Passed\|\)' contained
syntax match testCaseCall 'Run Keyword If\( Timeout Occurred\|\)' contained
syntax match testCaseCall 'Run Keyword\( Unless\|s\|\)' contained
syntax match testCaseCall 'Run Keyword\( And \(Return\( If\| Status\|\)\|Continue On Failure\|Expect Error\|Ignore Error\)\| If\( All \(Critical Tests Passed\|Tests Passed\)\| Any \(Critical Tests Failed\|Tests Failed\)\| Test \(Failed\|Passed\)\| Timeout Occurred\|\)\| Unless\|s\|\)' contained
syntax match testCaseCall 'Set \(Global Variable\|Library Search Order\|Local Variable\|Log Level\)' contained
syntax match testCaseCall 'Set Suite \(Documentation\|Metadata\|Variable\)' contained
syntax match testCaseCall 'Set \(Tags\|Task Variable\)' contained
syntax match testCaseCall 'Set Test \(Documentation\|Message\|Variable\)' contained
syntax match testCaseCall 'Set Variable\( If\|\)' contained
syntax match testCaseCall '\(Should Be Equal As \(Integers\|Numbers\|Strings\)\|Should Be \(Empty\|Equal\|True\)\)' contained
syntax match testCaseCall 'Should Contain\( Any\| X Times\|\)' contained
syntax match testCaseCall 'Should \(Not Start\|Not End\|Start\|End\) With' contained
syntax match testCaseCall 'Should Match\( Regexp\|\)' contained
syntax match testCaseCall '\(Should Not Be Equal As \(Integers\|Numbers\|Strings\)\|Should Not Be \(Empty\|Equal\|True\)\)' contained
syntax match testCaseCall 'Should Not Contain\( Any\|\)' contained
syntax match testCaseCall 'Should Not Match\( Regexp\|\)' contained
syntax match testCaseCall 'Sleep' contained
syntax match testCaseCall 'Variable Should \(Not \|\)Exist' contained
syntax match testCaseCall 'Wait Until Keyword Succeeds' contained

" * Collections
syntax match testCaseCall 'Append To List\|Combine Lists' contained
syntax match testCaseCall '\(Convert To\|Copy\) \(Dictionary\|List\)' contained
syntax match testCaseCall 'Count Values In List\|Dictionaries Should Be Equal' contained
syntax match testCaseCall 'Dictionary Should \(Contain \(Item\|Key\|Sub Dictionary\|Value\)\|Not Contain \(Key\|Value\)\)' contained
syntax match testCaseCall 'Get \(Dictionary \(Items\|Keys\|Values\)\|From \(Dictionary\|List\)\|Index From List\|Match Count\|Matches\|Slice From List\)' contained
syntax match testCaseCall 'Insert Into List\|Keep In Dictionary' contained
syntax match testCaseCall 'List Should \(Contain \(Sub List\|Value\)\|Not Contain \(Duplicates\|Value\)\)' contained
syntax match testCaseCall 'Lists Should Be Equal' contained
syntax match testCaseCall 'Log \(Dictionary\|List\)' contained
syntax match testCaseCall 'Pop From Dictionary' contained
syntax match testCaseCall 'Remove \(Duplicates\|From \(Dictionary\|List\)\|Values From List\)' contained
syntax match testCaseCall 'Reverse List' contained
syntax match testCaseCall 'Set \(List Value\|To Dictionary\)' contained
syntax match testCaseCall 'Should \(Not \|\)Contain Match' contained
syntax match testCaseCall 'Sort List' contained

" * DateTime
syntax match testCaseCall 'Add Time To \(Date\|Time\)' contained
syntax match testCaseCall 'Convert \(Date\|Time\)' contained
syntax match testCaseCall 'Get Current Date' contained
syntax match testCaseCall 'Subtract \(Date From Date\|Time From \(Date\|Time\)\)' contained

" * Dialogs
syntax match testCaseCall 'Execute Manual Step' contained
syntax match testCaseCall 'Get \(Selection\|Selections\|Value\) From User' contained
syntax match testCaseCall 'Pause Execution' contained

" * OperatingSystem
syntax match testCaseCall 'Append To \(Environment Variable\|File\)' contained
syntax match testCaseCall 'Copy \(Directory\|Files\|File\)' contained
syntax match testCaseCall 'Count \(Directories\|Files\|Items\) In Directory' contained
syntax match testCaseCall 'Create \(Binary File\|Directory\|File\)' contained
syntax match testCaseCall 'Directory Should \(Not \|\)\(Be Empty\|Exist\)' contained
syntax match testCaseCall 'Empty Directory' contained
syntax match testCaseCall 'Environment Variable Should \(Not \|\)Be Set' contained
syntax match testCaseCall 'File Should \(Not \|\)\(Be Empty\|Exist\)' contained
syntax match testCaseCall 'Get Binary File' contained
syntax match testCaseCall 'Get Environment \(Variables\|Variable\)' contained
syntax match testCaseCall 'Get \(File Size\|File\|Modified Time\)' contained
syntax match testCaseCall 'Grep File' contained
syntax match testCaseCall 'Join \(Paths\|Path\)' contained
syntax match testCaseCall 'List \(Directories In Directory\|Directory\|Files In Directory\)' contained
syntax match testCaseCall 'Log \(Environment Variables\|File\)' contained
syntax match testCaseCall 'Move \(Directory\|Files\|File\)' contained
syntax match testCaseCall 'Normalize Path' contained
syntax match testCaseCall 'Remove \(Directory\|Environment Variable\|Files\|File\)' contained
syntax match testCaseCall 'Run\( And Return Rc\( And Output\|\)\|\)' contained
syntax match testCaseCall 'Set \(Environment Variable\|Modified Time\)' contained
syntax match testCaseCall 'Should \(Not \|\)Exist' contained
syntax match testCaseCall 'Split \(Extension\|Path\)' contained
syntax match testCaseCall 'Touch' contained
syntax match testCaseCall 'Wait Until \(Created\|Removed\)' contained

" * Process contained
syntax match testCaseCall 'Get Process \(Id\|Object\|Result\)' contained
syntax match testCaseCall 'Is Process Running\|Is Process Running\|Join Command Line' contained
syntax match testCaseCall 'Process Should Be \(Running\|Stopped\)' contained
syntax match testCaseCall 'Run Process\|Send Signal To Process\|Split Command Line\|Start Process\|Switch Process' contained
syntax match testCaseCall 'Terminate \(All Processes\|Process\)' contained
syntax match testCaseCall 'Wait For Process' contained

" * Screenshot
syntax match testCaseCall 'Set Screenshot Directory' contained
syntax match testCaseCall 'Take Screenshot\( Without Embedding\|\)' contained

highlight default link settingName          PreProc
highlight default link threeDotsImports     PreProc
highlight default link settingValue         Special
highlight default link settingParams        Statement

highlight default link path                 Constant
highlight default link and                  Identifier

highlight default link sections             Underlined

highlight default link variable             Type
highlight default link variableTestCase     Type
highlight default link variableName         Constant

highlight default link testCaseName         Special
highlight default link testCaseCall         Statement
highlight default link testCaseCallAfterVar Statement
highlight default link threeDotsTestCases   Type
highlight default link strings              Statement
