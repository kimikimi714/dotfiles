if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath^=~/.dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin(expand('~/.dein'))

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

" 画面表示の設定
call dein#add('powerline/powerline', {'rtp': 'powerline/bindings/vim/'})
set guifont=Ricty\ for\ Powerline:h15
let g:Powerline_symbols = 'fancy'
set encoding=utf-8
set t_Co=256
set fillchars+=stl:\ ,stlnc:\
set term=xterm-256color
set termencoding=utf-8
syntax on             " シンタックスハイライト オン
call dein#add('tomasr/molokai')
colorscheme molokai
set background=dark
set number            " 行番号を表示する
set cursorline        " カーソル行の背景色を変える
set cursorcolumn      " カーソル位置のカラムの背景色を変える
set laststatus=2      " ステータス行を常に表示
set cmdheight=2       " メッセージ表示欄を2行確保
set title             " 編集中のタイトル名を表示する
set ruler             " ルーラーの表示
set showmatch         " 対応する括弧を強調表示
set helpheight=999    " ヘルプを画面いっぱいに開く
set list              " 不可視文字を表示
set formatoptions+=mM " テキスト挿入中の自動折り返しを日本語に対応させる
set linebreak         " 単語途中で折り返しせず、ホワイトスペースで折り返す
" 不可視文字の表示記号指定
set listchars=tab:▸=,trail:-,eol:↲,extends:❯,precedes:❮
" 全角スペース表示
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
match ZenkakuSpace /　/
" 行末の半角スペースを可視化
call dein#add('bronson/vim-trailing-whitespace')
" インデントに色を付けて見やすくする
call dein#add('nathanaelkane/vim-indent-guides')
" vimを立ち上げたときに、自動的にvim-indent-guidesをオンにする
let g:indent_guides_enable_on_vim_startup = 1

" カーソル移動関連の設定
set backspace=indent,eol,start " Backspaceキーでインデントや改行を削除できるようにする
set whichwrap=b,s,h,l,<,>,[,]  " 行頭行末の左右移動で行をまたぐ
set scrolloff=8                " 上下8行の視界を確保
set sidescrolloff=16           " 左右スクロール時の視界を確保
set sidescroll=1               " 左右スクロールは一文字づつ行う

" ファイル処理関連の設定
set confirm    " 保存されていないファイルがあるときは終了前に保存確認
set hidden     " 保存されていないファイルがあるときでも別のファイルを開くことが出来る
set autoread   " 外部でファイルに変更がされた場合は読みなおす
set nobackup   " ファイル保存時にバックアップファイルを作らない
set noswapfile " ファイル編集中にスワップファイルを作らない

" 検索/置換の設定
set hlsearch   " 検索文字列をハイライトする
set incsearch  " インクリメンタルサーチを行う
set ignorecase " 大文字と小文字を区別しない
set smartcase  " 大文字と小文字が混在した言葉で検索を行った場合に限り、大文字と小文字を区別する
set wrapscan   " 最後尾まで検索を終えたら次の検索で先頭に移る
set gdefault   " 置換の時 g オプションをデフォルトで有効にする
" コメントアウトのトグル(2014-06-01)
" \cでコメントアウトの切り替え
call dein#add('tyru/caw.vim')
nmap <Leader>c <Plug>(caw:i:toggle)
vmap <Leader>c <Plug>(caw:i:toggle)
" Required:
filetype plugin indent on
" 複数文字を一気に選択
call dein#add('terryma/vim-multiple-cursors')

" タブ/インデントの設定
set expandtab     " タブ入力を複数の空白入力に置き換える
set tabstop=2     " 画面上でタブ文字が占める幅
set shiftwidth=2  " 自動インデントでずれる幅
set softtabstop=2 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent    " 改行時に前の行のインデントを継続する
set smartindent   " 改行時に入力された行の末尾に合わせて次の行のインデントを増減する

" 動作環境との統合関連の設定
" OSのクリップボードをレジスタ指定無しで Yank, Put 出来るようにする
set clipboard=unnamed,unnamedplus

" コマンドラインの設定
" コマンドラインモードでTABキーによるファイル名補完を有効にする
set wildmenu wildmode=list:longest,full
" コマンドラインの履歴を100件保存する
set history=100

" HTMLタグの補完強化
call dein#add('mattn/emmet-vim')

" https://github.com/Shougo/unite.vim
call dein#add('Shougo/unite.vim')

" ファイルをtree表示してくれる
call dein#add('scrooloose/nerdtree')
" 隠しファイルをデフォルトで表示させる
let NERDTreeShowHidden = 1
" デフォルトでツリーを表示させる
autocmd VimEnter * execute 'NERDTree'

" https://github.com/Shougo/neocomplete.vim
call dein#add('Shougo/neocomplete.vim')

" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
 " Use underbar completion.
let g:neocomplete#enable_underbar_completion = 1
" ユーザ定義の辞書を指定
let g:neocomplete#sources#dictionary#dictionaries = {
  \ 'default' : '',
  \ 'scala' : $HOME . '/.vim/dict/scala.dict',
  \ }
" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

" scala用syntax highlight
call dein#add('derekwyatt/vim-scala')
" html5シンタックス
call dein#add('taichouchou2/html5.vim')
" CSSシンタックス
call dein#add('hail2u/vim-css3-syntax')
" javascriptシンタックス
call dein#add('pangloss/vim-javascript')
" vueシンタックス
call dein#add('posva/vim-vue')

" Required:
call dein#end()

" Required:
filetype plugin indent on

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif
