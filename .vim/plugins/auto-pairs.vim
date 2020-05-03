" auto-pairs
" https://github.com/jiangmiao/auto-pairs
let g:AutoPairsFlyMode = 0
let g:AutoPairsMultilineClose = 0

noremap <leader>ap :call AutoPairsToggle()<CR>
"imap ˜ <M-n>
"imap ´ <M-e>
imap ∫ <M-b>
inoremap <silent> « <C-r>=MoveToNextChar('}')<CR>
inoremap <silent> ª <C-r>=MoveToNextChar(')')<CR>
noremap <silent> ª :call MoveToNextChar(')')<CR>
"inoremap <buffer> <silent> «« <C-r>=MoveToNextChar(']')<CR>
