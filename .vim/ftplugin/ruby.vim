augroup rubycmd
  autocmd!
  autocmd BufWinEnter,BufNewFile *_spec.rb map <Leader>r :QuickRun rspec<CR>
  "autocmd BufWritePost *.rb :MyQuickRun "lint/ruby"
augroup END
