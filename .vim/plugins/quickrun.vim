" QuickRUn
" https://github.com/thinca/vim-quickrun

" QuickRun のウインドウを閉じてから実行する
function! MyQuickRun(args)
  :cclose
  silent! bw! \[quickrun\ output\]
  call quickrun#run(a:args)
endfunction
command! -nargs=1 MyQuickRun :call MyQuickRun(<f-args>)

let g:quickrun_config = {}
let g:quickrun_config['runner'] = 'vimproc'

" {{{ default config
let g:quickrun_config = {
      \'_': {
      \   'split': '15',
      \   'runner': 'vimproc',
      \   'runner/vimproc/updatetime': 40,
      \   'outputter': 'error',
      \   'outputter/error/success': 'buffer',
      \   'outputter/error/error': 'quickfix',
      \   'outputter/buffer/split': ':botright 8sp',
      \   'outputter/buffer/into': 0,
      \   'outputter/buffer/running_mark': ':-)',
      \   'outputter/buffer/close_on_empty': 1,
      \   'outputter/quickfix/close_on_empty': 1,
      \   'outputter/quickfix/into': 0,
      \   'hook/quickfix_replate_tempname_to_bufnr/enable_exit': 0,
      \   'hook/time/enable': 0,
      \   'hook/neco/enable': 1,
      \   'hook/neco/wait': 20,
      \   'hook/neco/echo': 0,
      \   'hook/neco/redraw': 1
      \ },
      \ 'coffee': {
      \   'command': 'coffee',
      \   'cmdopt': '',
      \   'exec': '%c %o %s',
      \   'outputter/error/error': 'buffer',
      \ },
      \ 'haml': {
      \   'command': 'haml',
      \   'exec': '%c %s'
      \ }
      \}
" }}}

let g:quickrun_config["go"] = {
      \ 'command': 'go',
      \ 'cmdopt': 'run',
      \ 'output': 'buffer',
      \}

let g:quickrun_config["lint/go"] = {
      \ 'runner': 'vimscript',
      \ 'command': ':GoBuild',
      \}

let g:quickrun_config['python'] = {
      \ 'command': 'python3',
      \ 'exec': '%c %s',
      \ 'errorformat': '%A\ \ File\ \"%f"\,\ line\ %l%.%#,%Z%[%^\ ]%m'
      \ }

let g:quickrun_config["ruby"] = {
      \ "command": "ruby",
      \ "exec": "%c %o %s:p",
      \}

" bundleで実行したいときは .vimrc.local でこの関数を実行する
function! QuickrunRubyBundle()
  let g:quickrun_config["ruby"] = {
        \ "command": "bundle",
        \ "exec": "%c exec ruby %o %s:p"
        \}
endfunction

let g:quickrun_config["rspec"] = {
      \ 'command': 'zeus',
      \ 'exec': '%c rspec %s:p',
      \ "errorformat": "rspec\ %f:%l\ #\ %m"
      \}

let g:quickrun_config["lint/ruby"] = {
      \ "command": "ruby",
      \ "exec": "%c -c %s:p > /dev/null",
      \ "errorformat": "%f:%l:\ %m,%f:%l:\ warning:\ %m"
      \}

let g:quickrun_config["lint/javascript"] = {
      \ "command": "node",
      \ "cmdopt": "-c",
      \ "exec": "%c %o %s:p",
      \}

let g:quickrun_config["lint/sh"] = {
      \ "command": "/bin/bash",
      \ "exec": "%c %o %s:p",
      \ "cmdopt": "-n",
      \ "errorformat": "%f:\ line\ %l:\ %m"
      \}

let g:quickrun_config["lint/bash"] = g:quickrun_config["lint/sh"]

" coffeescript
let g:quickrun_config["compile/coffee"] = {
      \ "command": "coffee",
      \ "cmdopt": "-c -b",
      \ "exec": "%c %o %s",
      \}

let g:quickrun_config["lint/coffee"] = {
      \ "command": "coffee",
      \ "cmdopt": "-c",
      \ "exec": "%c %o %s:p",
      \}

let g:quickrun_config["lint/haml"] = {
      \ "command": "haml",
      \ "cmdopt": "-c",
      \ "exec": "%c %o %s:p",
      \ "errorformat": "%f:\ line\ %l:\ %m"
      \}

nnoremap <expr> <Leader>qr ":MyQuickRun \"" . &filetype . "\"<CR>"
nnoremap <expr> <Leader>ql ":MyQuickRun \"lint/" . &filetype . "\"<CR>"
nnoremap <expr> <Leader>qc "exec MyQuickRun compile/" . &filetype . "<CR>"

