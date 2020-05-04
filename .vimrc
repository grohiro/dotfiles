set nocompatible
set autowrite

let mapleader = "\<Space>"
set rtp+=~/src/vim/vim-test-truffle

" Do not use matchparen
" http://itchyny.hatenablog.com/entry/2016/03/30/210000
let g:loaded_matchparen = 1
let g:quickrun_no_default_key_mappings = 1

" vimrc.local {{{
" http://vim-users.jp/2009/12/hack112/
" Load settings for each location.
augroup vimrc-local
  autocmd!
  autocmd BufNewFile,BufReadPre,VimEnter * call s:vimrc_local(expand('<afile>:p:h'))
  "autocmd BufWinEnter * call s:vimrc_local(expand('<afile>:p:h'))
  "autocmd VimEnter * call s:vimrc_local(expand('<afile>:p:h'))
augroup END

function! s:vimrc_local(loc)
  let files = findfile('.vimrc.local', escape(a:loc, ' ') . ';', -1)
  for i in reverse(filter(files, 'filereadable(v:val)'))
    source `=i`
  endfor
endfunction
" }}}
"
" {{{ Plug
call plug#begin('~/.vim/plugged')

" autopairs
"Plug 'jiangmiao/auto-pairs'
Plug 'cohama/lexima.vim'

Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'Shougo/deoplete.nvim'
"Plug 'Shougo/echodoc.vim'
Plug 'Shougo/vimproc'
Plug 'Shougo/vimproc.vim'
Plug 'SirVer/ultisnips'
Plug 'airblade/vim-rooter'
Plug 'craigemery/vim-autotag'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
"Plug 'felixfbecker/php-language-server', {'do': 'composer install && composer run-script parse-stubs'}
Plug 'grohiro/vim-php-namespace'
Plug 'grohiro/vim-test-truffle'
Plug 'hashivim/vim-terraform'
"Plug 'honza/vim-snippets'
Plug 'janko-m/vim-test'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'kchmck/vim-coffee-script'
Plug 'leafgarland/typescript-vim'
Plug 'mattn/emmet-vim'
Plug 'microsoft/python-language-server'
"Plug 'posva/vim-vue'
Plug 'leafOfTree/vim-vue-plugin'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/asyncomplete-ultisnips.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'ryanoasis/vim-devicons'
"Plug 'tmhedberg/matchit'
Plug 'andymass/vim-matchup'
Plug 'scrooloose/nerdtree'
Plug 'thinca/vim-quickrun'
Plug 'thomasfaingnaert/vim-lsp-snippets'
Plug 'thomasfaingnaert/vim-lsp-ultisnips'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/taglist.vim'
Plug 'vim-scripts/yanktmp.vim'

" GNU global (gtags)
Plug 'vim-scripts/gtags.vim'
Plug 'zebult/auto-gtags.vim'

Plug 'mattn/vim-lsp-settings'
Plug 'nanotech/jellybeans.vim'
Plug 'leafgarland/typescript-vim'
Plug 'tpope/vim-rails'
" text-obj
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-function'
"Plug 'akiyan/vim-textobj-xml-attribute'
Plug 'h1mesuke/textobj-wiw'
Plug 'rhysd/vim-textobj-ruby'
Plug 'whatyouhide/vim-textobj-xmlattr'
"Plug 'sgur/vim-textobj-parameter'
Plug 'wellle/targets.vim'
Plug 'thinca/vim-textobj-between'
Plug 'xavierchow/vim-swagger-preview'
" PHP IDE
"Plug 'phpactor/phpactor'
"Plug 'kristijanhusak/deoplete-phpactor'
call plug#end()
" }}}

filetype indent plugin on
source ~/.vim/autocmd.vim

" {{{ folding
set foldmethod=marker
set foldmarker={{{,}}}
set foldlevelstart=1
"set nofoldenable
" }}}

" {{{ behavior
set ttyfast
" 編集中でも他のファイルを表示
set hidden 
" コマンドモード補完機能の設定
set wildmode=list:full
" 改行文字も削除できるようにする
set backspace=2
" ファイルブラウザのベースディレクトリ
"       last: 前回のディレクトリ
"     buffer: 現在のバッファのディレクトリ
"    current: カレントディレクトリ
"     {path}: path で指定されたディレクトリ
set browsedir=buffer

