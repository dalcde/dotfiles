filetype plugin on
set nocp
set grepprg=grep\ -nh\ $*
filetype indent on
let g:tex_flavor='latex'
set breakindent
set autoindent
syntax on
set expandtab
set shiftwidth=4
set softtabstop=4
set winaltkeys=no
set title
set titleold=Terminal
set foldmethod=syntax
set foldlevelstart=0
set foldlevel=0
let javaScript_fold=1

autocmd FileType c set shiftwidth=2|set softtabstop=2
autocmd FileType html set shiftwidth=2|set softtabstop=2
autocmd FileType xml set shiftwidth=2|set softtabstop=2
autocmd FileType text set spell spelllang=en_gb,en_us

let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_MultipleCompileFormats='pdf'
let g:Tex_CompileRule_pdf='pdflatex -interaction=nonstopmode -shell-escape $*'
let g:Tex_ViewRule_pdf='mupdf'
let Tex_FoldedEnvironments = 'tikzpicture'
let Tex_FoldedSections = 'chapter,section,%%fakesecftion,subsection,subsubsection,paragraph'
let Tex_FoldedMisc = 'preamble,<<<'

let g:Tex_Env_lemma = "\\begin{lemma}\<CR><++>\<CR>\\end{lemma}<++>"
let g:Tex_Env_defi = "\\begin{defi}[<++>]\<CR><++>\<CR>\\end{defi}<++>"
let g:Tex_Env_thm = "\\begin{thm}[<++>]\<CR><++>\<CR>\\end{thm}<++>"
let g:Tex_Env_tabular = "\\begin{tabular}{<++>}\<CR><++>\<CR>\\end{tabular}<++>"
let g:Tex_Env_pp = "\\begin{pp}{<++>}{<++>}\<CR><++>\<CR>\\end{pp}<++>"
let g:Tex_Env_enumerater = "\\begin{enumerate}[resume]\<CR>\\item <++>\<CR>\\end{enumerate}<++>"


autocmd FileType tex set shiftwidth=2|set softtabstop=2
autocmd FileType tex set spell spelllang=en_gb,en_us
autocmd FileType tex call Tex_MakeMap("<Leader>ll", ":w <CR> <Plug>Tex_Compile", 'n', '<buffer>')
autocmd FileType asm set ft=nasm

set wildmenu
set wildmode=longest,list
set ignorecase
set smartcase 
cmap w!! w !sudo tee % >/dev/null
nnoremap Q <nop>
colorscheme ron
set hidden

command Gen !./gen.sh %
command Sync !./sync.sh `echo % | cut -f1 -d'.'`*
command GenSync w | !(./gen.sh % >/dev/null 2>&1 && ./sync.sh `echo % | cut -f1 -d'.'`* >/dev/null 2>&1 && notify-send "Sync complete %") &
