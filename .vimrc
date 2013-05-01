set nocompatible

if has('win32') || has('win64')
  source $VIMRUNTIME/mswin.vim
  set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif

" Setup Bundle Support {
" The next three lines ensure that the ~/.vim/bundle/ system works
  filetype on
  filetype off
  set rtp+=~/.vim/bundle/vundle
  call vundle#rc()
" }

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

" My Bundles here:
Bundle 'tpope/vim-fugitive'
Bundle 'kien/ctrlp.vim'
Bundle 'flazz/vim-colorschemes'
Bundle 'matchit.zip'
Bundle 'chriskempson/tomorrow-theme', { "rtp": "vim" }
Bundle "daylerees/colour-schemes", { "rtp": "vim-themes" }
Bundle "mozilla/rust", { "rtp": "src/etc/vim" }

let mapleader = ','

filetype plugin indent on     " required!

syntax enable
set autoindent
set smartindent

set background=dark

set ttimeout
set ttimeoutlen=50

if has('gui_running')
  set lines=40
  set columns=150
  colorscheme inkpot
  set cursorline
  set guifont=DejaVu_Sans_Mono:h9:cANSI
endif

set showmode
set ruler
set showcmd
set laststatus=2

set tabstop=4
set softtabstop=4
set smarttab
set shiftwidth=4
set shiftround

set number

set backspace=indent,eol,start
set complete-=i

if has ('x') && has ('gui') " On Linux use + register for copy-paste
  set clipboard=unnamedplus
elseif has ('gui')          " On mac and Windows, use * register for copy-paste
  set clipboard=unnamed
endif

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux'
  set t_Co=16
endif

" Change to the directory of the file we're editing
autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif

set history=1000

if has('persistent_undo')
  set undofile
  set undolevels=1000
  set undoreload=10000
endif

set incsearch
set ignorecase
set smartcase
set hlsearch
" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif
" Toggle search highlighting
nmap <silent> <leader>/ :set invhlsearch<CR>

set showmatch

set wildmenu
set wildmode=list:longest,full

set scrolloff=3
set sidescrolloff=5
set display+=lastline

map j gj
map k gk
nnoremap Y y$

set nrformats-=octal

" ctrlp {
  let g:ctrlp_working_path_mode = 2
  nnoremap <silent> <D-t> :CtrlP<CR>
  nnoremap <silent> <D-r> :CtrlPMRU<CR>
  let g:ctrlp_custom_ignore = {
    \ 'dir':  '\.git$\|\.hg$\|\.svn$',
    \ 'file': '\.exe$\|\.so$\|\.dll$' }

  let g:ctrlp_user_command = {
    \ 'types': {
      \ 1: ['.git', 'cd %s && git ls-files'],
      \ 2: ['.hg', 'hg --cwd %s locate -I .'],
    \ },
    \ 'fallback': 'find %s -type f'
  \ }
"}


function! InitializeDirectories()
  let dir_list = {
        \ 'backup': 'backupdir',
        \ 'views': 'viewdir',
        \ 'swap': 'directory' }

  if has('persistent_undo')
    let dir_list['undo'] = 'undodir'
  endif

  let common_dir = $HOME . '/.vim'

  for [dirname, settingname] in items(dir_list)
    let directory = common_dir . dirname . '/'
    if exists("*mkdir")
      if !isdirectory(directory)
        call mkdir(directory)
      endif
    endif
    if !isdirectory(directory)
      echo "Warning: Unable to create backup directory: " . directory
      echo "Try: mkdir -p " . directory
    else
      let directory = substitute(directory, " ", "\\\\ ", "g")
      exec "set " . settingname . "=" . directory
    endif
  endfor
endfunction

call InitializeDirectories()

" vim:set ft=vim et sw=2:
