" https://github.com/prabirshrestha/asyncomplete.vim
call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
  \ 'name': 'ultisnips',
  \ 'whitelist': ['*'],
  \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
  \ }))
