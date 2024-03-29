"---------------------------------------------------------------------------
" 編集に関する設定:
"
" タブの画面上での幅
set tabstop=4
" タブをスペースに展開する (noexpandtab:展開しない)
set expandtab
" 自動的にインデントする (noautoindent:インデントしない)
set autoindent
" 特定のキーワード後のインデントは、ひとつ下げる
set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
" 自動インデントでずれる幅
set shiftwidth=2
"バックスペースでインデントや改行を削除できるようにする
set backspace=2
" 検索時にファイルの最後まで行ったら最初に戻る (nowrapscan:戻らない)
set wrapscan
" 検索した単語を強調する
set hlsearch
" 括弧入力時に対応する括弧を表示 (noshowmatch:表示しない)
set showmatch
" コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
set wildmenu
" テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mM
" 日本語整形スクリプト(by. 西岡拓洋さん)用の設定
let format_allow_over_tw = 1    " ぶら下り可能幅
" シンタックス
syntax on
"コピーした文字列をクリップボードで保持
set clipboard+=unnamed

"---------------------------------------------------------------------------
" GUI固有ではない画面表示の設定:
"
" 行番号を非表示 (number:表示)
set number
" ルーラーを表示 (noruler:非表示)
set ruler
" タブや改行を表示 (list:表示)
set nolist
" どの文字でタブや改行を表示するかを設定(表示しないように)
set listchars=
" set listchars=tab:,extends:<,trail:-,eol:<
" 長い行を折り返して表示 (nowrap:折り返さない)
set wrap
" 常にステータス行を表示 (詳細は:he laststatus)
set laststatus=2
" コマンドラインの高さ (Windows用gvim使用時はgvimrcを編集すること)
set cmdheight=2
" コマンドをステータス行に表
set showcmd
" タイトルバーの表示を消す
set notitle

""""""""""""""""""""""""""""""
" 自動的に閉じ括弧を入力
""""""""""""""""""""""""""""""
imap { {}<LEFT>
imap [ []<LEFT>
imap ( ()<LEFT>
""""""""""""""""""""""""""""""

"---------------------------------------------------------------------------
" プラグイン用の設定:
"
set nocompatible
filetype plugin indent off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif

" NeoBundle
call neobundle#begin(expand('~/.vim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'

" molokai カラースキーム
NeoBundle 'tomasr/molokai'
NeoBundle 'Shougo/unite.vim'
" 定型文補完
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
" コード補完
NeoBundle 'Shougo/neocomplcache.vim'
" def,ifなどの後に改行すると自動でendを挿入してくれる
NeoBundle 'tpope/vim-endwise'
" :Rでview-controller,:Emodel-:Ecでmodel-controllerを移動
NeoBundle 'tpope/vim-rails'
" Sidebarのディレクトリ構造を表示するプラグイン
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'editorconfig/editorconfig-vim'
" NeoBundle 'macros/matchit.vim'
" scala syntax
NeoBundle 'derekwyatt/vim-scala'
" CoffeeScriptのsyntax highlight
NeoBundle 'kchmck/vim-coffee-script'
" Reference
NeoBundle 'thinca/vim-ref'
" Syntax check
NeoBundle 'scrooloose/syntastic'
" IDE for golang
NeoBundle 'fatih/vim-go'
" finder
NeoBundle 'kien/ctrlp.vim'
call neobundle#end()

" ctrlp setting
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
let g:ctrlp_user_command = 'find %s -type f'        " MacOSX/Linux

" Syntaxの設定
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2
let g:syntastic_php_checkers=['php', 'phpcs']
let g:syntastic_ruby_checkers=['rubocop']
let g:syntastic_python_checkers=['pyflakes', 'pep8']
let g:ref_phpmanual_path = $HOME . '/.vim/ref/php-chunked-xhtml'
let $PATH = $PATH . ':/opt/local/bin'

" vim-goの補完をoffに
let g:go_fmt_autosave = 0
let g:go_gorename_command = 'gopls'

" カラースキームの設定
colorscheme molokai

" div, p間を%で移動
let b:match_words = '<div:</div>,<p:</p>'

" Evervim
nnoremap <Leader>l :EvervimNotebookList<CR>
nnoremap <Leader>s :EvervimSearchByQuery<Space>
nnoremap <Leader>c :EvervimCreateNote<CR>
nnoremap <Leader>b :EvervimOpenBrowser<CR>

" ファイル指定で開かれた場合はNERDTreeは表示しない
let file_name = expand("%:p")
if has('vim_starting') &&  file_name == ""
  autocmd VimEnter * call ExecuteNERDTree()
endif

" カーソルが外れているときは自動的にnerdtreeを隠す
function! ExecuteNERDTree()
  "b:nerdstatus = 1 : NERDTree 表示中
  "b:nerdstatus = 2 : NERDTree 非表示中

  if !exists('g:nerdstatus')
    execute 'NERDTree ./'
    let g:windowWidth = winwidth(winnr())
    let g:nerdtreebuf = bufnr('')
    let g:nerdstatus = 1

  elseif g:nerdstatus == 1
    execute 'wincmd t'
    execute 'vertical resize' 0
    execute 'wincmd p'
    let g:nerdstatus = 2
  elseif g:nerdstatus == 2
    execute 'wincmd t'
    execute 'vertical resize' g:windowWidth
    let g:nerdstatus = 1
  endif
endfunction

" [ctrl e] でNERDTreeを開く
noremap <c-e> :<c-u>:call ExecuteNERDTree()<cr>

filetype plugin indent on

"---------------------------------------------------------------------------
" 言語毎の設定:
"
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_smart_case = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_manual_completion_start_length = 0
let g:neocomplcache_caching_percent_in_statusline = 1
let g:neocomplcache_enable_skip_completion = 1
let g:neocomplcache_skip_input_time = '0.5'

" PHP settings
" snippets
autocmd BufRead *.php\|*.ctp\|*.tpl :set dict=~/.vim/dict/php.dict filetype=php

" syntax
autocmd FileType php set makeprg=php\ -l\ %
autocmd BufWritePost *.php silent make | if len(getqflist()) != 1 | copen | else | cclose | endif

autocmd FileType php set tags=$HOME/tags
