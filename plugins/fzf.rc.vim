command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg -g "!node_modules/*" --column --line-number  --no-heading --color=always '.shellescape(<q-args>), 0,
      \   fzf#vim#with_preview(
      \      {'options': '--exact --delimiter : --nth 3.. --preview "bat --color=always {} | head -'.&lines.'"'}, 'right:50%'))
nnoremap <silent> <C-t> :call Fzf_dev()<CR>
nnoremap ,g :Rg<CR>

function! Fzf_dev()
  let l:fzf_files_options = '--preview "bat -n --color=always {2..-1} | head -'.&lines.'"'

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
        \ 'window': { 'width': 0.9, 'height': 0.6, 'border': 'rounded' }})
endfunction
