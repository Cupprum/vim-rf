" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Vim will load $VIMRUNTIME/defaults.vim if the user does not have a vimrc.
" This happens after /etc/vim/vimrc(.local) are loaded, so it will override
" any settings in these files.
" If you don't want that to happen, uncomment the below line to prevent
" defaults.vim from being loaded.
" let g:skip_defaults_vim = 1

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
"syntax on

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
"filetype plugin indent on

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
"set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden		" Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

" Turn on syntax highlighting inside of Vim
syntax on
" Allow filetype plugins
filetype plugin on

" Ale configuration for robot framework
let g:ale_completion_enabled = 1
let g:ale_completion_delay = 0
let g:ale_hover_to_preview = 1
let b:ale_linters = ['rflint']

" Tagbar configuration in order to work with robot framework
let g:tagbar_type_robot= {
    \ 'ctagstype' : 'robot',
    \ 'kinds'     : [
        \'t:testcases',
        \'k:keywords',
        \'v:variables'
  \]
\}

" Set Leader key to `
let mapleader = "`"

" Map control slash to Comment Lines
nnoremap <C-_> :RFCommentLine<CR>
vnoremap <C-_> :RFCommentLine<CR>

" Map control question mark to Uncomment Lines
nnoremap <C-?> :RFUncommentLine<CR>
vnoremap <C-?> :RFUncommentLine<CR>

" Map <Leader> t to testing single Test Case
nnoremap <leader>t :RFTestCase<CR>
nnoremap <leader>T :RFTestCase -l<CR>

" Map <Leader> f to testing all Test Cases in current file
nnoremap <leader>f :RFTestFile<CR>
nnoremap <leader>F :RFTestFile -l<CR>

" Map <Leader> d to testing all Test Cases in current Test Suite
nnoremap <leader>D :RFTestDir<CR>
nnoremap <leader>D :RFTestDir -l<CR>
