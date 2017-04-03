function! MakeHaml()
  make % `basename % haml`html
endfunction

augroup haml
  autocmd!
  autocmd FileType haml compiler haml
  autocmd BufWritePost *.haml silent call MakeHaml()
augroup END
