
  " ┏━┓╺┳╸┏━┓╺┳╸╻ ╻┏━┓╻  ╻┏┓╻┏━╸
  " ┗━┓ ┃ ┣━┫ ┃ ┃ ┃┗━┓┃  ┃┃┗┫┣╸ 
  " ┗━┛ ╹ ╹ ╹ ╹ ┗━┛┗━┛┗━╸╹╹ ╹┗━╸
  " lightline http://git.io/lightline
  " █▓▒░ wizard status line
  set laststatus=2
  let g:lightline = {
    \ 'colorscheme': 'sourcerer',
    \ 'active': {
    \   'left': [ [ 'filename' ],
    \             [ 'readonly', 'fugitive' ] ],
    \   'right': [ [ 'percent', 'lineinfo' ],
    \              [ 'fileencoding', 'filetype' ],
    \              [ 'fileformat', 'syntastic' ] ]
    \ },
    \ 'component_function': {
    \   'modified': 'WizMod',
    \   'readonly': 'WizRO',
    \   'fugitive': 'WizGit',
    \   'filename': 'WizName',
    \   'filetype': 'WizType',
    \   'fileformat' : 'WizFormat',
    \   'fileencoding': 'WizEncoding',
    \   'mode': 'WizMode',
    \ },
    \ 'component_expand': {
    \   'syntastic': 'SyntasticStatuslineFlag',
    \ },
    \ 'component_type': {
    \   'syntastic': 'error',
    \ },
    \ 'separator': { 'left': '▓▒░', 'right': '░▒▓' },
    \ 'subseparator': { 'left': '▒', 'right': '░' }
    \ }

  function! WizMod()
    return &ft =~ 'help\|vimfiler' ? '' : &modified ? '»' : &modifiable ? '' : ''
  endfunction

  function! WizRO()
    return &ft !~? 'help\|vimfiler' && &readonly ? 'x' : ''
  endfunction

  function! WizGit()
    if &ft !~? 'help\|vimfiler' && exists("*fugitive#head")
      return fugitive#head()
    endif
    return ''
  endfunction

  function! WizName()
    return ('' != WizMod() ? WizMod() . ' ' : '') .
          \ ('' != expand('%:t') ? expand('%:t') : '[none]') 
  endfunction

  function! WizType()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : '') : ''
  endfunction

  function! WizFormat()
    return ''
  endfunction

  function! WizEncoding()
    return winwidth(0) > 70 ? (strlen(&fenc) ? &enc : &enc) : ''
  endfunction
