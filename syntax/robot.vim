" Purpose: Vim syntax file for Robot Framework
" Last Change: 7 May 2021
" Maintainer: Samuel Braniša
" Language: Robot Framework
" License: This file is placed in the public domain.

if exists("b:current_syntax")
  finish
endif

syntax sync minlines=100

syntax region robotComment start='#' end='$' oneline
syntax match robotVariableName '\([[:alnum:]_] \{0,1}\)\+' contained
syntax region robotVariable start='\(\$\|%\|@\|&\){' end='}\(=\|\)' contains=robotVariableName,robotComment oneline
syntax match robotPath '\(\.\|\)/[[:punct:][:alnum:][:punct:]]\+' contained

" Sections
syntax match robotSections '^\*\*\*[[:alpha:][:blank:]]\+\*\*\*'

" Settings
syntax keyword robotAnd AND contained nextgroup=robotBlank
syntax match robotBlank '[[:blank:]]\+' contained nextgroup=robotAnd,robotPath,robotSettingValue

syntax match robotThreeDotsImports '^\.\.\.' contained nextgroup=robotBlank

syntax match robotSettingName '^\([[:alnum:]] \{0,1}\)\+' contained nextgroup=robotBlank
syntax match robotSettingValue '\([[:alnum:]]\( \|_\|-\|\.\|\)\)\+' contained nextgroup=robotSettingParams
syntax match robotSettingParams '.\+$' contained

syntax region robotImportsBorders start='^\*\*\* Settings \*\*\*' end='\(^\*\*\*\)\@=' 
    \ contains=robotSettingName,robotSections,robotThreeDotsImports,robotComment keepend

syntax match robotSettingName '^\(Library\|Resource\|Variables\|Documentation\|Metadata\)' nextgroup=robotBlank
syntax match robotSettingName '^\(Force\|Default\) Tags' nextgroup=robotBlank
syntax match robotSettingName '^Suite \(Setup\|Teardown\)' nextgroup=robotBlank
syntax match robotSettingName '^\(Test\|Task\) \(Setup\|Teardown\|Template\|Timeout\)' nextgroup=robotBlank

" Test Cases and Keywords
syntax match robotStrings '\".\+\"'
syntax match robotThreeDotsTestCases '\.\.\.' contained
syntax match robotTestCaseName '^\([[:alnum:]_] \{0,1}\)\+' contained
syntax match robotTestCaseCall '^[[:blank:]]\+\([[:alnum:]] \{0,1}\)\+' contained
syntax match robotTestCaseCallAfterVar '[[:blank:]]\+\([[:alnum:]] \{0,1}\)\+' contained
syntax match robotArguments '\[Arguments\]' contained
syntax region robotVariableTestCase start='^[[:blank:]]\+\(\$\|%\|@\|&\){' end='}\(=\|\)' contains=robotVariableName,robotComment oneline nextgroup=robotTestCaseCallAfterVar

syntax region robotTestCaseBorders start='^\*\*\* \(Test Cases\|Keywords\) \*\*\*' end='\%$'
    \ contains=robotTestCaseName,robotTestCaseCall,robotSections,robotVariableTestCase,robotVariable,robotThreeDotsTestCases,robotStrings,robotComment,robotArguments

