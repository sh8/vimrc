let g:python2_host_prog = $HOME . '/.pyenv/shims/python2'
let g:python3_host_prog = $HOME . '/.pyenv/shims/python3'

call deoplete#custom#option('ignore_sources', {
      \ '_': ['buffer'],
      \ })

" <TAB>: completion.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ deoplete#manual_complete()
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~? '\s'
endfunction

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
  return pumvisible() ? deoplete#close_popup()."\<CR>" : "\<CR>"
endfunction

" autocmd MyAutoCmd BufEnter * call s:tabnine_check()
" function! s:tabnine_check() abort
"   if finddir('.git') !=# ''
"     return
"   endif
"   " Disable tabnine source
"   call deoplete#custom#buffer_option('ignore_sources', ['tabnine'])
" endfunction

call deoplete#custom#option({
      \ 'auto_refresh_delay': 10,
      \ 'camel_case': v:true,
      \ 'skip_multibyte': v:true,
      \ 'auto_preview': v:true,
      \ })
call deoplete#custom#option('num_processes', 1)

" call s:tabnine_check()
