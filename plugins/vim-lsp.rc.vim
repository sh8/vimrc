if executable('pyls')
  call lsp#register_server({
      \ 'name': 'pyls',
      \ 'cmd': { server_info -> ['pyls'] },
      \ 'whitelist': ['python'],
      \ 'workspace_config': {'pyls': {'plugins': {
      \     'mccabe'              : { 'enabled': v:false },
      \     'preload'             : { 'enabled': v:false },
      \     'pycodestyle'         : { 'enabled': v:false },
      \     'pydocstyle'          : { 'enabled': v:false },
      \     'pyflakes'            : { 'enabled': v:false },
      \     'pylint'              : { 'enabled': v:false },
      \     'rope_completion'     : { 'enabled': v:false },
      \     'yapf'                : { 'enabled': v:false },
      \
      \     'jedi' : {'extra_paths' : [] },
      \     'jedi_completion'     : { 'enabled': v:true, 'include_params': v:true },
      \     'jedi_definition'     : { 'enabled': v:true, 'follow_imports': v:true, 'follow_builtin_imports': v:true },
      \     'jedi_hover'          : { 'enabled': v:true },
      \     'jedi_references'     : { 'enabled': v:true },
      \     'jedi_signature_help' : { 'enabled': v:true },
      \     'jedi_symbols'        : { 'enabled': v:true },
      \ }}},
      \ })
  autocmd FileType python setlocal omnifunc=lsp#complete
endif

if executable('typescript-language-server')
  au User lsp_setup call lsp#register_server({
      \ 'name': 'typescript-language-server',
      \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
      \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
      \ 'whitelist': ['typescript', 'javascript'],
      \ })
endif

if executable('cquery')
  au User lsp_setup call lsp#register_server({
      \ 'name': 'cquery',
      \ 'cmd': {server_info->['cquery']},
      \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
      \ 'initialization_options': { 'cacheDirectory': '/tmp/cquery/cache' },
      \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
      \ })
endif

if executable('go-langserver')
  au User lsp_setup call lsp#register_server({
      \ 'name': 'go-langserver',
      \ 'cmd': {server_info->['go-langserver', '-gocodecompletion']},
      \ 'whitelist': ['go'],
      \ })
endif
