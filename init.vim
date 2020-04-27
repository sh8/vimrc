" vimrc

" Only for nvim
if !has('nvim')
  set ttymouse=xterm2
endif

" Flags {{{
let s:use_dein = 1
" }}}

source ~/.config/nvim/rc/filetype.vim
source ~/.config/nvim/rc/indent.vim

if has('persistent_undo')
  set undodir=~/.vim/undo
  set undofile
  set undolevels=1000
endif

" Encode
set encoding=UTF-8
set completeopt-=preview
set shortmess+=c

" Dein {{{
let s:vimdir = $HOME . '/.vim'
let s:dein_dir = s:vimdir . '/dein'
let s:dein_github = s:dein_dir . '/repos/github.com'
let s:dein_repo_name = 'Shougo/dein.vim'
let s:dein_repo_dir = s:dein_github . '/' . s:dein_repo_name
let s:rsense_dir = $HOME . '/.rbenv/shims/rsense'
let s:dein_toml = '~/.config/nvim/plugins/dein.toml'
let s:dein_lazy_toml = '~/.config/nvim/plugins/dein_lazy.toml'

"  Install dein automatically
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif

if &compatible
  set nocompatible
endif

let &runtimepath = &runtimepath . ',' . s:dein_repo_dir

" Set augroup.
augroup MyAutoCmd
  autocmd!
  autocmd FileType,Syntax,BufNewFile,BufNew,BufRead *?
        \ call vimrc#on_filetype()
augroup END

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  call dein#load_toml(s:dein_toml, {'lazy': 0})
  call dein#load_toml(s:dein_lazy_toml, {'lazy': 1})

  " Linter
  " call dein#add('w0rp/ale')
  "
  " " Syntax highlight
  " call dein#add('numirias/semshi')
  " call dein#add('editorconfig/editorconfig-vim')

  " Statusline
  call dein#add('ryanoasis/vim-devicons')
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')

  " Git
  call dein#add('airblade/vim-gitgutter')
  call dein#add('tpope/vim-fugitive')

  " Util
  call dein#add('tomtom/tcomment_vim')
  call dein#add('vim-scripts/YankRing.vim')
  call dein#add('rhysd/accelerated-jk')
  " call dein#add('thinca/vim-quickrun')
  " call dein#add('wlangstroth/vim-racket')
  " call dein#add('godlygeek/tabular')
  " call dein#add('iamcco/markdown-preview.nvim', {'on_ft': ['markdown', 'pandoc.markdown', 'rmd'],
	" 				\ 'build': 'cd app & npm install' })

  " Colorization
  call dein#add('vim-scripts/AnsiEsc.vim')
  call dein#add('chrisbra/Colorizer')

  " Colorscheme
  call dein#add('sff1019/vim-brogrammer-theme')

  " FZF
  call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 })
  call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })

  " LATEX
  call dein#add('lervag/vimtex')

  call dein#end()
  call dein#save_state()
endif
" }}}

" accelerated-jk
if dein#tap('accelerated-jk')
  nmap j <Plug>(accelerated_jk_gj)
  nmap k <Plug>(accelerated_jk_gk)
endif

" ale
if dein#tap('ale')
  let g:ale_completion_enabled = 1
  let g:ale_swift_swiftlint_executable = 'swiftlint'
  let g:ale_swift_swiftlint_options = ''

  let g:ale_linters = {
        \   'javascript': ['eslint'],
        \   'python': ['flake8'],
        \   'cpp': ['g++'],
        \   'go': ['gofmt'],
        \   'swift': ['swiftlint'],
        \}
  let g:ale_fixers = {
        \   'javascript': ['eslint'],
        \   'python': ['autopep8'],
        \   'go': ['gofmt'],
        \}
  let g:ale_fix_on_save = 1
endif

" calendar
if dein#tap('calendar.vim')
  let g:extra_whitespace_ignored_filetypes = ['unite', 'mkd', 'calendar']
endif

" Colorizer
if dein#tap('Colorizer')
  autocmd BufNewFile,BufRead *.css,*.scss,*.html,*.htm  :ColorHighlight!
endif

