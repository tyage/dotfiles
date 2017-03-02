source $HOME/.homesick/repos/dotfiles/vendor/mathiasbynens-dotfiles/.vimrc

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = expand('~/.homesick/repos/dotfiles/vendor/dein.vim')
execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')

" Required:
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " Let dein manage dein
  " Required:
  call dein#add(s:dein_repo_dir)

  " Add or remove your plugins here:
  call dein#add('Shougo/deoplete.nvim')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install(['Shougo/deoplete.nvim'])
  call dein#install(['Shougo/deoplete.nvim'])
endif

"End dein Scripts-------------------------

let g:deoplete#enable_at_startup = 1
