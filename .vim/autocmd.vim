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
  autocmd FileType php setl ts=4 sts=4 sw=4

  autocmd FileType php inoremap <C-s><C-u> <Esc>:call IPhpInsertUse()<CR>
  autocmd FileType php noremap <Leader>u :call PhpInsertUse()<CR>
  autocmd FileType php inoremap <silent> <C-p>u <Esc>:call PhpInsertUse()<CR>a
  autocmd FileType php inoremap <C-s><C-e> <Esc>:call IPhpExpandClass()<CR>
  autocmd FileType php noremap <Leader>e :call PhpExpandClass()<CR>
augroup END

augroup python
  autocmd!
augroup END

augroup golang
  autocmd!

  au Filetype go setl noexpandtab
  au FileType go setl nolist

  "au FileType go nunmap K
  au FileType go nmap <leader>i <plug>(go-info)
  au FileType go nmap <leader>r <Plug>(go-run)
  au FileType go nmap <leader>b <Plug>(go-build)
  au FileType go nmap <leader>t <Plug>(go-test)
  au FileType go nmap <leader>c <Plug>(go-coverage)
  au FileType go nmap <Leader>ds <Plug>(go-def-split)
  au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
  au FileType go nmap <Leader>dt <Plug>(go-def-tab)
  au FileType go nmap <Leader>gd <Plug>(go-doc)
  au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
  au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
  au FileType go nmap <leader>l <Plug>(go-lint)
augroup END

autocmd FileType Makefile setl ts=2 sw=2 sts=2 noexpandtab

augroup yaml.swagger
  autocmd!
  au FileType yaml.swagger set foldmethod=indent
  au FileType yaml.swagger set foldlevel=1
augroup END

