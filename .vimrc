call plug#begin('~/.vim/plugged')

" 画面表示の設定
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='violet'
let g:airline_powerline_fonts = 1
let g:airline_solarized_bg='dark'
set guifont=Inconsolata\ for\ Powerline:h15

set encoding=utf-8
set fileencodings=utf-8,sjis,euc-jp,iso-2022-jp,latin1
set t_Co=256
set fillchars+=stl:\ ,stlnc:\
set term=xterm-256color
set termencoding=utf-8
syntax on             " シンタックスハイライト オン
Plug 'tomasr/molokai'
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
Plug 'bronson/vim-trailing-whitespace'
" インデントに色を付けて見やすくする
Plug 'preservim/vim-indent-guides'
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
Plug 'tyru/caw.vim'
nmap <Leader>c <Plug>(caw:hatpos:toggle)
vmap <Leader>c <Plug>(caw:hatpos:toggle)
" Required:
filetype plugin indent on
" 複数文字を一気に選択
Plug 'mg979/vim-visual-multi'

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

" ファイルをtree表示してくれる
Plug 'preservim/nerdtree'
" 隠しファイルをデフォルトで表示させる
let NERDTreeShowHidden = 1
" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p

Plug 'Shougo/ddc.vim'
Plug 'vim-denops/denops.vim'

" ポップアップウィンドウを表示するプラグイン
Plug 'Shougo/ddc-ui-native'
" カーソル周辺の既出単語を補完するsource
Plug 'Shougo/ddc-around'
" ファイル名を補完するsource
Plug 'LumaKernel/ddc-file'
" 入力中の単語を補完の対象にするfilter
Plug 'Shougo/ddc-matcher_head'
" 補完候補を適切にソートするfilter
Plug 'Shougo/ddc-sorter_rank'
" 補完候補の重複を防ぐためのfilter
Plug 'Shougo/ddc-converter_remove_overlap'

Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/vim-lsp'
Plug 'shun/ddc-source-vim-lsp'

" Initialize plugin system
call plug#end()

call plug#('Shougo/ddc.vim')
call plug#('vim-denops/denops.vim')
call plug#('Shougo/ddc-ui-native')
call plug#('Shougo/ddc-around')
call plug#('LumaKernel/ddc-file')
call plug#('Shougo/ddc-matcher_head')
call plug#('Shougo/ddc-sorter_rank')
call plug#('Shougo/ddc-converter_remove_overlap')
call plug#('prabirshrestha/vim-lsp')
call plug#('mattn/vim-lsp-settings')
call plug#('shun/ddc-source-vim-lsp')

call ddc#custom#patch_global('ui', 'native')
call ddc#custom#patch_global('sources', [
 \ 'around',
 \ 'vim-lsp',
 \ 'file'
 \ ])
call ddc#custom#patch_global('sourceOptions', {
 \ '_': {
 \   'matchers': ['matcher_head'],
 \   'sorters': ['sorter_rank'],
 \   'converters': ['converter_remove_overlap'],
 \ },
 \ 'around': {'mark': 'Around'},
 \ 'vim-lsp': {
 \   'mark': 'LSP',
 \   'matchers': ['matcher_head'],
 \   'forceCompletionPattern': '\.|:|->|"\w+/*'
 \ },
 \ 'file': {
 \   'mark': 'file',
 \   'isVolatile': v:true,
 \   'forceCompletionPattern': '\S/\S*'
 \ }})
call ddc#enable()

filetype plugin indent on    " required
" use fzf in vim
set rtp+=/usr/local/opt/fzf
