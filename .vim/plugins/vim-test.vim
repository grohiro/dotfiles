" vim-test
" https://github.com/vim-test/vim-test
"
let test#strategy         = 'dispatch'
let g:test#custom_runners = {'Solidity': ['Truffle']}

noremap <leader>tf :TestFile<CR>
noremap <leader>tr :TestNearest<CR>
noremap <leader>r  :TestLast<CR>
