" yank tmp
" http://www.vim.org/scripts/script.php?script_id=1598
" yank/paste text to vim on other process
map <silent> Sy :call YanktmpYank()<CR> 
map <silent> Sp :call YanktmpPaste_p()<CR> 
map <silent> SP :call YanktmpPaste_P()<CR> 
