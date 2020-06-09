" vimrc

if &compatible
  set nocompatible
endif

source ~/.config/nvim/rc/filetype.rc.vim
source ~/.config/nvim/rc/indent.rc.vim

" Dein {{{
let s:vimdir = $HOME . '/.vim'
let s:dein_dir = s:vimdir . '/dein'
let s:dein_github = s:dein_dir . '/repos/github.com'
let s:dein_repo_name = 'Shougo/dein.vim'
let s:dein_repo_dir = s:dein_github . '/' . s:dein_repo_name
let s:dein_toml = '~/.config/nvim/plugins/dein.toml'
let s:dein_lazy_toml = '~/.config/nvim/plugins/dein_lazy.toml'

"  Install dein automatically
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' .
   \ shellescape(s:dein_repo_dir))
endif

let &runtimepath = &runtimepath . ',' . s:dein_repo_dir

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  call dein#load_toml(s:dein_toml, {'lazy': 0})
  call dein#load_toml(s:dein_lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif
" }}}

source ~/.config/nvim/rc/settings.rc.vim

if has('vim_starting') && dein#check_install()
  call dein#install()
endif
