let test#ruby#minitest#file_pattern = 'test_*.rb'

let g:quickrun_config['rails/test'] = {
\ 'command': 'rails',
\ 'cmdopt': 'test',
\ 'exec': "%c %o %s",
\}
