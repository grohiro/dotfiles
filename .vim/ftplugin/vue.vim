" :call VueFoldExpr(v:lnum)
function! VueFoldExpr(lnum) abort
  let line = getline(a:lnum)
  if match(line, '^<\(template\|script\|style\)>') >= 0
    return ">1"
  elseif match(line, '^<\(style\( scoped\)\?\)>') >= 0
    return ">1"
  elseif match(line, '^</\(template\|script\|style\)>') >= 0
    return "<1"
  elseif match(line, '\(components\|page\|computed\|methods\|watch\|props\): {') >= 0
    return ">2"
  elseif match(line, '\(data\|mounted\|created\|destroyed\|head\)() {') >= 0
    return ">2"
  elseif match(line, '\(mixins\): [') >= 0
    return ">2"
  elseif match(line, '^import') >= 0
    return ">2"
  elseif match(line, '^\s\s[}\]],$') >= 0
    return "<2"
  elseif match(line, '^};$') >= 0
    return "<2"
  elseif match(line, '^export\sdefault') >= 0
    return "<2"
  else
    return -1
  endif
endfunction

set foldmethod=expr
set foldexpr=VueFoldExpr(v:lnum)
