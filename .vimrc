set nocompatible

let mapleader = "\<Space>"
noremap <C-j> <Esc>
inoremap <C-j> <Esc>
vnoremap <C-j> <Esc>

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

" {{{ plugin initialize

  " {{{ NeoBundle
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#begin(expand('~/.vim/bundle/'))

  " Packages
  NeoBundle 'Shougo/neocomplete'
  NeoBundle 'Shougo/neosnippet'
  NeoBundle 'Shougo/neosnippet-snippets'
  NeoBundle 'Shougo/unite.vim'
  NeoBundleDisable unite.vim
  NeoBundle 'Shougo/vimproc'
  NeoBundle 'b4winckler/vim-angry'
  NeoBundle 'ctrlpvim/ctrlp.vim'
  NeoBundle 'elzr/vim-json'
  NeoBundle 'fatih/vim-go'
  NeoBundle 'grohiro/vim-testing-pair'
  NeoBundle 'janko-m/vim-test'
  NeoBundle 'jelera/vim-javascript-syntax'
  NeoBundleDisable vim-javascript-syntax
  NeoBundle 'jwalton512/vim-blade'
  NeoBundle 'kchmck/vim-coffee-script'
  NeoBundle 'leafgarland/typescript-vim'
  NeoBundle 'mattn/emmet-vim'
  NeoBundle 'scrooloose/nerdtree'
  NeoBundle 'tacroe/unite-mark'
  NeoBundleDisable unite-mark
  NeoBundle 'thinca/vim-quickrun'
  NeoBundle 'thinca/vim-ref'
  NeoBundleDisable vim-ref
  NeoBundle 'thoughtbot/vim-rspec'
  NeoBundle 'tpope/vim-dispatch'
  NeoBundleDisable vim-dispatch
  NeoBundle 'tpope/vim-surround'
  NeoBundle 'tyru/current-func-info.vim'
  NeoBundle 'vim-scripts/Align'
  NeoBundleDisable Align
  NeoBundle 'vim-scripts/gtags.vim'
  NeoBundle 'vim-scripts/taglist.vim'
  NeoBundle 'vim-scripts/yanktmp.vim'
  NeoBundle 'Shougo/vimproc.vim', {
        \ 'build' : {
        \     'windows' : 'tools\\update-dll-mingw',
        \     'cygwin' : 'make -f make_cygwin.mak',
        \     'mac' : 'make',
        \     'linux' : 'make',
        \     'unix' : 'gmake',
        \    },
        \ }

  call neobundle#end()
  filetype plugin indent on
  NeoBundleCheck
  " }}}

  " {{{ neocomplete
    "Note: This option must be set in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
    " Disable AutoComplPop.
    let g:acp_enableAtStartup = 0
    " Use neocomplete.
    let g:neocomplete#enable_at_startup = 1
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
    if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns['default'] = '\h\w*'

    " Plugin key-mappings.
    inoremap <expr><C-g>     neocomplete#undo_completion()
    inoremap <expr><C-l>     neocomplete#complete_common_string()

    " Recommended key-mappings.
    " <CR>: close popup and save indent.
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
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
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

    " Enable heavy omni completion.
    if !exists('g:neocomplete#sources#omni#input_patterns')
      let g:neocomplete#sources#omni#input_patterns = {}
    endif
    "let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
    "let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
    "let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

    " For perlomni.vim setting.
    " https://github.com/c9s/perlomni.vim
    let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
  " }}}

" neosnippet {{{
  " 自分用 snippet ファイルの場所
  let g:neosnippet#enable_auto_clear_markers = 0
  let g:neosnippet#snippets_directory = [
        \ '~/.vim/snippet/',
        \ '~/.vim/bundle/vim-go/gosnippets/snippets/',
        \ '~/.vim/bundle/neosnippet-snippets/neosnippets/',
        \ ]

  " Plugin key-mappings.
  " Note: It must be "imap" and "smap".  It uses <Plug> mappings.
  imap <C-l>     <Plug>(neosnippet_expand_or_jump)
  smap <C-l>     <Plug>(neosnippet_expand_or_jump)
  xmap <C-l>     <Plug>(neosnippet_expand_target)

  " SuperTab like snippets behavior.
  " Note: It must be "imap" and "smap".  It uses <Plug> mappings.
  imap <C-l>     <Plug>(neosnippet_expand_or_jump)
  imap <expr><TAB>
    \ neosnippet#expandable_or_jumpable() ?
    \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
  smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

  " For conceal markers. (Hide placeholders after expand a snippet)
  "if has('conceal')
    "set conceallevel=2 concealcursor=niv
  "endif

  augroup neosnippet
    autocmd!
    autocmd FileType neosnippet setlocal noexpandtab
  augroup end
  
