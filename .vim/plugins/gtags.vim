" https://github.com/vim-scripts/gtags.vim/blob/master/plugin/gtags.vim
" https://github.com/zebult/auto-gtags.vim

let g:auto_gtags = 1
" 
noremap <C-g>t :Gtags 
" カーソル下の関数定義を探す
noremap <C-g>j :GtagsCursor<CR>
" 関数名から逆引き
noremap <C-g>r :Gtags -r <C-R><C-W><CR>
" ソースの関数一覧
noremap <C-g>f :Gtags -f %<CR>
" grep
noremap <C-g>g :Gtags -g <C-R><C-W><CR>
