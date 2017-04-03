
set errorformat=%f:\ line\ %l\\,\ col\ %c\\,%m
set makeprg=node\ %

let g:quickrun_config["es6"] = {
  \ 'command': 'node',
  \ 'exec': '%c %s:p',
  \}

let g:quickrun_config["lint/es6"] = {
  \ "command": "jshint",
  \ "cmdopt": "",
  \ "exec": "%c %o %s:p",
  \}

