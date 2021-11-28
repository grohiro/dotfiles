
" company/services/building.service.ts[42, 21]: == should be ===
" autocmd! BufWritePost <buffer> :MyQuickRun "lint/typescript"
"set errorformat=%f[%l\\,\ %c]:\ %m

let g:quickrun_config["typescript"] = {
  \ "command": "ts-node",
  \ "cmdopt": "",
  \ "exec": "%c %o %s",
  \ "quickfix/errorformat": "%+A\ %#%f\ %#(%l\\,%c):\ %m,%C%m",
  \}

let g:quickrun_config["lint/typescript"] = {
  \ "command": "`npm bin`/tslint",
  \ "cmdopt": "",
  \ "exec": "%c %o %s:p",
  \ "quickfix/errorformat": '%f[%l\\,\ %c]:\ %m',
  \}

