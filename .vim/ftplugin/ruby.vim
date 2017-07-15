augroup rubycmd
  autocmd!
  autocmd BufWinEnter,BufNewFile *_spec.rb map <Leader>r :QuickRun rspec<CR>
  autocmd BufWinEnter,BufNewFile *_test.rb map <Leader>r :MyQuickRun rails/test<CR>
  "autocmd BufWritePost *.rb :MyQuickRun "lint/ruby"
augroup END

let g:quickrun_config['rails/test'] = {
\ 'command': 'rails',
\ 'cmdopt': 'test',
\ 'exec': "%c %o %s",
\}
