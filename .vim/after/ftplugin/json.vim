:setlocal foldlevelstart=99
:setlocal foldlevel=99

augroup json
  autocmd!
  autocmd BufRead,BufNewFile *.json set filetype=json
  "autocmd FileType json set foldmarker={,}
augroup END
command! -nargs=? Jq call s:Jq(<f-args>)

" JSON fomatter with jq
" http://qiita.com/tekkoc/items/324d736f68b0f27680b8
function! s:Jq(...)
  if 0 == a:0
    let l:arg = "."
  else
    let l:arg = a:1
  endif
  execute "%! jq \"" . l:arg . "\""
endfunction

let g:quickrun_config["lint/json"] = {
  \ "command": "jq",
  \ "exec": "%c . %s:p > /dev/null",
  \ "errorformat": "parse\ error:\ %m\ at\ line\ %l\\,\ column\ %c"
  \}
