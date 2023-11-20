"if executable('pyls')
    "" pip install python-language-server
    "au User lsp_setup call lsp#register_server({
        "\ 'name': 'pyls',
        "\ 'cmd': {server_info->['pyls']},
        "\ 'allowlist': ['python'],
        "\ })
"endif
"
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    "setlocal signcolumn=yes
    "" 有効にすると PhpInsert が動かない
    ""if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
"
    "nmap <buffer> gd <plug>(lsp-definition)
    "nmap <buffer> <f2> <plug>(lsp-rename)
    ""vmap <buffer> <leader>lf <plug>(lsp-document-format)
    "" refer to doc to add more commands
endfunction
"
augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
"
let g:lsp_auto_enable = 1

let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_echo_delay = 500
let g:lsp_diagnostics_signs_enabled = 1
let g:lsp_document_highlight_delay = 500

"let g:lsp_signs_enabled = 1

"let g:lsp_text_edit_enabled = 0

" Key mappings
noremap <leader>la :LspCodeAction<CR>
noremap <leader>lc :LspDeclaration<CR>
noremap <leader>ld :LspDefinition<CR>
noremap <leader>lf :LspDocumentFormat<CR>
noremap <leader>ln :LspNextDiagnostic<CR>
noremap <leader>lp :LspPreviousDiagnostic<CR>
noremap K :LspHover<CR>
nmap gd <plug>(lsp-definition)
nmap <f2> <plug>(lsp-rename)
"vmap <buffer> <leader>lf <plug>(lsp-document-format)

" Completion
"let g:lsp_async_completion = 1
"let g:asyncomplete_auto_popup = 0

" debug
"let g:lsp_log_verbose = 3
"let g:lsp_log_file = expand('~/.vim/lsp.log')
"let g:asyncomplete_log_file = expand('~/.vim/asyncomplete.log')

"inoremap <silent><expr> <C-l> asyncomplete#force_refresh()

" Phpactor
"let g:deoplete#enable_at_startup = 0
"let g:deoplete#sources = {}
"let g:deoplete#sources.php = ['omni', 'phpactor', 'ultisnips', 'buffer']
"
"let g:lsp_settings_filetype_php = ['psalm-language-server', 'intelephense']
