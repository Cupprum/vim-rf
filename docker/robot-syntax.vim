" Vim syntax file
" Language: Robot Framework
" Maintainer: Samuel Braniša
" Latest Revision: 22 October 2020

if exists("b:current_syntax")
  finish
endif

syn keyword settings Library Resource

hi def link settings        PreProc
