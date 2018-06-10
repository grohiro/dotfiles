set nocompatible

let mapleader = "\<Space>"

" Do not use matchparen
" http://itchyny.hatenablog.com/entry/2016/03/30/210000
let g:loaded_matchparen = 1
let g:quickrun_no_default_key_mappings = 1

" vimrc.local {{{
" http://vim-users.jp/2009/12/hack112/
" Load settings for each location.
augroup vimrc-local
  autocmd!
  autocmd BufNewFIle,BufReadPost * call s:vimrc_local(expand('<afile>:p:h'))
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

" dein {{{
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.vim/dein/repos/github.com/Shougo/dein.vim')
  call dein#begin('~/.vim/dein/repos/github.com/Shougo/dein.vim')
  call dein#load_toml('~/.vim/dein.toml', {'lazy': 0})
  call dein#end()
  call dein#save_state()
endif

" Install plugins if there are new plugins
if dein#check_install()
  call dein#install()
endif
" }}}

" {{{ folding
set foldmethod=marker
set foldmarker={{{,}}}
set foldlevelstart=0
" }}}

" {{{ behavior
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

" 勝手に改行しない
set formatoptions=q

" インデントをshiftwidthの倍数に丸める
set shiftround

" 行頭の余白内で Tab を打ち込むとshiftwidthの数だけインデントする
set smarttab

" マルチバイトで崩れる問題を修正
set ambiwidth=double

set nobackup
set noundofile

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
hi SpecialKey ctermfg=DarkGray
hi NonText ctermfg=DarkGray
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
" }}}

" {{{ key mappings
"noremap <C-x><C-v> :source ~/.vimrc<CR>
"noremap <C-x><C-b> :tabnew ~/.vimrc<CR>
noremap <silent><F9> :ccl<CR>:silent! bw! \[quickrun\ buffer\]<CR>

" c*でカーソル下のキーワードを置換
nnoremap <expr> c* ':%s /\<' . expand('<cword>') . '\>/'
vnoremap <expr> c* ':s /\<' . expand('<cword>') . '\>/'
nnoremap CC :lcd<CR>

nnoremap M :call ToggleWindowSize()<CR>

let t:toggle_window_size = 0
function! ToggleWindowSize()
  if t:toggle_window_size == 1
    exec "normal \<C-w>="
    let t:toggle_window_size = 0
  else
    :resize
    :vertical resize
    let t:toggle_window_size = 1
  endif
endfunction

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
augroup QfAutoCommands
  autocmd!
  " Auto-close quickfix window
  autocmd WinEnter * if (winnr('$') == 1) && ((getbufvar(winbufnr(0), '&buftype')) == 'quickfix' || (getbufvar(winbufnr(0), '&ft')) == 'quickrun') | quit | endif
augroup END
" }}}

" Plugins 

" {{{ fzf.vim
set rtp+=/usr/local/opt/fzf
nnoremap <C-p> :Files<CR>
nnoremap L :Buffers<CR>
let $FZF_DEFAULT_COMMAND = 'fd --type f'
" }}}

" {{{ yank tmp
" http://www.vim.org/scripts/script.php?script_id=1598
" ----------------------------------------
map <silent> Sy :call YanktmpYank()<CR> 
map <silent> Sp :call YanktmpPaste_p()<CR> 
map <silent> SP :call YanktmpPaste_P()<CR> 
" }}}

" vim-test {{{
let test#strategy = 'dispatch'
noremap <leader>tf :TestFile<CR>
noremap <leader>tr :TestNearest<CR>
noremap <leader>r :TestLast<CR>
" }}}

" vim-testing-pair {{{
noremap <C-t> :ToggleTestingPair<CR>
" }}}

" {{{ vim-quickrun
" https://github.com/thinca/vim-quickrun
nmap <expr> <Leader>l ":MyQuickRun \"lint/" . &filetype . "\"<CR>"
nmap <expr> <Leader>c "exec MyQuickRun compile/" . &filetype . "<CR>"

let g:quickrun_config = {}
let g:quickrun_config['runner'] = 'vimproc'
let g:quickrun_config = {
\'_': {
\   'split': '15',
\   'runner': 'vimproc',
\   'runner/vimproc/updatetime': 40,
\   'outputter': 'error',
\   'outputter/error/success': 'buffer',
\   'outputter/error/error': 'quickfix',
\   'outputter/buffer/split': ':botright 8sp',
\   'outputter/buffer/into': 0,
\   'outputter/buffer/running_mark': ':-)',
\   'outputter/buffer/close_on_empty': 1,
\   'outputter/quickfix/close_on_empty': 1,
\   'outputter/quickfix/into': 0,
\   'hook/quickfix_replate_tempname_to_bufnr/enable_exit': 0,
\   'hook/time/enable': 0,
\   'hook/neco/enable': 1,
\   'hook/neco/wait': 20,
\   'hook/neco/echo': 0,
\   'hook/neco/redraw': 1
\ },
\ 'phpunit': {
\ },
\ 'coffee': {
\   'command': 'coffee',
\   'cmdopt': '',
\   'exec': '%c %o %s',
\   'outputter/error/error': 'buffer',
\ },
\ 'haml': {
\   'command': 'haml',
\   'exec': '%c %s'
\ }
\}

