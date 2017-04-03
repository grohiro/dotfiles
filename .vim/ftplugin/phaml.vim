function! MakePHaml()
  !phaml %
endfunction
augroup phaml
  autocmd!
  autocmd bufRead,BufNewFile *.phaml set filetype=haml
  autocmd BufWritePost *.phaml silent call MakePHaml()
augroup END
