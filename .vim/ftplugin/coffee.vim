augroup coffeescript
  autocmd!
  autocmd BufRead,BufNewFile,BufReadPre *.coffee set ft=coffee
  "autocmd BufWritePost *.coffee silent CoffeeMake! -c | cwindow | redraw!
  "autocmd BufWritePost *.coffee :QuickRun "compile/coffee"
  autocmd BufRead *.coffee set expandtab
  "autocmd FileType coffeebare if &ft == 'coffeebare' | let coffee_make_options='-c -b' | endif
  autocmd FileType coffee set errorformat=%E%f:%l:%c:\ error:\ %m,%C%s,%p^
augroup END

let coffee_make_options='-b'