"
" }}}

  " {{{ vim-symfony
  " change default open cmd
  let g:vim_symfony_action_default_open_cmd = 'tabnew'
  let g:vim_symfony_view_default_open_cmd = 'tabnew'
  let g:vim_symfony_model_default_open_cmd = 'tabnew'
  let g:vim_symfony_form_default_open_cmd = 'tabnew'
  let g:vim_symfony_filter_default_open_cmd = 'tabnew'
  let g:vim_symfony_partial_default_open_cmd = 'tabnew'
  let g:vim_symfony_component_default_open_cmd = 'tabnew'
  " }}}

  " {{{ yank tmp
  " http://www.vim.org/scripts/script.php?script_id=1598
  " ----------------------------------------
  map <silent> Sy :call YanktmpYank()<CR> 
  map <silent> Sp :call YanktmpPaste_p()<CR> 
  map <silent> SP :call YanktmpPaste_P()<CR> 
  " }}}

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

  " vim-test {{{
  let g:test#preserve_screen = 1
  nmap <silent> <leader>t :TestNearest<CR>
  nmap <silent> <leader>T :TestFile<CR>
  nmap <silent> <leader>l :TestLast<CR>
  nmap <silent> <leader>g :TestVisit<CR>
  let test#strategy = {
    \ 'nearest': 'vimproc',
    \ 'file':    'vimproc',
    \ 'suite':   'vimproc',
    \}

  " }}}

  " vim-testing-pair {{{
  noremap <C-t> :ToggleTestingPair<CR>
  "
" }}}
"
" {{{ showmarks 
  " Disable plugin mappings
  " http://stackoverflow.com/questions/16059716/vim-remove-mapping-created-by-vim-plugin#comment22920168_16059873
  noremap <Plug>ShowmarksShowMarksToggle <Plug>ShowmarksShowMarksToggle
  noremap <Plug>ShowmarksShowMarksOn <Plug>ShowmarksShowMarksOn
  noremap <Plug>ShowmarksClearMark <Plug>ShowmarksClearMark
  noremap <Plug>ShowmarksClearAll <Plug>ShowmarksClearAll
  noremap <Plug>ShowmarksPlaceMark <Plug>ShowmarksPlaceMark
" }}}

" }}}

" {{{ definitions

let fname = bufname("%")

" CSVの指定列をハイライト表示する
function! CSVH(x)
    execute 'match Keyword /^\([^,]*,\)\{'.a:x.'}\zs[^,]*/'
    execute 'normal ^'.a:x.'f,'
endfunction
command! -nargs=1 Csvhl :call CSVH(<args>)
" }}}

" {{{ map

noremap <C-x><C-v> :source ~/.vimrc<CR>
noremap <C-x><C-b> :tabnew ~/.vimrc<CR>
noremap <F9> :ccl<CR>

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

" {{{ behavior
" 編集中でも他のファイルを表示
set hidden 
" ファイルタイプ検出機能
"filetype on
" コマンドモード補完機能の設定
set wildmode=list:full
" バックアップファイルを作らない
set nobackup
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

"autocmd BufReadPost *
"\ if line("'\"") > 0 && line ("'\"") <= line("$") |
    "\ exe "normal g'\"" |
"\ endif

set wrap

" set the number of history.
set history=100

set splitbelow

" 勝手に改行しない
set formatoptions=q

" スクロールする時に下が見えるようにする
set scrolloff=3
" OSのクリップボードを使う
"set clipboard=unnamed,autoselect
" 移動コマンドを使ったとき、行頭に移動しない
set nostartofline
" 対応括弧に<と>のペアを追加
"set matchpairs& matchpairs+=<:>
" インデントをshiftwidthの倍数に丸める
set shiftround
" 行頭の余白内で Tab を打ち込むとshiftwidthの数だけインデントする
set smarttab

