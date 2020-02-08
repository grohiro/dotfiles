function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> <f2> <plug>(lsp-rename)
    "vmap <buffer> <leader>lf <plug>(lsp-document-format)
    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

let g:lsp_auto_enable = 1

let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1

let g:lsp_signs_enabled = 1

let g:lsp_text_edit_enabled = 0

" Key mappings
noremap <leader>lc :LspDeclaration<CR>
noremap <leader>ld :LspDefinition<CR>
noremap <leader>la :LspCodeAction<CR>
"inoremap <silent> <leader>la <C-R>=:LspCodeAction<CR>
noremap K :LspHover<CR>

" Completion
let g:lsp_async_completion = 1
let g:asyncomplete_auto_popup = 0

" debug
let g:lsp_log_verbose = 0
let g:lsp_log_file = expand('~/.vim/lsp.log')
let g:asyncomplete_log_file = expand('~/.vim/asyncomplete.log')

inoremap <silent><expr> <C-l> asyncomplete#force_refresh()

" Phpactor
"let g:deoplete#enable_at_startup = 0
"let g:deoplete#sources = {}
"let g:deoplete#sources.php = ['omni', 'phpactor', 'ultisnips', 'buffer']
