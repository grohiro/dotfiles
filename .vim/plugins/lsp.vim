
let g:lsp_auto_enable = 0

let g:lsp_diagnostics_enabled = 0
let g:lsp_diagnostics_echo_cursor = 1

let g:lsp_signs_enabled = 1

let g:lsp_text_edit_enabled = 0

" Key mappings
"noremap <leader>lc :LspDeclaration<CR>
"noremap <leader>ld :LspDefinition<CR>
"noremap <leader>la :LspCodeAction<CR>
"inoremap <silent> <leader>la <C-R>=:LspCodeAction<CR>

" Completion
let g:lsp_async_completion = 1
let g:asyncomplete_auto_popup = 0

" debug
"let g:lsp_log_verbose = 1
"let g:lsp_log_file = expand('~/.vim/lsp.log')
"let g:asyncomplete_log_file = expand('~/.vim/asyncomplete.log')

  "inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
  "inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
  "inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"
  "function! s:check_back_space() abort
    "let col = col('.') - 1
    "return !col || getline('.')[col - 1]  =~ '\s'
  "endfunction

  "inoremap <silent><expr> <TAB>
        "\ pumvisible() ? "\<C-n>" :
        "\ <SID>check_back_space() ? "\<TAB>" :
        "\ asyncomplete#force_refresh()
  "inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
  inoremap <silent><expr> <C-l> asyncomplete#force_refresh()

  "au User lsp_setup call lsp#register_server({
    "\ 'name': 'intelephense',
    "\ 'cmd': {server_info->['node', expand('~/.anyenv/envs/nodenv/versions/12.4.0/lib/node_modules/intelephense/lib/intelephense.js'), '--stdio']},
    "\ 'initialization_options': {'storagePath': expand('~/.cache/intelephense')},
    "\ 'whitelist': ['php'],
    "\ 'config': {'snippets': 1},
    "\ })
  "au User lsp_setup call lsp#register_server({
      "\ 'name': 'php-language-server',
      "\ 'cmd': {server_info->['php', expand('~/.vim/plugged/php-language-server/bin/php-language-server.php')]},
      "\ 'whitelist': ['php'],
      "\ 'config': {'snippets': 1},
      "\ })
  "au User lsp_setup call lsp#register_server({
    "\ 'name': 'ms-python-lsp',
    "\ 'cmd': {server_info->[expand('~/.local/bin/pyls')]},
    "\ 'initialization_options': {},
    "\ 'whitelist': ['python', 'py'],
    "\ 'config': { 'snippets': 1 },
    "\ })
"
" Phpactor
"let g:deoplete#enable_at_startup = 0
"let g:deoplete#sources = {}
"let g:deoplete#sources.php = ['omni', 'phpactor', 'ultisnips', 'buffer']
