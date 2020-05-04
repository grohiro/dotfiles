" Search the word on Google
" :Googling => Search `<cword>`
" :Googling KEYWORD => Search ``KEYWORD``

function! s:Googling(...)
  if a:0 >= 1
    let word = a:1
  else
    let word = expand('<cword>')
  end

  exec ':Spawn! open https://google.com/search?q='.word
endfunction
command! -nargs=? Googling call s:Googling(<f-args>)
nnoremap <C-g><C-g> :Googling<CR>
