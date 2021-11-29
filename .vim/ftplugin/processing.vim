" QuickRun
let g:quickrun_config['processing'] = {
  \ 'exec': "Dispatch! p5 %s",
  \ 'runner': 'vimscript',
  \ 'outputter': 'null'
  \}

nmap <silent> K <Plug>(processing-keyword)
