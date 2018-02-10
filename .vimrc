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
  "autocmd VimEnter,BufNew,BufNewFile,BufReadPost * call s:vimrc_local(expand('<afile>:p:h'))
  autocmd BufWinEnter * call s:vimrc_local(expand('<afile>:p:h'))
  "autocmd VimEnter * call s:vimrc_local(expand('<afile>:p:h'))
augroup END

function! s:vimrc_local(loc)
  let files = findfile('.vimrc.local', escape(a:loc, ' ') . ';', -1)
  for i in reverse(filter(files, 'filereadable(v:val)'))
    source `=i`
  endfor
endfunction
" }}}

" {{{ NeoBundle
set runtimepath+=~/.vim/bundle/neobundle.vim

" Packages
call neobundle#begin(expand('~/.vim/bundle/'))
"NeoBundle 'Shougo/neocomplete'
"NeoBundle 'Shougo/neosnippet'
"NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'garbas/vim-snipmate'
NeoBundle 'MarcWeber/vim-addon-mw-utils'
NeoBundle 'tomtom/tlib_vim'
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'grohiro/vim-testing-pair'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'vim-scripts/gtags.vim'
NeoBundle 'vim-scripts/taglist.vim'
NeoBundle 'fatih/vim-go'
NeoBundle 'Shougo/vimproc.vim', {
			\ 'build' : {
			\     'windows' : 'tools\\update-dll-mingw',
			\     'cygwin' : 'make -f make_cygwin.mak',
			\     'mac' : 'make',
			\     'linux' : 'make',
			\     'unix' : 'gmake',
			\    },
			\ }
NeoBundle 'mattn/emmet-vim'
NeoBundle 'vim-scripts/yanktmp.vim'
NeoBundle 'posva/vim-vue'
NeoBundle 'arnaud-lb/vim-php-namespace'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-dispatch'
NeoBundle 'janko-m/vim-test'
NeoBundle 'afternoon/vim-phpunit'
call neobundle#end()

NeoBundleCheck
" }}}

" {{{ neocomplete
"Note: This option must be set in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 0
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><nul> pumvisible() ? "\<down>" : neocomplete#start_manual_complete()
"let g:neocomplete#enable_auto_select = 1

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
			\ 'default' : '',
			\ 'vimshell' : $HOME.'/.vimshell_hist',
			\ 'scheme' : $HOME.'/.gosh_completions'
			\ }

" Define keyword.
"if !exists('g:neocomplete#keyword_patterns')
	"let g:neocomplete#keyword_patterns = {}
"endif
"let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
"inoremap <expr><C-g>     neocomplete#undo_completion()
"inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
"inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
	return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
	" For no inserting <CR> key.
	"return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
"inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
"inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
"autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
"autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
"if !exists('g:neocomplete#sources#omni#input_patterns')
	"let g:neocomplete#sources#omni#input_patterns = {}
"endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

"if !exists('g:neocomplete#force_omni_input_patterns')
  "let g:neocomplete#force_omni_input_patterns = {}
"endif
"let g:neocomplete#force_omni_input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'


" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
"let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
" }}}

" neosnippet {{{
" 自分用 snippet ファイルの場所
let g:neosnippet#enable_auto_clear_markers = 0
let g:neosnippet#snippets_directory = [
			\ '~/.vim/snippets/',
			\ '~/.vim/bundle/vim-go/gosnippets/snippets/',
			\ '~/.vim/bundle/neosnippet-snippets/neosnippets/',
			\ ]

" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <C-e>     <Plug>(neosnippet_expand_or_jump)
"smap <C-e>     <Plug>(neosnippet_expand_or_jump)
"xmap <C-e>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <C-l>     <Plug>(neosnippet_expand_or_jump)
"imap <expr><TAB>
			"\ neosnippet#jumpable() ?
			"\    "\<Plug>(neosnippet_jump)" : "\<TAB>"
"smap <expr><TAB> neosnippet#jumpable() ?
			"\ "\<Plug>(neosnippet_jump)" : "\<TAB>"

" For conceal markers. (Hide placeholders after expand a snippet)
"if has('conceal')
"set conceallevel=2 concealcursor=niv
"endif

"augroup neosnippet
	"autocmd!
	"autocmd FileType neosnippet setlocal noexpandtab
"augroup end

"
" }}}

" {{{ folding
" 折り畳み (folding) の設定
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
"set fileencodings=iso-2022-jp,utf-8,cp932,euc-jp,ucs-2le,usc-2jp
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
set ignorecase
set smartcase
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

" ctrl-p buffer
nnoremap L :CtrlPBuffer<CR>

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
"inoremap <C-h> <ESC>gT
nnoremap <C-l> gt
"inoremap <C-l> <ESC>gt
" }}}

" quickfix {{{
augroup QfAutoCommands
  autocmd!
  " Auto-close quickfix window
  autocmd WinEnter * if (winnr('$') == 1) && ((getbufvar(winbufnr(0), '&buftype')) == 'quickfix' || (getbufvar(winbufnr(0), '&ft')) == 'quickrun') | quit | endif
augroup END
" }}}

" Plugins 

" {{{ ctrlp
let g:ctrlp_prompt_mappings = {
			\ 'PrtSelectMove("j")': ['<c-n>', '<down>'],
			\ 'PrtSelectMove("k")': ['<c-p>', '<up>'],
			\ 'PrtHistory(-1)':     [],
			\ 'PrtHistory(1)':      []
			\ }
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*,*.md,GTAGS,GPATH,GRTAGS,tags
let g:ctrlp_custom_ignore='\v[\/](node_modules|build|vendor)$'
" 0: Do not clear cache on exit, 1: Clear cache on exit
let g:ctrlp_clear_cache_on_exit = 1
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
"inoremap <leader>tf :TestFile<CR>
noremap <leader>tr :TestNearest<CR>
"inoremap <leader>tr :TestNearest<CR>
noremap <leader>r :TestLast<CR>
"inoremap <leader>r :TestLatt<CR>
" }}}

" vim-testing-pair {{{
noremap <C-t> :ToggleTestingPair<CR>
"inoremap <C-t> :ToggleTestingPair<CR>
" }}}

" {{{ vim-quickrun
" https://github.com/thinca/vim-quickrun
"nmap <C-E> <Leader>r
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
" map <C-\> :GtagsCursor<CR>
" map <C-]> :GtagsCursor<CR>
let g:Gtags_Auto_Update = 1
let g:Gtags_Close_When_Single = 1

" }}}

" {{{ php-namespace
" https://github.com/arnaud-lb/vim-php-namespace
let g:php_namespace_sort_after_insert = 1

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

filetype plugin indent on
syntax on
