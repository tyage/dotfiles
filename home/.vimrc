source $HOME/.homesick/repos/dotfiles/vendor/mathiasbynens-dotfiles/.vimrc

"dein Scripts-----------------------------
if &compatible
  set nocompatible
endif

" Required:
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = expand('~/.homesick/repos/dotfiles/vendor/dein.vim')
execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')

" Required:
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let g:rc_dir = expand('~/.vim/rc')
  call dein#load_toml(g:rc_dir . '/dein.toml', {'lazy': 0})
  call dein#load_toml(g:rc_dir . '/dein_lazy.toml', {'lazy': 1})
  if has('nvim')
    call dein#load_toml(g:rc_dir . '/dein_neo.toml', {})
  endif

  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

if !has('vim_starting') && dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------
