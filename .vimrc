" pathogen plugin installer
if &term =~ '256color'
	set t_ut=
endif

" teach of keys
if &term =~ '^screen'
	" Page keys http://sourceforge.net/p/tmux/tmux-code/ci/master/tree/FAQ
	execute "set t_kP=\e[5;*~"
	execute "set t_kN=\e[6;*~"

	" Arrow keys http://unix.stackexchange.com/a/34723
	execute "set <xUp>=\e[1;*A"
	execute "set <xDown>=\e[1;*B"
	execute "set <xRight>=\e[1;*C"
	execute "set <xLeft>=\e[1;*D"
endif
call pathogen#infect()
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
set vb
set t_Co=256
set background=dark
colorscheme jellybeans 
"colorscheme solarized.orig

set cursorline
"hi Normal ctermbg=none
"hi NonText ctermbg=none
hi Visual ctermbg=darkblue ctermfg=black
hi CursorLine cterm=none ctermbg=black cterm=none

command! -range=% -nargs=0 T2S execute '<line1>,<line2>s#^\t\+#\=repeat(" ", len(submatch(0))*' . &ts . ')'
command! -range=% -nargs=0 S2T execute '<line1>,<line2>s#^\( \{'.&ts.'\}\)\+#\=repeat("\t", len(submatch(0))/' . &ts . ')'
vnoremap // y/<C-R>"<CR>
"noremap <Up> <Nop>
"noremap <Down> <Nop>
"noremap <Left> <Nop>
"noremap <Right> <Nop>
set path+=**
set wildmenu
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_winsize = 25
let g:netrw_altv = 1
let g:netrw_browse_split = 4
cnoremap nt Lexplore <CR>
set mouse=a
