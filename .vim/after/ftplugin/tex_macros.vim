imap <C-b> <Plug>Tex_MathBF
imap <C-l> <Plug>Tex_LeftRight
imap <C-c> <Plug>Tex_MathCal
call IMAP('==', '&=', 'tex')
call IMAP('`w', '\omega', 'tex')
call IMAP('=>', '\Rightarrow ', 'tex')
call IMAP('((', '((', 'tex')
call IMAP('[[', '[[', 'tex')
call IMAP('`B', '\boldsymbol', 'tex')

autocmd FileType tex set spell spelllang=en_gb,en_us

