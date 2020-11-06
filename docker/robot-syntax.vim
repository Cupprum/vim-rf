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
syn match argument '[[:alnum:][:punct:] ]\+' contained display
syn match settings nextgroup=argument skipwhite '^\.\.\.'
syn match settings nextgroup=argument skipwhite '^\(Library\|Resource\|Variables\|Documentation\|Metadata\)'
syn match settings nextgroup=argument skipwhite '^\(Force\|Default\) Tags'
syn match settings nextgroup=argument skipwhite '^Suite \(Setup\|Teardown\)'
syn match settings nextgroup=argument skipwhite '^\(Test\|Task\) \(Setup\|Teardown\|Template\|Timeout\)'

hi def link sections        PreProc
hi def link settings        Type
hi def link argument        Constant
