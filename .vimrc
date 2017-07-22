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

" pathogen plugin installer
call pathogen#infect()

set vb
set t_Co=256
set background=dark
colorscheme solarized
"colorscheme solarized.orig

set cursorline
set cursorcolumn
"hi Normal ctermbg=3
"hi NonText ctermbg=none
hi Visual ctermbg=8 ctermfg=2
hi CursorLine cterm=none ctermbg=0 cterm=none

"vnoremap // y/<C-R>"<CR>
"noremap <Up> <Nop>

"file search
set path+=**
set wildmenu

"enable mouse
"set mouse=a

"syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_js_checkers=['jslint']
let g:syntastic_go_checkers = ['go', 'govet', 'errcheck']
let g:syntastic_quiet_messages = {"level":"warnings"}
let g:tern_show_argument_hints='on_hold'
let g:tern_map_keys=1
"syntastic end

"nerdtree
map <C-n> :NERDTreeToggle<CR>
"nerdtree end

"neocomplete start
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3

if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.java = '\k\.\k*'
let g:neocomplete#force_omni_input_patterns.scala = '\k\.\k*'
"neocomplete end

"airline start
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline_powerline_fonts = 1
"airline end

"vim go start
let g:go_fmt_command = "goimports"
"vim go end

"nerdcommenter start
let g:NERDSpaceDelims = 1
let g:NERDCommentEmptyLines = 1
let g:NERDDefaultAlign = 'left'
"nerdcommenter end

"general mappings & remaps
map <C-i> gg=G<CR>
nmap <F4> :w<CR>:make<CR>:cw<CR>
command! -range=% -nargs=0 T2S execute '<line1>,<line2>s#^\t\+#\=repeat(" ", len(submatch(0))*' . &ts . ')'
command! -range=% -nargs=0 S2T execute '<line1>,<line2>s#^\( \{'.&ts.'\}\)\+#\=repeat("\t", len(submatch(0))/' . &ts . ')'
"mappings done

