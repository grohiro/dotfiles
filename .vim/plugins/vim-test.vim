" vim-test
" https://github.com/vim-test/vim-test
"
let test#strategy         = 'make'
let test#strategy         = 'basic'
let test#strategy         = 'vimproc'
let test#strategy         = 'vimterminal'
let test#strategy         = 'dispatch'
"let g:test#custom_runners = {'Solidity': ['Truffle']}

noremap <leader>tf :TestFile<CR>
noremap <leader>tr :TestNearest<CR>
noremap <leader>r  :TestLast<CR>
