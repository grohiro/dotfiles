let test#ruby#minitest#file_pattern = 'test_*.rb'

let g:quickrun_config['rails/test'] = {
\ 'command': 'rails',
\ 'cmdopt': 'test',
\ 'exec': "%c %o %s",
\}

" QuickRun lint のコマンドとして rubucop を使用する
function! UseRubocopLint()
  let b:quickrun_config = {
    \ "command": "bundle",
    \ "cmdopt": "exec rubocop",
    \ "exec": "%c %o %s:p"
  \}
endfunction

