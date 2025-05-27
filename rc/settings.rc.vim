" Basic settings {{{
if has('persistent_undo')
  set undodir=~/.vim/undo
  set undofile
  set undolevels=1000
endif

" Encode
set encoding=UTF-8
set shortmess+=c
set termguicolors

" Set statusline
set laststatus=2

" Display line number
set nu

" Highlight a matching opening or closing parenthesis, square bracket or a curly brace
set showmatch

" Display ruler
set ruler

" Enable incsearch
set incsearch

" Accessing the system clipboard
set clipboard=unnamed

" Avoid automatic indentation
autocmd InsertLeave *
      \ if &paste | set nopaste mouse=a | echo 'nopaste' | endif |
    \ if &l:diff | diffupdate | endif

" Switch on highlighting the last used search pattern
set hlsearch

" Fastest way to move buffer
nnoremap <silent><Left> :bp<CR>
nnoremap <silent><Right> :bn<CR>
nnoremap <silent><C-Space> :Bdelete<CR>

function! BufferDeleteExceptFiler()
  if (&filetype !=# 'defx')
    bd!
  endif
endfunction

" Display another buffer when current buffer isn't saved.
set hidden

" Do not create swap files
set noswapfile

" Set clipboard
" set clipboard+=unnamedplus

let loaded_netrwPlugin = 1

function! MyHighlights() abort
  " gui configuration
  hi CocPumSearch ctermfg=29 guifg=#00875f
  hi CocFloating ctermbg=233 guibg=#2f383e
  hi CocFloatBorder ctermfg=29 guifg=#00875f
endfunction

augroup MyColors
  autocmd!
  autocmd ColorScheme * call MyHighlights()
augroup END

" Colorscheme
colorscheme brogrammer

lua <<EOF
  require('render-markdown').setup({
    file_types = { "markdown", "Avante" },
  })
  require('avante').setup({
    claude = {
      endpoint = "https://api.anthropic.com",
      model = "claude-sonnet-4-20250514",
      temperature = 0,
      max_tokens = 4096,
    },
    windows = {
      width = 40,
    }
  })
EOF

" }}}

