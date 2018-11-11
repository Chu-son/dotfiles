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

" 表示設定
set number "行番号表示
set title "編集中のファイル名表示
set ambiwidth=double
set list "タブ空白改行を可視化
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
set showmatch "括弧入力時に対応ずる括弧を示す
set laststatus=2 "ステータスを表示

"文字、カーソル設定
set encoding=utf-8
set fileencodings=utf-8
set fileformats=unix,dos,mac
set smartindent
set tabstop=4
set expandtab
set shiftwidth=4

"pythonで#コメントのインデント保持
autocmd BufRead *.py inoremap # X<c-h>#

" 検索設定
set ignorecase "大文字、小文字の区別をしない
set smartcase "大文字が含まれている場合は区別する
set wrapscan "検索時に最後まで行ったら最初に戻る
set hlsearch "検索した文字を強調
set incsearch "インクリメンタルサーチを有効にする

" マウス設定
set mouse=a
set ttymouse=xterm2

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

