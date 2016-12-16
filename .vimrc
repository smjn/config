" pathogen plugin installer
call pathogen#infect()
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
set vb
set t_Co=256
set background=dark
colorscheme molokai
"colorscheme solarized.orig
set cursorline
hi Normal ctermbg=none
hi NonText ctermbg=none
hi Visual ctermbg=darkblue ctermfg=black
hi CursorLine cterm=none ctermbg=black cterm=none

command! -range=% -nargs=0 T2S execute '<line1>,<line2>s#^\t\+#\=repeat(" ", len(submatch(0))*' . &ts . ')'
command! -range=% -nargs=0 S2T execute '<line1>,<line2>s#^\( \{'.&ts.'\}\)\+#\=repeat("\t", len(submatch(0))/' . &ts . ')'