" --- Normal Standart Libraries
" * BuiltIn
syntax match robotTestCaseCall 'Call Method\|Catenate\|Comment' contained
syntax match robotTestCaseCall 'Continue For Loop\( If\|\)' contained
syntax match robotTestCaseCall 'Convert To \(Binary\|Boolean\|Bytes\|Hex\|Integer\|Number\|Octal\|String\)' contained
syntax match robotTestCaseCall 'Create \(Dictionary\|List\)' contained
syntax match robotTestCaseCall 'Evaluate' contained
syntax match robotTestCaseCall 'Exit For Loop\( If\|\)' contained
syntax match robotTestCaseCall 'Fail\|Fatal Error' contained
syntax match robotTestCaseCall 'Get \(Count\|Length\|Library Instance\|Time\|Variable Value\|Variables\)' contained
syntax match robotTestCaseCall 'Import \(Library\|Resource\|Variables\)' contained
syntax match robotTestCaseCall 'Keyword Should Exist\|Length Should Be' contained
syntax match robotTestCaseCall 'Log\( Many\| To Console\| Variables\|\)' contained
syntax match robotTestCaseCall 'No Operation' contained
syntax match robotTestCaseCall 'Pass Execution\( If\|\)' contained
syntax match robotTestCaseCall 'Regexp Escape\|Reload Library\|Remove Tags\|Repeat Keyword\|Replace Variables' contained
syntax match robotTestCaseCall 'Return From Keyword\( If\|\)' contained
syntax match robotTestCaseCall 'Run Keyword And Return\( If\| Status\|\)' contained
syntax match robotTestCaseCall 'Run Keyword And \(Continue On Failure\|Expect Error\|Ignore Error\)' contained
syntax match robotTestCaseCall 'Run Keyword If All \(Critical Tests Passed\|Tests Passed\)' contained
syntax match robotTestCaseCall 'Run Keyword If Any \(Critical Tests Failed\|Tests Failed\)' contained
syntax match robotTestCaseCall 'Run Keyword If Test \(Failed\|Passed\|\)' contained
syntax match robotTestCaseCall 'Run Keyword If\( Timeout Occurred\|\)' contained
syntax match robotTestCaseCall 'Run Keyword\( Unless\|s\|\)' contained
syntax match robotTestCaseCall 'Run Keyword\( And \(Return\( If\| Status\|\)\|Continue On Failure\|Expect Error\|Ignore Error\)\| If\( All \(Critical Tests Passed\|Tests Passed\)\| Any \(Critical Tests Failed\|Tests Failed\)\| Test \(Failed\|Passed\)\| Timeout Occurred\|\)\| Unless\|s\|\)' contained
syntax match robotTestCaseCall 'Set \(Global Variable\|Library Search Order\|Local Variable\|Log Level\)' contained
syntax match robotTestCaseCall 'Set Suite \(Documentation\|Metadata\|Variable\)' contained
syntax match robotTestCaseCall 'Set \(Tags\|Task Variable\)' contained
syntax match robotTestCaseCall 'Set Test \(Documentation\|Message\|Variable\)' contained
syntax match robotTestCaseCall 'Set Variable\( If\|\)' contained
syntax match robotTestCaseCall '\(Should Be Equal As \(Integers\|Numbers\|Strings\)\|Should Be \(Empty\|Equal\|True\)\)' contained
syntax match robotTestCaseCall 'Should Contain\( Any\| X Times\|\)' contained
syntax match robotTestCaseCall 'Should \(Not Start\|Not End\|Start\|End\) With' contained
syntax match robotTestCaseCall 'Should Match\( Regexp\|\)' contained
syntax match robotTestCaseCall '\(Should Not Be Equal As \(Integers\|Numbers\|Strings\)\|Should Not Be \(Empty\|Equal\|True\)\)' contained
syntax match robotTestCaseCall 'Should Not Contain\( Any\|\)' contained
syntax match robotTestCaseCall 'Should Not Match\( Regexp\|\)' contained
syntax match robotTestCaseCall 'Sleep' contained
syntax match robotTestCaseCall 'Variable Should \(Not \|\)Exist' contained
syntax match robotTestCaseCall 'Wait Until Keyword Succeeds' contained

" * Collections
syntax match robotTestCaseCall 'Append To List\|Combine Lists' contained
syntax match robotTestCaseCall '\(Convert To\|Copy\) \(Dictionary\|List\)' contained
syntax match robotTestCaseCall 'Count Values In List\|Dictionaries Should Be Equal' contained
syntax match robotTestCaseCall 'Dictionary Should \(Contain \(Item\|Key\|Sub Dictionary\|Value\)\|Not Contain \(Key\|Value\)\)' contained
syntax match robotTestCaseCall 'Get \(Dictionary \(Items\|Keys\|Values\)\|From \(Dictionary\|List\)\|Index From List\|Match Count\|Matches\|Slice From List\)' contained
syntax match robotTestCaseCall 'Insert Into List\|Keep In Dictionary' contained
syntax match robotTestCaseCall 'List Should \(Contain \(Sub List\|Value\)\|Not Contain \(Duplicates\|Value\)\)' contained
syntax match robotTestCaseCall 'Lists Should Be Equal' contained
syntax match robotTestCaseCall 'Log \(Dictionary\|List\)' contained
syntax match robotTestCaseCall 'Pop From Dictionary' contained
syntax match robotTestCaseCall 'Remove \(Duplicates\|From \(Dictionary\|List\)\|Values From List\)' contained
syntax match robotTestCaseCall 'Reverse List' contained
syntax match robotTestCaseCall 'Set \(List Value\|To Dictionary\)' contained
syntax match robotTestCaseCall 'Should \(Not \|\)Contain Match' contained
syntax match robotTestCaseCall 'Sort List' contained

