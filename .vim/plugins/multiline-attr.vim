function! SplitTagAttribute()
  let region = emmet#util#searchRegion('<\S', '>')
  if !emmet#util#regionIsValid(region) || !emmet#util#cursorInRegion(region)
    return ''
  endif
  let content = emmet#util#getContent(region)
  let content = matchstr(content,  '^<[^><]\+>')
  if content !~# '^<[^><]\+>$'
    return ''
  endif
  let current = emmet#lang#html#parseTag(content)
  if content =~ '/>$'
    let current.empty = 1
  endif

  " TODO quotation
  let q = '"'

  let html = '<'.current.name
  for name in emmet#util#unique(current.attrs_order + keys(current.attr))
    if !has_key(current.attr, name)
      continue
    endif
    let html .= "\n"
    let Val = current.attr[name]
    if type(Val) == 2 && Val == function('emmet#types#true')
      unlet Val
      let Val = 'true'
      if g:emmet_html5
        let html .= name
      else
        let html .= name . '=' . q . name . q
      endif
    else
      let html .= name . '=' . q . Val . q
    endif
  endfor

  if current.empty
    let html .= "\n/>\n"
  else
    let html .= "\n>\n"
  endif

  " Indent
  let line = getline(region[0][0])
  let indent = matchstr(line, '^\s*') . emmet#getIndentation()
  let html = substitute(html, "[\r\n]", "\n".indent, 'g')

  call emmet#util#setContent(region, html)
endfunction

nnoremap <silent> <C-y>m :call SplitTagAttribute()<CR>

" <div class="foo" style="color: white">Content</div><span>v-icon</span>
