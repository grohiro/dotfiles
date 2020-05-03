" grohiro/toggle-window-size

let g:toggle_window_size = 0

function! ToggleWindowSize()
  if g:toggle_window_size == 1
    exec "normal \<C-w>="
    let g:toggle_window_size = 0
  else
    :resize
    :vertical resize
    let g:toggle_window_size = 1
  endif
endfunction

nnoremap M :call ToggleWindowSize()<CR>
