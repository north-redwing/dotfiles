"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイル
  " 予め TOML ファイル（後述）を用意しておく
  let g:rc_dir    = expand('~/.vim/rc')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif
"End dein Scripts-------------------------
 
" leaderをスペースへ設定
let mapleader = "\<Space>"
 
" シンタックスハイライトon
syntax enable
 
" Tabで候補移動
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
 
" commandの履歴の保存
set history=10000

" 文字コード
set encoding=utf-8
set fileencoding=utf-8

" insert modeでのBSの挙動
set backspace=indent,eol,start

" backup作成off
set nobackup
set noswapfile 

" マウスを使う
set mouse=a
set ttymouse=xterm2

" クリップボードに格納
set clipboard=unnamed,autoselect

" 不可視文字の表示
set listchars=tab:»-,eol:↲,extends:»,precedes:«,nbsp:%
set list

" 括弧の対応関係を表示
set showmatch
"l 閉じ括弧自動保管
inoremap <leader>{ {}<LEFT>
inoremap <leader>} {}<LEFT>
inoremap <leader>[ []<LEFT>
inoremap <leader>] []<LEFT>
inoremap <leader>( ()<LEFT>
inoremap <leader>) ()<LEFT>
inoremap <leader>< <><LEFT>
inoremap <leader>> <><LEFT>
inoremap <leader>" ""<LEFT>
inoremap <leader>' ''<LEFT>

" 入力中のコマンドを表示
set showcmd
" modeの表示
set showmode
" 右下に行番号と列番号を表示する
" powerlineで表示されるので解除
" set ruler

" 行番号の表示
" set rulerでわかるので不使用
" set number
" 相対行番号を表示
set relativenumber
" 行番号の色を変更
highlight LineNr ctermfg=239
" 現在の行をハイライト
set cursorline
" カラムラインを引く
set colorcolumn=80

" 折り返し表示の際にも行単位で移動
noremap j gj
noremap k gk
vnoremap j gj
vnoremap k gk
" 行をまたいで移動
set whichwrap=b,s,h,l,<,>,[,],~

" insert modeでもCtrl同時押しで移動
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap <C-w> <C-\><C-O>w
inoremap <C-b> <C-\><C-O>b

" 行頭行末に移動
nnoremap <S-h> ^
nnoremap <S-l> $
vnoremap <S-h> ^
vnoremap <S-l> $

" insert modeから抜ける
inoremap <silent> jj <Esc>
inoremap <silent> っj <ESC>
inoremap <silent> jk <ESC>

" buffer切り替え時に自動で書き込み
set autowrite
set hidden

" bufferの全てを保存
nnoremap ZZ :wqa <CR>

" buffer切り替え
nnoremap <silent> bp :bprev<CR>
nnoremap <silent> bn :bnext<CR>

" Tabの代わりに空白を使う
set expandtab
" Tabタブの幅
set tabstop=4
" 自動インデントでずれる幅
set shiftwidth=4
" 連続した空白に対してTabやBSでカーソルが動く幅
" （デフォルトでは無効: 0）
set softtabstop=2
" 改行時に前の行のインデントを継続する
set autoindent
" 改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set smartindent
" 全角スペースの表示
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=underline ctermfg=red guibg=darkgray
endfunction
if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme * call ZenkakuSpace()
        autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
    augroup END
     call ZenkakuSpace()
endif

" 削除をレジスタに入れない
noremap x "_x
nnoremap <S-x> "_X

" returnでnormal modeのまま空白行挿入
nnoremap <CR> :normal o <CR>
nnoremap <leader><CR> :normal O <CR>

" 数字の増減
nnoremap + <C-a>
nnoremap - <C-x>

" 置換の際にgオプションをdefaultで有効
set gdefault
" 大文字小文字を無視
set ignorecase
" ignorecaseと合わせることで，小文字入力の時のみ大文字小文字を無視
set smartcase
" インクリメンタルサーチ
set incsearch
" 検索結果をハイライト
set hlsearch
" Ctrl-C x 2でハイライト終了
nnoremap <C-c><C-c> :<C-u>nohlsearch<cr><Esc>

" C, YをDと同じ挙動にする
nnoremap <S-c> c$
nnoremap <S-y> y$

" indentが崩れぬようペースト
nnoremap ,i :<C-u>set paste<Return>i
autocmd InsertLeave * set nopaste
