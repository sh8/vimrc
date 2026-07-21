let g:coc_global_extensions = [
      \ 'coc-clangd',
      \ '@yaegassy/coc-ruff',
      \ 'coc-basedpyright',
      \ 'coc-toml',
      \ 'coc-yaml',
      \ 'coc-gitignore',
      \ 'coc-yank',
      \ 'coc-highlight',
      \ 'coc-git',
      \ 'coc-json',
      \]

let g:coc_status_error_sign = '•'
let g:coc_status_warning_sign = '•'
" Point coc at the nvm 'default' node (created by dotfiles/install.sh) so it
" works on both macOS and Linux; fall back to PATH lookup if it's absent.
let s:coc_node = expand('~/.nvm/default/bin/node')
if executable(s:coc_node)
  let g:coc_node_path = s:coc_node
endif

autocmd FileType python let b:coc_root_patterns = ['.git', '.env', 'venv', '.venv', 'setup.cfg', 'setup.py', 'pyproject.toml', 'pyrightconfig.json']

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gf <Plug>(coc-codeaction-cursor)

" #649: Some LSPs have issues with backup files
set nobackup