" Vim起動時に保存時の行へジャンプ
" 無効にする場合は '1000 -> '0 にすること。
set viminfo='1000,f1,<50,s10,h

set wrap

" set the number of history.
set history=100

set splitbelow

" インデントをshiftwidthの倍数に丸める
set shiftround

" 行頭の余白内で Tab を打ち込むとshiftwidthの数だけインデントする
set smarttab

" マルチバイトで崩れる問題を修正
set ambiwidth=double

set nobackup
set noundofile

set wildignore=*.pyc

" マウスを有効にする
set mouse=a

" 保管オプション
set completeopt=menu,menuone,longest
" }}}

" {{{ view

" 行番号の表示
set number

" ルーラの表示
set ruler

set list
set listchars=eol:¬,tab:▸\ 

" Status line
set laststatus=2
"set statusline=%f%m%{GetStatusEx()}\ %r\ line\ %l\ of\ %L\ %{cfi#format(\"(%s)\",\"\")}
"set statusline=%f%m%{GetStatusEx()}\ %r\ line\ %l\ of\ %L
set statusline=%f%m\ %r\ line\ %l\ of\ %L

set breakindent
" }}}

" Color {{{
set t_Co=256
colo jellybeans
"colorscheme desert
set bg=dark
"hi SpecialKey ctermfg=231
syntax enable
"hi NonText ctermfg=DarkGray
" }}}

" {{{ encoding
" 端末で使用するの文字コード
set termencoding=utf-8
set encoding=utf-8

" Unicodeを扱うための設定
set fileencoding=utf-8
set fileencodings=utf-8,euc-jp,iso-2022-jp,cp932,ucs-2le,usc-2jp

" 文字エンコーディングを取得
function! GetStatusEx()
	let str = ''
	let str = str . '[' . &fileformat . ']'
	if has('multi_byte') && &fileencoding != ''
		let str = str . '[' . &fileencoding . ']'
	endif

	return str
endfunction
" }}}

" {{{ search
set incsearch
set hlsearch
set noignorecase
nnoremap / /\c
set smartcase
map <leader>n :nohl<CR>
" }}}

" {{{ key mappings
noremap <C-x><C-v> :source ~/.vimrc<CR>
noremap <C-x><C-b> :tabnew ~/.vimrc<CR>
noremap <silent><F9> :ccl<CR>:silent! bw! \[quickrun\ buffer\]<CR>

" c*でカーソル下のキーワードを置換
nnoremap <expr> c* ':%s /\<' . expand('<cword>') . '\>/'
vnoremap <expr> c* ':s /\<' . expand('<cword>') . '\>/'
nnoremap CC :lcd<CR>

nnoremap <F2> :buf #<CR>

" Close all other windows
nnoremap <silent><leader>m :only<CR>
nnoremap <silent><leader>M :only<CR>:tabonly<CR>
nnoremap <leader>wl <C-W>l
nnoremap <leader>wh <C-W>h
nnoremap <leader>ww <C-W>w

" }}}

" {{{ indentation
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set autoindent
set nosmartindent
" }}}

" {{{ tab
" nnoremap T :tabnew<CR>:NERDTreeCWD<CR><ESC><C-w>h
nnoremap T :tabnew<CR>
nnoremap <C-h> gT
nnoremap <C-l> gt
" }}}

" quickfix {{{
" quickfixウインドを開いてカーソルを元に戻す
function! ShowQuickfix()
  execute 'cclose'
  execute 'cwindow'
  execute 'wincmd p'
endfunction

augroup QfAutoCommands
  autocmd!
  " Auto-close quickfix window
  autocmd WinEnter * if (winnr('$') == 1) && ((getbufvar(winbufnr(0), '&buftype')) == 'quickfix' || (getbufvar(winbufnr(0), '&ft')) == 'quickrun') | quit | endif
augroup END
" }}}

" vim-testing-pair {{{
"noremap <C-t> :ToggleTestingPair<CR>
" }}}

" `char` の次の出現位置に移動する
"function! MoveToNextChar(char)
  "set nohlsearch
  "call search(a:char)
  "set hlsearch
  "execute "normal l"
  "return ''
"endfunction

" プラグイン設定の読み込み
call map(sort(split(globpath(&runtimepath, 'plugins/*.vim'))), {->[execute('exec "so" v:val')]})

