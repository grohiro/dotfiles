set nocompatible
set autowrite

let g:autotagStartMethod='fork'
let mapleader = "\<Space>"
set rtp+=~/src/vim/vim-test-truffle
set rtp+=~/src/vim-nulab-backlog

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
Plug 'tpope/vim-abolish'
Plug 'editorconfig/editorconfig-vim'
Plug 'prettier/vim-prettier'
"Plug 'cohama/lexima.vim'
"Plug 'MaxMEllon/vim-jsx-pretty'
"Plug 'Shougo/deoplete.nvim'
Plug 'Shougo/vimproc'
Plug 'Shougo/vimproc.vim'
Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'
Plug 'airblade/vim-rooter'
Plug 'craigemery/vim-autotag'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'grohiro/vim-php-namespace'
"Plug 'grohiro/vim-test-truffle'
"Plug 'hashivim/vim-terraform'
Plug 'janko-m/vim-test'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/vim-easy-align'
"Plug 'kchmck/vim-coffee-script'
"Plug 'leafgarland/typescript-vim'
"Plug 'mattn/emmet-vim'
Plug  '~/src/emmet-vim'
"Plug 'microsoft/python-language-server'
"Plug 'posva/vim-vue'
"Plug 'leafOfTree/vim-vue-plugin'
"Plug 'prabirshrestha/async.vim'
"Plug 'prabirshrestha/asyncomplete.vim'
"Plug 'prabirshrestha/asyncomplete-lsp.vim'
"Plug 'prabirshrestha/asyncomplete-ultisnips.vim'
Plug 'prabirshrestha/vim-lsp'
"Plug 'roxma/nvim-yarp'
"Plug 'roxma/vim-hug-neovim-rpc'
"Plug 'ryanoasis/vim-devicons'
"Plug 'andymass/vim-matchup'
Plug 'scrooloose/nerdtree'
Plug 'thinca/vim-quickrun'
"Plug 'thomasfaingnaert/vim-lsp-snippets'
"Plug 'thomasfaingnaert/vim-lsp-ultisnips'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/taglist.vim'
Plug 'vim-scripts/yanktmp.vim'

" GNU global (gtags)
Plug 'vim-scripts/gtags.vim'
"Plug 'zebult/auto-gtags.vim'

Plug 'mattn/vim-lsp-settings'
"Plug 'tpope/vim-rails'

" text-obj
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-function'
"Plug 'akiyan/vim-textobj-xml-attribute'
Plug 'h1mesuke/textobj-wiw'
Plug 'rhysd/vim-textobj-ruby'
Plug 'whatyouhide/vim-textobj-xmlattr'
Plug 'sgur/vim-textobj-parameter'
Plug 'wellle/targets.vim'
Plug 'thinca/vim-textobj-between'
"Plug 'xavierchow/vim-swagger-preview'

"PHP IDE
"Plug 'phpactor/phpactor'
"Plug 'kristijanhusak/deoplete-phpactor'

"Plug 'vim-airline/vim-airline'
Plug 'cocopon/iceberg.vim'
"Plug 'lifepillar/vim-solarized8'
"Plug 'nanotech/jellybeans.vim'

Plug 'mattn/vim-maketable'
"Plug 'jparise/vim-graphql'
call plug#end()
" }}}

" {{{ folding
set foldmethod=marker
set foldmarker={{{,}}}
set foldlevelstart=1
"set nofoldenable
" }}}

filetype indent plugin on
source ~/.vim/autocmd.vim

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

" マルチバイトで崩れる問題を修正
set ambiwidth=double

set nobackup
set noundofile

set wildignore=*.pyc

" マウスを有効にする
set mouse=a

" 保管オプション
set completeopt=menu,menuone,longest,noselect
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

" {{{ encoding
" 端末で使用するの文字コード
set termencoding=utf-8
set encoding=utf-8

" Unicodeを扱うための設定
set fileencoding=utf-8
set fileencodings=utf-8,euc-jp,iso-2022-jp,cp932,ucs-2le,usc-2jp
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

" 配列みたいな文字列を,の後で改行する
nnoremap ,, :s/,/,\r/g<CR>

" }}}

" {{{ indentation
set autoindent
set expandtab
set nosmartindent
set shiftround
set shiftwidth=2
set smarttab
set softtabstop=2
set tabstop=2

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

" Color {{{
" Use true color on terminal
set termguicolors

colorscheme iceberg
hi TabLineSel guibg=#1e2132
"colorscheme desert
set bg=dark
"hi SpecialKey ctermfg=231
"syntax enable
"hi NonText ctermfg=DarkGray
"
" }}}

let g:backlog_folding = 1
