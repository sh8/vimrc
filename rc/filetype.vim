" FileType {{{
au BufRead,BufNewFile,BufReadPre *.swift set filetype=swift
au BufNewFile,BufRead *.ts set filetype=typescript
au BufNewFile,BufRead *.tsx set filetype=typescript
au BufNewFile,BufRead *.toml set filetype=toml
"}}}

" Indentation settings {{{
au Filetype html setlocal ts=2 sts=2 sw=2
au Filetype ruby setlocal ts=2 sts=2 sw=2 et
au Filetype css setlocal ts=4 sw=4 sts=0
au FileType javascript setlocal ts=2 sw=2 et
" }}}
