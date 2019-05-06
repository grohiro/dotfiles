" 選択範囲を引数にして phpvar を実行する。
function! PhpVar()
  let tmp = @@
  silent normal gvy
  let s = @@
  let @@ = tmp
  let s = substitute(s, "'", "\\'", 'g')
  let s = substitute(s, "\n", "\\\n", 'g')
  echo system("echo '". s . "' | phpvar")
endfunction
command! PhpVar :call PhpVar()
vnoremap <Leader>pv <ESC>:call PhpVar()<CR>

" QuickRun
let g:quickrun_config["lint/php"] = {
\ "command": "phplint",
\ "cmdopt": "",
\ "exec": "%c %o %s:p",
\ "errorformat": "%A%m\ in\ %f\ on\ line\ %l,%-GFile\\,%m,\"%f\"\\,%l\\,%c\\,%*\\w\\,\"%m\"\\,%*[a-z0-9A-Z\.]\\,%*\\d\\,%*\\d,%Z,%f:%l%%m,%f:%l%m"
\}

let g:quickrun_config['phpunit'] = {
\ 'command': 'phpunit',
\ 'cmdopt': '',
\ 'exec': "%c %o %s",
\ "errorformat": 'PHP\ Fatal\ error:\ %m\ in\ %f\ on\ line\ %l,%f:%l,%-GPHPUnit%.%#,%-GFAILURES!%.%#,%-GTime:\ %.%#,%-G,%f:%l',
\ "outputter/error/success": 'quickfix'
\}
"\ "errorformat": 'PHP\ Fatal\ error:\ %m\ in\ %f\ on\ line\ %l,%A%[0-9])\ %.%#,%+CFailed\ %m,%Z%f:%l,%C%m,%-C,%-GPHPUnit%.%#,%-GFAILURES!%.%#,%-GTime:\ %.%#,%-G,%f:%l',
"\ "errorformat": '%A%[0-9])\ %.%#,%+CFailed\ %m,%Z%f:%l,%C%m,%-C,%-GPHPUnit%.%#,%-GFAILURES!%.%#,%-GTime:\ %.%#,%-G',
"'exec': "%c %o %s | sed -e '1d' -e '/^\\$/d' -e '/^Time:/d'",

" https://github.com/arnaud-lb/vim-php-namespace
" Disable sort to keep the cursor position
let g:php_namespace_sort_after_insert = 0
let g:php_namespace_expand_to_absolute = 1

function! IPhpInsertUse()
  call PhpInsertUse()
  call feedkeys('a', 'n')
endfunction

function! IPhpExpandClass()
  call PhpExpandClass()
  call feedkeys('a', 'n')
endfunction