" fzf.vim
if dein#tap('fzf.vim')
  command! -bang -nargs=* Rg
        \ call fzf#vim#grep(
        \   'rg -g "!node_modules/*" --column --line-number  --no-heading --color=always '.shellescape(<q-args>), 0,
        \   fzf#vim#with_preview(
        \      {'options': '--exact --delimiter : --nth 3.. --preview "rougify {2..-1} | head -'.&lines.'"'}, 'right:50%'))
  nnoremap <silent> <C-t> :call Fzf_dev()<CR>
  nnoremap ,g :Rg<CR>

  function! Fzf_dev()
    let l:fzf_files_options = '--preview "rougify {2..-1} | head -'.&lines.'"'

    function! s:files()
      let l:files = split(system($FZF_DEFAULT_COMMAND), '\n')
      return s:prepend_icon(l:files)
    endfunction

    function! s:prepend_icon(candidates)
      let l:result = []
      for l:candidate in a:candidates
        let l:filename = fnamemodify(l:candidate, ':p:t')
        let l:icon = WebDevIconsGetFileTypeSymbol(l:filename, isdirectory(l:filename))
        call add(l:result, printf('%s %s', l:icon, l:candidate))
      endfor

      return l:result
    endfunction

    function! s:edit_file(item)
      let l:pos = stridx(a:item, ' ')
      let l:file_path = a:item[pos+1:-1]
      execute 'silent e' l:file_path
    endfunction

    call fzf#run({
          \ 'source': <sid>files(),
          \ 'sink':   function('s:edit_file'),
          \ 'options': '-m ' . l:fzf_files_options,
          \ 'down':    '40%' })
  endfunction
endif

" previm
if dein#tap('previm')
  let g:previm_open_cmd = 'open -a Google\ Chrome'
endif

" quickrun
if dein#tap('quickrun')
  let g:quickrun_config = {}
endif

"tsuquyomi
if dein#tap('tsuquyomi')
  autocmd InsertLeave,TextChanged,BufWritePost *.ts,*.tsx call tsuquyomi#asyncGeterr()
  let g:tsuquyomi_use_vimproc = 0
  let g:tsuquyomi_disable_quickfix = 1
endif

" vim-airline
if dein#tap('vim-airline')
  " let g:airline_theme='murmur'
  let g:airline#extensions#tabline#enabled = 1
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#tabline#fnamemod = ':t'
  let g:airline#extensions#tabline#left_sep = '  '
  let g:airline#extensions#tabline#left_alt_sep = ' '
  let g:airline_left_sep = ' '
  let g:airline_right_sep = ' '
endif

" vim-markdown
if dein#tap('vim-markdown')
  let g:vim_markdown_folding_disabled = 1
endif

if dein#tap('vimtex')
  let g:vimtex_latexmk_enabled = 1
  let g:vimtex_quickfix_latexlog = {'default' : 0}
  let g:vimtex_quickfix_autoclose_after_keystrokes = 1
  let g:tex_flavor='platex'
  let g:vimtex_compiler_latexmk_engines = { '_' : '-pdfdvi' }
  let g:vimtex_compiler_latexmk = {
        \ 'backend': 'nvim',
        \ 'background' : 0,
        \ 'build_dir' : '',
        \ 'continuous' : 1,
        \ 'options' : [
        \   '-pdfdvi',
        \   '-verbose',
        \   '-file-line-error',
        \   '-synctex=1',
        \   '-interaction=nonstopmode',
        \ ],
        \}
  let g:tex_conceal = ''
  let g:vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
  let g:vimtex_view_general_options = '@line @pdf @tex'
endif

" vim-trailing-whitespace
if dein#tap('vim-trailing-whitespace')
  " Delete whitespace automatically when current file is saved
  autocmd BufWritePre *  call s:StripTrailingWhitespace()
  fun! s:StripTrailingWhitespace()
    " Only strip if the b:noStripeWhitespace variable isn't set
    if exists('b:noStripWhitespace')
      return
    endif
    :FixWhitespace
  endfun
endif

if dein#tap('vim-scripts/YankRing.vim')
  let g:yankring_clipboard_monitor=0
endif

" }}}

" Basic settings {{{

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
nnoremap <silent><C-Space> :call BufferDeleteExceptFiler()<CR>

function! BufferDeleteExceptFiler()
  if (&filetype !=# 'defx')
    bd!
  endif
endfunction

if !has('gui_running')
  augroup term_vim_c_space
    autocmd!
    autocmd VimEnter * map <Nul> <C-Space>
    autocmd VimEnter * map! <Nul> <C-Space>
  augroup END
endif

" Display another buffer when current buffer isn't saved.
set hidden

" Do not create swap files
set noswapfile

" Set clipboard
set clipboard+=unnamedplus

" Colorscheme
colorscheme brogrammer

" gui configuration
hi Visual cterm=reverse
hi Search cterm=reverse ctermfg=yellow
hi VertSplit ctermbg=NONE guibg=NONE

" }}}

" Check whether plugins should be installed or not
if has('vim_starting') && dein#check_install()
  call dein#install()
endif