" * DateTime
syntax match robotTestCaseCall 'Add Time To \(Date\|Time\)' contained
syntax match robotTestCaseCall 'Convert \(Date\|Time\)' contained
syntax match robotTestCaseCall 'Get Current Date' contained
syntax match robotTestCaseCall 'Subtract \(Date From Date\|Time From \(Date\|Time\)\)' contained

" * Dialogs
syntax match robotTestCaseCall 'Execute Manual Step' contained
syntax match robotTestCaseCall 'Get \(Selection\|Selections\|Value\) From User' contained
syntax match robotTestCaseCall 'Pause Execution' contained

" * OperatingSystem
syntax match robotTestCaseCall 'Append To \(Environment Variable\|File\)' contained
syntax match robotTestCaseCall 'Copy \(Directory\|Files\|File\)' contained
syntax match robotTestCaseCall 'Count \(Directories\|Files\|Items\) In Directory' contained
syntax match robotTestCaseCall 'Create \(Binary File\|Directory\|File\)' contained
syntax match robotTestCaseCall 'Directory Should \(Not \|\)\(Be Empty\|Exist\)' contained
syntax match robotTestCaseCall 'Empty Directory' contained
syntax match robotTestCaseCall 'Environment Variable Should \(Not \|\)Be Set' contained
syntax match robotTestCaseCall 'File Should \(Not \|\)\(Be Empty\|Exist\)' contained
syntax match robotTestCaseCall 'Get Binary File' contained
syntax match robotTestCaseCall 'Get Environment \(Variables\|Variable\)' contained
syntax match robotTestCaseCall 'Get \(File Size\|File\|Modified Time\)' contained
syntax match robotTestCaseCall 'Grep File' contained
syntax match robotTestCaseCall 'Join \(Paths\|Path\)' contained
syntax match robotTestCaseCall 'List \(Directories In Directory\|Directory\|Files In Directory\)' contained
syntax match robotTestCaseCall 'Log \(Environment Variables\|File\)' contained
syntax match robotTestCaseCall 'Move \(Directory\|Files\|File\)' contained
syntax match robotTestCaseCall 'Normalize Path' contained
syntax match robotTestCaseCall 'Remove \(Directory\|Environment Variable\|Files\|File\)' contained
syntax match robotTestCaseCall 'Run\( And Return Rc\( And Output\|\)\|\)' contained
syntax match robotTestCaseCall 'Set \(Environment Variable\|Modified Time\)' contained
syntax match robotTestCaseCall 'Should \(Not \|\)Exist' contained
syntax match robotTestCaseCall 'Split \(Extension\|Path\)' contained
syntax match robotTestCaseCall 'Touch' contained
syntax match robotTestCaseCall 'Wait Until \(Created\|Removed\)' contained

" * Process contained
syntax match robotTestCaseCall 'Get Process \(Id\|Object\|Result\)' contained
syntax match robotTestCaseCall 'Is Process Running\|Join Command Line' contained
syntax match robotTestCaseCall 'Process Should Be \(Running\|Stopped\)' contained
syntax match robotTestCaseCall 'Run Process\|Send Signal To Process\|Split Command Line\|Start Process\|Switch Process' contained
syntax match robotTestCaseCall 'Terminate \(All Processes\|Process\)' contained
syntax match robotTestCaseCall 'Wait For Process' contained

" * Screenshot
syntax match robotTestCaseCall 'Set Screenshot Directory' contained
syntax match robotTestCaseCall 'Take Screenshot\( Without Embedding\|\)' contained

highlight default link robotComment              Comment

highlight default link robotSettingName          PreProc
highlight default link robotThreeDotsImports     PreProc
highlight default link robotSettingValue         Special
highlight default link robotSettingParams        Statement

highlight default link robotPath                 Constant
highlight default link robotAnd                  Identifier

highlight default link robotSections             Underlined

highlight default link robotVariable             Type
highlight default link robotVariableTestCase     Type
highlight default link robotVariableName         Constant

highlight default link robotTestCaseName         Special
highlight default link robotTestCaseCall         Statement
highlight default link robotTestCaseCallAfterVar Statement
highlight default link robotThreeDotsTestCases   Type
highlight default link robotStrings              Statement
highlight default link robotArguments            Identifier

let b:current_syntax = "robot"