let g:quickrun_config['python'] = {
  \ 'command': 'python3',
  \ 'exec': '%c %s',
  \ 'errorformat': '%A\ \ File\ \"%f"\,\ line\ %l%.%#,%Z%[%^\ ]%m'
  \ }

" 
let g:quickrun_config["rspec"] = {
  \ 'command': 'zeus',
  \ 'exec': '%c rspec %s:p',
  \ "errorformat": "rspec\ %f:%l\ #\ %m"
  \}
"

let g:quickrun_config["go"] = {
  \ 'runner': 'vimscript',
  \ 'command': ':GoRun',
  \}

" Lint

  " {{{ ruby
  let g:quickrun_config["lint/ruby"] = {
  \ "command": "ruby",
  \ "exec": "%c -c %s:p > /dev/null",
  \ "errorformat": "%f:%l:\ %m,%f:%l:\ warning:\ %m"
  \}
  " }}}

  " {{{ bash
  let g:quickrun_config["lint/sh"] = {
  \ "command": "/bin/bash",
  \ "exec": "%c %o %s:p",
  \ "cmdopt": "-n",
  \ "errorformat": "%f:\ line\ %l:\ %m"
  \}
  let g:quickrun_config["lint/bash"] = g:quickrun_config["lint/sh"]
  " }}}
  
  " {{{ haml
  let g:quickrun_config["lint/haml"] = {
  \ "command": "haml",
  \ "cmdopt": "-c",
  \ "exec": "%c %o %s:p",
  \ "errorformat": "%f:\ line\ %l:\ %m"
  \}
  " }}}

  " {{{ coffeescript
  let g:quickrun_config["lint/coffee"] = {
  \ "command": "coffee",
  \ "cmdopt": "-c",
  \ "exec": "%c %o %s:p",
  \}

  let g:quickrun_config["compile/coffee"] = {
  \ "command": "coffee",
  \ "cmdopt": "-c -b",
  \ "exec": "%c %o %s",
  \}
  " }}}

  " {{{ go
  let g:quickrun_config["lint/go"] = {
  \ "runner": "vimscript",
  \ "command": ":GoBuild",
  \}
  " }}}

" quickfixウインドを開いてカーソルを元に戻す
function! ShowQuickfix()
  execute 'cclose'
  execute 'cwindow'
  execute 'wincmd p'
endfunction

function! MyQuickRun(args)
  :cclose
  silent! bw! \[quickrun\ output\]
  call quickrun#run(a:args)
endfunction
command! -nargs=1 MyQuickRun :call MyQuickRun(<f-args>)
" }}}

" {{{ NERDTree
nnoremap <F12> :NERDTreeToggle %:p:h<CR>
let NERDTreeWinPos = "right"
let NERDTreeWinSize = 40
" }}}

" {{{ taglist
" http://www.vim.org/scripts/script.php?script_id=273
noremap <F11> :Tlist<CR><C-w><C-w>
" PHPの表示設定
let tlist_php_settings='php;c:class;d:constant;f:function' 
" 現在編集中のソースのタグしか表示しない
let Tlist_Show_One_File = 1
" }}}

" Gtags {{{
"let g:auto_gtags = 1

noremap <C-g>t :Gtags 
" カーソル下の関数定義を探す
noremap <C-g>j :GtagsCursor<CR>
" 関数名から逆引き
noremap <C-g>r :Gtags -r <C-R><C-W><CR>
" ソースの関数一覧
noremap <C-g>f :Gtags -f %<CR>
" grep
noremap <C-g>g :Gtags -g <C-R><C-W><CR>
" override ctags settings
let g:Gtags_Auto_Update = 1
let g:Gtags_Close_When_Single = 1

" }}}

" {{{ php-namespace
" https://github.com/arnaud-lb/vim-php-namespace
" Disable sort to keep the cursor position
let g:php_namespace_sort_after_insert = 0

function! IPhpInsertUse()
  call PhpInsertUse()
  call feedkeys('a',  'n')
endfunction
"autocmd FileType php inoremap <Leader>u <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <Leader>u :call PhpInsertUse()<CR>

function! IPhpExpandClass()
  call PhpExpandClass()
  call feedkeys('a', 'n')
endfunction
"autocmd FileType php inoremap <Leader>e <Esc>:call IPhpExpandClass()<CR>
autocmd FileType php noremap <Leader>e :call PhpExpandClass()<CR>
" }}}

" {{{ Git
nnoremap <leader>gs :Gstatus<CR>5j
" }}}

" ディレクトリがあればこの中に tags ファイルを作成する
"let g:auto_ctags_directory_list = ['.git', '.svn']

filetype plugin indent on
syntax on
