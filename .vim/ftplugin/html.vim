augroup html
  autocmd!
  autocmd FileType html set commentstring=<!--%s-->
  autocmd FileType html set ai
  "autocmd FileType html set equalprg=tidy\ -i\ -wrap\ 120\ -q\ -raw\ --show-errors\ 0
  "autocmd FileType html set makeprg=tidy\ -quiet\ -e\ %
  "autocmd BufRead,BufNewFile *.html syntax include @Jquery ~/.vim/syntax/jquery.vim
  "autocmd BufRead,BufNewFile *.html syntax region JavaScript start="\<script.*\>" end="\</script\>" contains=@Jquery
augroup END
