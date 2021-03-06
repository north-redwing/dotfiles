"                                _                    
"                         __   _(_)_ __ ___  _ __ ___ 
"                         \ \ / / | '_ ` _ \| '__/ __|
"                          \ V /| | | | | | | | | (__ 
"                         (_)_/ |_|_| |_| |_|_|  \___|
"
"
" dein Scripts-----------------------------
if &compatible
  set nocompatible
endif

" dein.vimインストール時に指定したディレクトリをセット
let s:dein_dir = expand('~/.cache/dein')

" dein.vimの実体があるディレクトリをセット
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vimが存在していない場合はgithubからclone
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " dein.toml, dein_layz.tomlファイルのディレクトリをセット
  let s:toml_dir = expand('~/.config/nvim')

  " 起動時に読み込むプラグイン群
  call dein#load_toml(s:toml_dir . '/dein.toml', {'lazy': 0})

  " 遅延読み込みしたいプラグイン群
  call dein#load_toml(s:toml_dir . '/dein_lazy.toml', {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif
" End dein Scripts-------------------------

colorscheme molokai
" 背景色¬
set background=dark
" 背景透過
" augroup TransparentBG
"     autocmd!
"     autocmd Colorscheme * highlight Normal ctermbg=none
"     autocmd Colorscheme * highlight NonText ctermbg=none
"     autocmd Colorscheme * highlight LineNr ctermbg=none
"     autocmd Colorscheme * highlight Folded ctermbg=none
"     autocmd Colorscheme * highlight EndOfBuffer ctermbg=none 
" augroup END

"ビープ音すべてを無効にする
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

" 行末でもう一文字移動可能にする
set virtualedit=onemore

" insert modeでのBSの挙動
set backspace=indent,eol,start

" backup作成off
set nobackup
set noswapfile 
set nowritebackup

" マウスを使う
set mouse=a

if !has('nvim')
    " クリップボードに格納
    set clipboard=unnamed,autoselect
    set ttymouse=xterm2
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
" 現在の行をハイライト
set cursorline
" カラムラインを引く
set colorcolumn=80

" 折り返し表示の際にも行単位で移動
" accelerated-jk pluginでmapping
" noremap j gj
" noremap k gk
" vnoremap j gj
" vnoremap k gk
" 行をまたいで移動
set whichwrap=b,s,h,l,<,>,[,],~

" insert modeでもCtrl同時押しで移動
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap <C-w> <C-\><C-O>w
inoremap <C-e> <C-\><C-O>e
inoremap <C-b> <C-\><C-O>b

" command modeでもCtrl同時押しで移動
cnoremap <C-k> <Up>
cnoremap <C-j> <Down>
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
cnoremap <C-x> <Del>

