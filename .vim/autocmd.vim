augroup html
  autocmd!
  autocmd BufNew,BufRead *.html.erb :UltiSnipsAddFiletypes erb
augroup END

augroup yaml
  autocmd!
  autocmd FileType yaml setl sw=2 ts=2 sts=2 expandtab
augroup END

augroup php
  autocmd!
  "autocmd FileType php setl omnifunc=phpactor#Complete
  autocmd FileType php setl errorformat=%A%m\ in\ %f\ on\ line\ %l,%Z
  autocmd FileType php setl makeprg=php\ -l\ %
  autocmd FileType php setl makeprg=phpunit
  autocmd FileType php setl suffixesadd=.php

  autocmd FileType php inoremap <C-s><C-u> <Esc>:call IPhpInsertUse()<CR>
  autocmd FileType php noremap <Leader>u :call PhpInsertUse()<CR>
  autocmd FileType php inoremap <C-s><C-e> <Esc>:call IPhpExpandClass()<CR>
  autocmd FileType php noremap <Leader>e :call PhpExpandClass()<CR>
augroup END

augroup python
  autocmd!
augroup END
