" Plugins{{{
let mapleader = "\<Space>"

set nocompatible
filetype off                  " required
 
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'tpope/vim-commentary'

" Plugin 'chriskempson/base16-vim'
" Plugin 'juanedi/predawn.vim'
Plugin 'w0ng/vim-hybrid'


" Plugin 'terryma/vim-expand-region'
" 	vmap v <Plug>(expand_region_expand)
" 	vmap <C-v> <Plug>(expand_region_shrink)

Plugin 'majutsushi/tagbar'
	nmap <leader>tt :TagbarToggle<CR>
	nmap <leader>to :TagbarOpenAutoClose<CR>
Plugin 'xolox/vim-easytags'
Plugin 'xolox/vim-misc'

" Plugin 'Shougo/vimproc.vim'
" Plugin 'Shougo/unite.vim'

Plugin 'rking/ag.vim'
Plugin 'ctrlpvim/ctrlp.vim'
  	let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:30,results:30'
	nnoremap <Leader>o :CtrlP<CR>
	nnoremap <Leader>p :CtrlPBuffer<CR>

Plugin 'Valloric/YouCompleteMe'
	let g:ycm_autoclose_preview_window_after_insertion = 1
	let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py' " you complete me conf
	let g:ycm_show_diagnostics_ui = 0
	" if !exists("g:UltiSnipsJumpForwardTrigger")
	"   let g:UltiSnipsJumpForwardTrigger = "<tab>"
	" endif

	" if !exists("g:UltiSnipsJumpBackwardTrigger")
	"   let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
	" endif

	" au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger     . " <C-R>=g:UltiSnips_Complete()<cr>"
	" au InsertEnter * exec "inoremap <silent> " .     g:UltiSnipsJumpBackwardTrigger . " <C-R>=g:UltiSnips_Reverse()<cr>"

Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
	let g:UltiSnipsExpandTrigger="<c-l>"
	let g:UltiSnipsJumpForwardTrigger="<c-j>"
	let g:UltiSnipsJumpBackwardTrigger="<c-k>"

Plugin 'xolox/vim-notes'
	let g:notes_directories = ['~/Dropbox/notes']
	let g:notes_shadowdir = '~/Dropbox/notes/shadow'
Plugin 'vimwiki/vimwiki'
	let g:vimwiki_list = [{
	  \ 'path': '$HOME/Dropbox/wiki',
	  \ 'template_path': '$HOME/Dropbox/wiki/templates',
	  \ 'template_default': 'default',
	  \ 'template_ext': '.html',
	  \ 'auto_export': 1,
	  \ 'nested_syntaxes' : {'python': 'python', 'c++': 'cpp'} }]
call vundle#end()            " required
filetype plugin indent on    " required
"}}}
" {{{ Ag
" The Silver Searcher
if executable('ag')
	" Use ag over grep
	set grepprg=ag\ --nogroup\ --nocolor\ --ignore-case\ --column
	set grepformat=%f:%l:%c:%m,%f:%l:%m

	" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
	let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

	" ag is fast enough that CtrlP doesn't need to cache
	"let g:ctrlp_use_caching = 0
endif
" }}}
" Line Wrap {{{

" Soft wraps lines without editing file
set wrap

" Stops words from being cut off during linebreak
set linebreak

" Set textwidth to 80 characters
"set textwidth=80

" }}}
" Searching{{{

 "highlight search
set hlsearch
" Show search results as you type
set incsearch
" Ignore case in searches if query doesn't include capitals
set ignorecase
set smartcase

" search replace cs
vnoremap <silent> s //e<C-r>=&selection=='exclusive'?'+1':''<CR><CR>
    \:<C-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<CR>gv
omap s :normal vs<CR>

" This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR> 

" }}}
" Appearance {{{

syntax on
set background=dark
colorscheme noctu2

set number
set relativenumber

set laststatus=2

"folding settings
set foldmethod=syntax
set foldnestmax=1
"set foldlevel=99
set foldtext=NeatFoldText()

nnoremap <Leader><Leader> za
vnoremap <Leader><Leader> za

" }}}
" Indent options{{{

set ts=4 sts=4 sw=4 noexpandtab

set list lcs=tab:\ \ ,extends:›,precedes:‹,nbsp:·,trail:·

" }}}
" Movement {{{
set mouse=a
inoremap kj <ESC>
set ttimeoutlen=0

