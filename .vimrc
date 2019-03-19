set nocompatible

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
let g:auto_gtags = 1

" dein {{{
set runtimepath+=~/.vim/dein.vim

if dein#load_state('~/.vim/dein.vim')
  call dein#begin('~/.vim/dein.vim')
  call dein#load_toml('~/.vim/dein.toml', {'lazy': 0})
  call dein#end()
  call dein#save_state()
endif

" Install plugins if there are new plugins
if dein#check_install()
  call dein#install()
endif
" }}}

filetype indent plugin on

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

" インデントをshiftwidthの倍数に丸める
set shiftround

" 行頭の余白内で Tab を打ち込むとshiftwidthの数だけインデントする
set smarttab

" マルチバイトで崩れる問題を修正
set ambiwidth=double

set nobackup
set noundofile

set wildignore=*.pyc
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
syntax enable
colorscheme default
set bg=dark
hi SpecialKey ctermfg=DarkGrey
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
"noremap <C-x><C-v> :source ~/.vimrc<CR>
"noremap <C-x><C-b> :tabnew ~/.vimrc<CR>
noremap <silent><F9> :ccl<CR>:silent! bw! \[quickrun\ buffer\]<CR>

" c*でカーソル下のキーワードを置換
nnoremap <expr> c* ':%s /\<' . expand('<cword>') . '\>/'
vnoremap <expr> c* ':s /\<' . expand('<cword>') . '\>/'
nnoremap CC :lcd<CR>

nnoremap M :call ToggleWindowSize()<CR>

let g:toggle_window_size = 0
function! ToggleWindowSize()
  if g:toggle_window_size == 1
    exec "normal \<C-w>="
    let g:toggle_window_size = 0
  else
    :resize
    :vertical resize
    let g:toggle_window_size = 1
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

let g:autotagmaxTagsFileSize = 33400320

" {{{ vim-dispatch
let g:dispatch_quickfix_height = 15
" }}}

" {{{ fzf.vim
set rtp+=/usr/local/Cellar/fzf/0.17.4
nnoremap <C-p> :GFiles<CR>
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
let g:test#custom_runners = {'Solidity': ['Truffle']}
" }}}

" vim-testing-pair {{{
"noremap <C-t> :ToggleTestingPair<CR>
" }}}

" {{{ vim-quickrun
" https://github.com/thinca/vim-quickrun
nnoremap <expr> <Leader>e ":MyQuickRun \"" . &filetype . "\"<CR>"
nnoremap <expr> <Leader>l ":MyQuickRun \"lint/" . &filetype . "\"<CR>"
nnoremap <expr> <Leader>c "exec MyQuickRun compile/" . &filetype . "<CR>"

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
  let g:quickrun_config["ruby"] = {
    \ "command": "bundle",
    \ "exec": "%c exec ruby %s:p",
  \}

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
let NERDTreeIgnore=['\~$', '.pyc$']
" }}}

" {{{ taglist
" http://www.vim.org/scripts/script.php?script_id=273
noremap <F11> :Tlist<CR><C-w><C-w>
" PHPの表示設定
let tlist_php_settings='php;c:class;d:constant;f:function' 
let tlist_solidity_settings='solidity;c:contract;f:function'
" 現在編集中のソースのタグしか表示しない
let Tlist_Show_One_File = 1
" }}}

" Gtags {{{
noremap <C-g>t :Gtags 
" カーソル下の関数定義を探す
noremap <C-g>j :GtagsCursor<CR>
" 関数名から逆引き
noremap <C-g>r :Gtags -r <C-R><C-W><CR>
" ソースの関数一覧
noremap <C-g>f :Gtags -f %<CR>
" grep
noremap <C-g>g :Gtags -g <C-R><C-W><CR>
" }}}

" {{{ php-namespace
" https://github.com/arnaud-lb/vim-php-namespace
" Disable sort to keep the cursor position
let g:php_namespace_sort_after_insert = 0
let g:php_namespace_expand_to_absolute = 1

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

" {{{ UltiSnips
let g:UltiSnipsSnippetsDir = $HOME.'/.vim/UltiSnips'
let g:UltiSnipsExpandTrigger = "<C-l>"
let g:UltiSnipsListSnippets = "<C-t>"
let g:UltiSnipsJumpForwardTrigger = "<Tab>"
let g:UltiSnipsJumpBackwardTrigger= "<S-Tab>"
" }}}

" {{{ completor
let g:completor_auto_trigger = 0
let g:completor_doc_position = 'top'
let g:completor_set_options = 0
let g:completor_min_chars = 1
inoremap <expr> <C-o> pumvisible() ? "<C-N>" : "<C-r>=completor#do('complete')<CR>"
" show popup, no preview window, select the first item
set completeopt=menu
" }}}

" {{{ vim-terraform
let g:terraform_fmt_on_save = 1
let g:terraform_align = 1
" }}}


" ディレクトリがあればこの中に tags ファイルを作成する
"let g:auto_ctags_directory_list = ['.git', '.svn']

let g:WebDevIconsUnicodeDecorateFolderNodes = 1

set complete=.,b

"autocmd BufWritePost * :cclose

augroup phpcmd
  autocmd!
  autocmd FileType php set errorformat=%A%m\ in\ %f\ on\ line\ %l,%Z
  autocmd FileType php set makeprg=php\ -l\ %
  autocmd FileType php set suffixesadd=.php
augroup END

autocmd FileType yaml set ts=2 sw=2 sts=2 expandtab
