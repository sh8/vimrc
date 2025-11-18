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
let g:coc_node_path='/home/shuniwase/.nvm/versions/node/v24.11.1/bin/node'

autocmd FileType python let b:coc_root_patterns = ['.git', '.env', 'venv', '.venv', 'setup.cfg', 'setup.py', 'pyproject.toml', 'pyrightconfig.json']

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" #649: Some LSPs have issues with backup files
set nobackup