" Movement in long lines
nnoremap <silent> j gj
nnoremap <silent> k gk

" scrolling
" cursor position stays the same
"set nostartofline
set so=999
nnoremap <C-U> 4k
nnoremap <C-D> 4j

" " Paragraph jumping not on empty lines
" nnoremap <expr> { len(getline(line('.')-1)) > 0 ? '{+' : '{-'
" nnoremap <expr> } len(getline(line('.')+1)) > 0 ? '}-' : '}+'

" }}}
" Mappings {{{
nnoremap <Space> <NOP>

nnoremap <leader>r :<C-U>RangerChooser<CR>

" Split moving
nnoremap <C-h> <C-w>h
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"Quickly paste from +reg
nnoremap <Leader>v "+p
vnoremap <Leader>v "+p

" avoid ex mode
nmap Q q

"easy yank to end of line
nnoremap Y y$
" }}}
" Filetupe {{{

" Disable comment new line
au FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

au FileType c		setlocal commentstring=//\ %s
au FileType cpp		setlocal commentstring=//\ %s
au FileType python	setlocal formatprg=autopep8\ -
au Filetype python	vnoremap <buffer> gq gq:%retab!<CR>
au FileType python	setlocal tabstop=4 noexpandtab fdm=indent
" }}}
" Buffers  {{{

set hidden
nnoremap <tab> <c-^>
nnoremap <c-j> :bp<CR> 
nnoremap <c-k> :bn<CR> 

" }}}
" gui {{{ 
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
set guiheadroom=0
set guicursor+=a:blinkon0
if has("gui_running")
  colorscheme hybrid
endif
" Fix borders of fullscreen GUI
if has('gui_gtk') && has('gui_running')
  let s:border = synIDattr(synIDtrans(hlID('Normal')), 'bg', 'gui')
  exe 'silent !echo ''style "vimfix" { bg[NORMAL] = "' . escape(s:border, '#') . '" }'''.
			  \' > ~/.gtkrc-2.0'
  exe 'silent !echo ''widget "vim-main-window.*GtkForm" style "vimfix"'''.
			  \' >> ~/.gtkrc-2.0'
endif
" }}}
" Misc {{{

set wildmenu 
set encoding=utf-8 " set default encoding
"language en_US
set tags=./tags;,tags;

" }}}
"  Backup {{{
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
" set undodir=~/.vim/undo//
" set undofile
"}}}
" Functions{{{
function! NeatFoldText()
  let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
  let lines_count = v:foldend - v:foldstart + 1
  let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
  let foldchar = matchstr(&fillchars, 'fold:\zs.')
  let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
  let foldtextend = lines_count_text . repeat(foldchar, 8)
  let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
  return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction

function! MyFoldText()
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction



function! g:UltiSnips_Complete()
  call UltiSnips#ExpandSnippet()
  if g:ulti_expand_res == 0
    if pumvisible()
      return "\<C-n>"
    else
      call UltiSnips#JumpForwards()
      if g:ulti_jump_forwards_res == 0
        return "\<TAB>"
      endif
    endif
  endif
  return ""
endfunction

function! g:UltiSnips_Reverse()
  call UltiSnips#JumpBackwards()
  if g:ulti_jump_backwards_res == 0
    return "\<C-P>"
  endif

  return ""
endfunction

function! RangeChooser()
    let temp = tempname()
    " The option "--choosefiles" was added in ranger 1.5.1. Use the next line
    " with ranger 1.4.2 through 1.5.0 instead.
    "exec 'silent !ranger --choosefile=' . shellescape(temp)
    if has("gui_running")
        exec 'silent !xterm -e ranger --choosefiles=' . shellescape(temp)
    else
        exec 'silent !ranger --choosefiles=' . shellescape(temp)
    endif
    if !filereadable(temp)
        redraw!
        " Nothing to read.
        return
    endif
    let names = readfile(temp)
    if empty(names)
        redraw!
        " Nothing to open.
        return
    endif
    " Edit the first item.
    exec 'edit ' . fnameescape(names[0])
    " Add any remaning items to the arg list/buffer list.
    for name in names[1:]
        exec 'argadd ' . fnameescape(name)
    endfor
    redraw!
endfunction
command! -bar RangerChooser call RangeChooser()
" vim: fdm=marker:fdl=0
" }}}
