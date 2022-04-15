let g:vimtex_compiler_progname = 'nvr'
" let g:vimtex_latexmk_enabled = 1
" let g:vimtex_quickfix_latexlog = {'default' : 0}
let g:vimtex_quickfix_autoclose_after_keystrokes = 1
let g:tex_flavor='pdflatex'
let g:vimtex_compiler_latexmk_engines = { '_' : '-pdfdvi' }
let g:vimtex_quickfix_open_on_warning = 0
let g:vimtex_compiler_latexmk = {
      \ 'backend': 'nvim',
      \ 'background' : 0,
      \ 'build_dir' : '',
      \ 'continuous' : 1,
      \ 'options' : [
      \   '-pdfdvi',
      \   '-verbose',
      \   '-file-line-error',
      \   '-shell-escape',
      \   '-synctex=1',
      \   '-interaction=nonstopmode',
      \ ],
      \}

let g:tex_conceal = ''
let g:vimtex_view_method = 'zathura'
let g:vimtex_syntax_conceal_disable=1
" let g:vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
" let g:vimtex_view_general_options = '@line @pdf @tex'
