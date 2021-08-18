
" leaderをスペースへ設定
"ビープ音すべてを無効
set visualbell t_vb=
set noerrorbells

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

" クリップボードに格納
if !has('nvim')
    set clipboard=unnamed,autoselect
endif

" 不可視文字の表示
set listchars=tab:»-,eol:↲,extends:»,precedes:«,nbsp:%
set list

" 括弧の対応関係を表示
set showmatch
noremap m %

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
" "noremap j gj
" "noremap k gk
" "vnoremap j gj
" "vnoremap k gk
" 行をまたいで移動
set whichwrap=b,s,h,l,<,>,[,],~

" insert modeでもCtrl同時押しで移動
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap <C-w> <C-\><C-O>w
inoremap <C-b> <C-\><C-O>b

" 貼り付けたテキストの末尾へ自動的に移動
vnoremap <silent> y y`]

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

" bufferの全てを変更があれば保存
nnoremap <leader>x :xa <CR>
nnoremap <leader>w :wa <CR>
nnoremap <leader>q :qa! <CR>
nnoremap <leader>c <Nop>

" ipython実行
nnoremap <leader>i :!ipython3 <CR>

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
nnoremap <CR> A<CR><ESC>
nnoremap <leader><CR> <Up>A<CR><ESC>

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

" カーソル位置記憶
if has("autocmd")
  augroup redhat
    " In text files, always limit the width of text to 78 characters
    autocmd BufRead *.txt set tw=78
    " When editing a file, always jump to the last cursor position
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
  augroup END
endif
