" Flags
let s:use_dein = 1

" vi compatibility
if !&compatible
  set nocompatible
endif

" Prepare .vim dir
"let s:vimdir = '~/vimfiles/.vim'
let s:vimdir = expand('~/.vim')
if has('vim_starting')
  if ! isdirectory(s:vimdir)
    call system('mkdir ' . s:vimdir)
  endif
endif

" dein
let s:dein_enabled  = 0
if s:use_dein && v:version >= 704
  let s:dein_enabled = 1

  " Set dein paths
  let s:dein_dir = s:vimdir . '/dein'
  let s:dein_github = s:dein_dir . '/repos/github.com'
  let s:dein_repo_name = 'Shougo/dein.vim'
  let s:dein_repo_dir = s:dein_github . '/' . s:dein_repo_name

  " Check dein has been installed or not.
  if !isdirectory(s:dein_repo_dir)
    echo 'dein is not installed, install now '
    let s:dein_repo = 'https://github.com/' . s:dein_repo_name
    echo 'git clone ' . s:dein_repo . ' ' . s:dein_repo_dir
    call system('git clone ' . s:dein_repo . ' ' . s:dein_repo_dir)
  endif
  "echo &runtimepath
  let &runtimepath = &runtimepath . ',' . s:dein_repo_dir


  " Check cache
  if dein#load_state(s:dein_dir)
    " Begin plugin part
    call dein#begin(s:dein_dir)

    let s:toml = s:dein_dir . '/dein.toml'
    let s:lazy_toml = s:dein_dir . '/dein_lazy.toml'


    " TOMLファイルにpluginを記述
    call dein#load_toml(s:toml, {'lazy': 0})
    call dein#load_toml(s:lazy_toml, {'lazy': 1})

    call dein#end()
    call dein#save_state()
  endif


  filetype plugin indent on

  " Installation check.
  if dein#check_install()
    call dein#install()
  endif
endif

if s:dein_enabled && dein#tap("unite.vim")
  nnoremap [unite] <Nop>
  nmap <Leader>u [unite]
  nnoremap <silent> [unite]b :Unite buffer<CR>
endif

filetype off

colorscheme lucius
"colorscheme summerfruit256
"colorscheme pyte
"colorscheme solarized
set background=dark
"set t_Co=256

set number
set title
set ambiwidth=double
set tabstop=4
set expandtab
set shiftwidth=4
set smartindent
set list
set nrformats-=octal
set hidden
set history=50
set virtualedit=block
set whichwrap=b,s,[,],<,>
set backspace=indent,eol,start
set wildmenu
set nobackup
set noundofile
set noswapfile
set hlsearch

set encoding=utf-8
set fileencodings=utf-8
set fileformats=unix,dos,mac

syntax on

inoremap <C-j> <esc>
nmap <CR> i<CR><ESC>
nnoremap <F3> :noh<CR>
nnoremap <leader>l :call Flake8()
nnoremap gs :vertical wincmd f<CR>

"()の補完
"inoremap ( ()<LEFT>

"virtualモードの時にスターで選択位置のコードを検索するようにする"
xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>
function! s:VSetSearch()
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
    let @s = temp
endfunction