" 貼り付けたテキストの末尾へ自動的に移動
vnoremap <silent> y y`]

" 行頭行末に移動
nnoremap <S-h> 0
nnoremap <S-h><S-h> ^
nnoremap <S-l> $<Right>
nnoremap <S-l><S-l> $
vnorema  <S-h> 0
vnorema  <S-h><S-h> ^
vnoremap <S-l> $<Right>
vnoremap <S-l><S-l> $

" insert modeから抜ける
inoremap <silent> jj <Esc>
inoremap <silent> っj <ESC>
inoremap <silent> jk <ESC>

" typo修正
inoremap <silent><C-t> <Esc><Left>"zx"zpa

" buffer切り替え時に自動で書き込み
set autowrite
set hidden

" bufferの全てを変更があれば保存
nnoremap <leader>z :xa <CR>
nnoremap ZZ :xa <CR>

" window
nnoremap <silent><leader>ww <C-w><C-w>
nnoremap <leader>w :w<CR>
nnoremap <leader>wa :wa<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>qa :qa<CR>

" macro実行
nnoremap <leader>m qm
nnoremap <leader>mm @m

" pythonでの関数移動をsearch使用で行う
autocmd FileType python nnoremap <silent><leader>n /def<CR>
" ipython3を実行
autocmd FileType python nnoremap <silent><leader>i :<C-u>belowright split term://ipython3<CR>

" 下方にterminalを表示
noremap <silent><leader>t :<C-u>belowright split term://zsh<CR>
" terminal modeを抜ける
tmap <silent><ESC> <C-\><C-n>
tmap <silent>jk <C-\><C-n>
" どのmodeでも<leader>wで強制的にwindowを移動する
tmap <silent><leader>ww <C-\><C-n><C-w><C-w>
" どのmodeでも<leader>qで強制的にwindowを消す
tmap <silent><leader>q <C-\><C-n>:q<CR>
" defaultでinsert modeで入る
autocmd TermOpen * startinsert

" buffer切り替え
nnoremap <silent><leader>bp :bprev <CR>
nnoremap <silent><leader>bn :bnext <CR>
nnoremap <silent><leader>bd :bd <CR>
nnoremap <silent><leader><leader> :bnext <CR>

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
nnoremap x "_x
nnoremap <S-x> "_X
nnoremap s "_s

" <leader>o/Oでnormal modeのまま空白行挿入
nnoremap <leader>o o<ESC>
nnoremap <leader><CR> o<ESC>
nnoremap <leader>O O<ESC>
nnoremap <leader><CR><CR> O<ESC>

" Tab, S-Tabでindent変更
" nnoremap <Tab> >>
" nnoremap <S-Tab> <<

" 全行format
nnoremap <leader>fmt gg=G

" 数字の増減
nnoremap + <C-a>
nnoremap - <C-x>

" 置換時にインタラクティブに表示
set inccommand=split
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

" defaultのgrepをripgrepに変更
if executable('rg')
    set grepprg=rg\ --vimgrep\ --no-heading\ --exclude-dir=.git\ --exclude-dir=__pycache__
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" filetypeをwildcardで検索する
" deniteでもできれば必要ないが方法が不明
function! Grep(...)
    if and(a:0 == 1, exists('g:file'))
        echo 'Use Grep => {file} ' . g:file . ' {pattern} ' . a:1
        execute(':cex "" | vimgrep ' . a:1 . ' ' . g:file . ' | bd | topleft cw | set modifiable')
    elseif a:0 == 2
        echo 'Use Grep => {file} ' . a:1 . ' {pattern} ' . a:2
        let g:file = a:1
        execute(':cex "" | vimgrep ' . a:2 . ' ' . a:1 . ' | bd | topleft cw | set modifiable')
    else
        echo 'Invalid Argument!'
        echo ':Grep {file} {pattern}'
        echo 'or if you use the last {file} again,'
        echo ':Grep {pattern}'
    endif
endfunction
command! -nargs=+ Grep call Grep(<f-args>)

" deniteで横断grepは可能なため
" vimgrepでは開いているbuffer内のみのgrepをdefaultにする
function! GrepBuffer(...)
    if a:0 == 1
        echo 'Use Grep => {pattern} ' . a:1 . ' in all buffers'
        execute(':cex""|bufdo vimgrepadd ' . a:1 . ' %')
        execute(':topleft cw | set modifiable')
    else
        echo 'Invalid Argument!'
        echo ':GrepBuffer {pattern}'
    endif
endfunction
command! -nargs=1 GrepBuffer call GrepBuffer(<f-args>)

nnoremap <leader>g :GrepBuffer 
nnoremap <silent><leader>c :GrepBuffer <C-r><C-w><CR>
nnoremap <leader>gg :Grep 
nnoremap <silent><leader>cc :cclose <CR>
nnoremap <silent><leader>cw :topleft cw<CR>:set modifiable<CR>

nnoremap <leader>xx <Nop>
nnoremap <leader>x <Nop>
nnoremap <leader>cp :cprev <CR>
nnoremap <leader>cn :cnext <CR>

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
