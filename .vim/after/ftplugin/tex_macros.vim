imap <C-b> <Plug>Tex_MathBF
imap <C-l> <Plug>Tex_LeftRight
imap <C-c> <Plug>Tex_MathCal

imap <C-f> <Esc>i\mathfrak{<Esc>la}
call IMAP('==', '&=', 'tex')
call IMAP('`w', '\omega', 'tex')
call IMAP('=>', '\Rightarrow', 'tex')
call IMAP('<=', '\Leftarrow', 'tex')
call IMAP('((', '((', 'tex')
call IMAP('[[', '[[', 'tex')
call IMAP('`B', '\boldsymbol', 'tex')
call IMAP('\codts', '\cdots', 'tex')
call IMAP('\theat', '\theta', 'tex')
call IMAP('\tiems', '\times', 'tex')
call IMAP('\maspto', '\mapsto', 'tex')
call IMAP('\cdot', '\cdot', 'tex')

" autocorrect
" ===========
call IMAP('\maspto', '\mapsto', 'tex')

autocmd FileType tex set spell spelllang=en_gb,en_us