" マルチバイトで崩れる問題を修正
set ambiwidth=double
"
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
set statusline=%f%m%{GetStatusEx()}\ %r\ line\ %l\ of\ %L\ %{cfi#format(\"(%s)\",\"\")}

set breakindent

" }}}

" {{{ buffer
"nnoremap <C-h> <ESC>:bp<CR>
"nnoremap <C-l> <ESC>:bn<CR>
"nnoremap L <ESC>:ls<CR>:buf 
" }}}

" {{{ tab
" nnoremap T :tabnew<CR>:NERDTreeCWD<CR><ESC><C-w>h
nnoremap T :tabnew<CR>
nnoremap <C-h> gT
nnoremap <C-l> gt
" }}}

" {{{ search
" Incremental Search
set incsearch
" 検索文字のハイライト禁止
set hlsearch
" 大/小文字を無視
set ignorecase
" 検索文字に大文字が含まれているときは大/小文字を区別する
set smartcase
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

" {{{ folding
" 折り畳み (folding) の設定
set foldmethod=marker
set foldmarker={{{,}}}
set foldlevelstart=0
" }}}

" color {{{
" use 256 colors
syntax enable
set t_Co=256
"set background=dark
"let g:solarized_termcolors=256
"colorscheme desert2
"colorscheme jellybeans
colorscheme default

" highlight
"hi Folded ctermbg=6 ctermfg=0
"hi Pmenu ctermbg=4
"hi PmenuSel ctermbg=1
"hi PMenuSbar ctermbg=4
" listchars の tabとか
highlight SpecialKey ctermfg=235
" listchars の eol
highlight NonText ctermfg=239

highlight coffeeSpecialIdent ctermfg=4
" コメント行
highlight Comment ctermfg=28
" 行番号
highlight LineNr ctermfg=239
" Folding
highlight Folded ctermbg=237 ctermfg=103

" }}}
"
" marks {{{
let g:showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
 
" mark auto reg
" http://saihoooooooo.hatenablog.com/entry/2013/04/30/001908
if !exists('g:markrement_char')
    let g:markrement_char = [
    \     'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
    \     'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
    \ ]
endif
nnoremap <silent>mm :<C-u>call <SID>AutoMarkrement()<CR>
function! s:AutoMarkrement()
    if !exists('b:markrement_pos')
        let b:markrement_pos = 0
    else
        let b:markrement_pos = (b:markrement_pos + 1) % len(g:markrement_char)
    endif
    execute 'mark' g:markrement_char[b:markrement_pos]
    echo 'marked' g:markrement_char[b:markrement_pos]
endfunction
" }}}

" coding

" {{{ coding

" {{{ editing
" 対応する括弧をハイライト
"set showmatch

" }}}

" {{{ indent
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set autoindent
set nosmartindent
" }}}

" {{{ ctags
set tags+=tags,tags;/
"nnoremap <C-]> g<C-]>
"nnoremap <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
"nnoremap <C-\> :tab split<CR>:GtagsCursor<CR>
" }}}

" replace {{{
" Visual選択した部分を囲むための置換正規表現
" }}}

"
" }}}

" file format settings

" {{{ Makefile
if fname == "Makefile"
    set noexpandtab
endif
" }}}

" HTML {{{
augroup html
  autocmd!
  autocmd FileType html set commentstring=<!--%s-->
  autocmd FileType html set ai
  "autocmd FileType html set equalprg=tidy\ -i\ -wrap\ 120\ -q\ -raw\ --show-errors\ 0
  "autocmd FileType html set makeprg=tidy\ -quiet\ -e\ %
  "autocmd BufRead,BufNewFile *.html syntax include @Jquery ~/.vim/syntax/jquery.vim
  "autocmd BufRead,BufNewFile *.html syntax region JavaScript start="\<script.*\>" end="\</script\>" contains=@Jquery
augroup END
" }}}

" {{{ Angular2 Component
augroup angular2
  autocmd!
  autocmd BufNewFile *.component.ts 0r $HOME/.vim/template/component.ts
augroup END
" }}}

"autocmd BufRead,BufNewFile *.as set filetype=actionscript

" {{{ MacVim
if has('gui_macvim')
	set showtabline=2 " タブを常に表示
	set transparency=2 " 透明度
	set imdisable " IMEをOff
	" set guioptions=-T " ツールバー非表示

	set columns=150 " 横幅
	set lines=45 " 高さ

	colorscheme blackbg

	" フォント設定

	" font 1
	" set guifont=Osaka-Mono:h14

	" font 2
	" set guifontwide=Osaka:h12
	" set guifont=Osaka-Mono:h14

	" font 3
	" set guifont=Monaco:h12
	
	" font 4
	set guifont=Osaka-Mono:h16
	set guifontwide=ヒラギノ丸ゴ\ ProN\ W4:h16
endif
" }}}

" functions

" Plugins

"source $VIMRUNTIME/macros/matchit.vim

" {{{ NERDTree
nnoremap <F12> :NERDTreeToggle %:p:h<CR>
let NERDTreeWinPos = "right"
let NERDTreeWinSize = 40
" }}}

" {{{ Align
let g:Align_xstrlen = 3
" }}}

" {{{ Source Explorer
" ----------------------------------------
" http://vim.sourceforge.net/scripts/script.php?script_id=2179
" let g:SrcExpl_UpdateTags = 1
" }}}

" {{{ taglist
" ----------------------------------------
" http://www.vim.org/scripts/script.php?script_id=273
noremap <F11> :Tlist<CR><C-w><C-w>

" PHPの表示設定
let tlist_php_settings='php;c:class;d:constant;f:function' 

" 現在編集中のソースのタグしか表示しない
let Tlist_Show_One_File = 1
" }}}

" {{{ vim-quickrun
" https://github.com/thinca/vim-quickrun
nmap <C-E> <Leader>r
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
"\   'outputter/quickfix/open_cmd': 'call ShowQuickfix()',

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
  "
  " {{{ php
  let g:quickrun_config["lint/php"] = {
  \ "command": "phplint",
	\ "cmdopt": "",
  \ "exec": "%c %o %s:p",
  \ "errorformat": "%A%m\ in\ %f\ on\ line\ %l,%-GFile\\,%m,\"%f\"\\,%l\\,%c\\,%*\\w\\,\"%m\"\\,%*[a-z0-9A-Z\.]\\,%*\\d\\,%*\\d,%Z,%f:%l%%m,%f:%l%m"
  \}
  " }}}
  
  " {{{ ruby
  let g:quickrun_config["lint/ruby"] = {
  \ "command": "ruby",
  \ "exec": "%c -c %s:p > /dev/null",
  \ "errorformat": "%f:%l:\ %m,%f:%l:\ warning:\ %m"
  \}
  " }}}

  " {{{ phpunit
  let g:quickrun_config['phpunit'] = {
  \ 'command': 'phpunit',
  \ 'cmdopt': '',
  \ 'exec': "%c %o %s | sed -e '1d' -e '/^\\$/d' -e '/^Time:/d'",
  \ 'errorformat': "%f:%l%m"
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
  call quickrun#run(a:args)
endfunction
command! -nargs=1 MyQuickRun :call MyQuickRun(<f-args>)
"command! -nargs=1 MyQuickRun echo g:quickrun_config
" }}}

" quickfix {{{
" Open in tab
"set switchbuf+=usetab,newtab

" Quickfixしかなければ閉じる
" http://hail2u.net/blog/software/vim-auto-close-quickfix-window.html
augroup QfAutoCommands
  autocmd!
  " Auto-close quickfix window
  autocmd WinEnter * if (winnr('$') == 1) && ((getbufvar(winbufnr(0), '&buftype')) == 'quickfix' || (getbufvar(winbufnr(0), '&ft')) == 'quickrun') | quit | endif
augroup END


" }}}

" VimOutliner {{{
" https://github.com/vimoutliner/vimoutliner
augroup VimOutliner
  autocmd!
  autocmd FileType vo_base set tabstop=2
  autocmd FileType vo_base set shiftwidth=2
  autocmd FileType vo_base set softtabstop=2
  autocmd FileType vo_base set expandtab
augroup END
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

" {{{ vim-ref
let g:ref_cache_dir= '~/.vim/vim-ref/cache/'
let g:ref_phpmanual_path = '~/.vim/vim-ref/php/'
let g:ref_phpmanual_cmd = 'cat %s'
" }}}
"
" {{{ vim-rspec
let g:rspec_command = "!bundle exec rspec {spec}"
" }}}

" Unite {{{
let g:unite_enable_start_insert = 1
nnoremap [unite] <Nop>
nmap <Leader>u  [unite]
nnoremap <silent> [unite]b :Unite buffer<CR>
nnoremap <silent> [unite]r :Unite register<CR>
nnoremap [unite]f :Unite file_mru<CR>
nnoremap [unite]m :Unite mark<CR>
" }}}

