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
  autocmd FileType php setlocal omnifunc=phpactor#Complete
augroup END

augroup python
  autocmd!
augroup END
