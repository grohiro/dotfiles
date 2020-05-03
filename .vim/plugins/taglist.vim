" taglist
" http://www.vim.org/scripts/script.php?script_id=273

" 現在編集中のソースのタグしか表示しない
let Tlist_Show_One_File = 1

" ファイルタイプ別の表示設定
let tlist_php_settings      = 'php;c:class;d:constant;f:function'
let tlist_solidity_settings = 'solidity;c:contract;f:function'

noremap <F11> :Tlist<CR><C-w><C-w>

