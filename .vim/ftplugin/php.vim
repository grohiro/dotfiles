augroup phpcmd
  autocmd!
  autocmd FileType php set ai
  autocmd FileType php set dictionary=$HOME/.vim/dict/PHP.dict
  " PEAR ctags
  autocmd FileType php set tags+=$HOME/.vim/tags/pear.tags
  " PHPファイルのエラー文フォーマット
  " (<C-P>でエラーが発生した場合に行へジャンプ)
  autocmd FileType php set errorformat=%A%m\ in\ %f\ on\ line\ %l,%Z
  autocmd FileType php set makeprg=php\ -l\ %
  autocmd FileType php set nosmartindent
  " ファイル保存時に QuickRun を実行する
  "autocmd BufWritePost *.php :MyQuickRun "lint/php"
  " PHPUnit
  "autocmd BufWinEnter,BufNewFile *Test.php set filetype=phpunit
  "autocmd BufWinEnter,BufNewFile *Test.php map <Leader>r :MyQuickRun phpunit<CR>
  autocmd BufWinEnter,BufNewFile *Test.php map <Leader>r :MyQuickRun phpunit<CR>
  "autocmd FileType phpunit set syntax=php
  "autocmd FileType phpunit map <Leader>r ":QuickRun phpunit <CR>"
augroup END

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

