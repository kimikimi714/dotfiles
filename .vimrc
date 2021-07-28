call plug#begin('~/.vim/plugged')

" 画面表示の設定
Plug 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
set guifont=Ricty\ for\ Powerline:h15
let g:Powerline_symbols = 'fancy'
set encoding=utf-8
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
Plug 'nathanaelkane/vim-indent-guides'
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
nmap <Leader>c <Plug>(caw:i:toggle)
vmap <Leader>c <Plug>(caw:i:toggle)
" Required:
filetype plugin indent on
" 複数文字を一気に選択
Plug 'terryma/vim-multiple-cursors'

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

" https://github.com/Shougo/deoplete.nvim
Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'

" Use deoplete.
let g:deoplete#enable_at_startup = 1
" Plugin key-mappings.
inoremap <expr><C-g> deoplete#undo_completion()
inoremap <expr><C-l> deoplete#complete_common_string()

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
  return deoplete#close_popup() . "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backward char.
inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> deoplete#smart_close_popup()."\<C-h>"

" Initialize plugin system
call plug#end()
filetype plugin indent on    " required

" Use smartcase
" I want to add this line next to deoplete#enable_at_startup,
" but I had an error 'Unknown function: deoplete#custom#option'.
" So, I call this at the end of file.
" Then I don't have the same error.
call deoplete#custom#option('smart_case', v:true)

