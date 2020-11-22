so ~/vimrc.local
if &term =~ '256color'
	set t_ut=
endif

""""" teach of keys for different environments (tmux)
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
""""" end teaching keys

""""" from https://github.com/junegunn/vim-plug README
call plug#begin('~/.vim/plugged')

""""" start easy-align - plugin for align around a character fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
""""" easy-align end

""""" start syntastic - plugin for static syntax checks for multiple languages
Plug 'vim-syntastic/syntastic'
"syntastic statusline info
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set cursorline
"syntastic global flags, related to actions
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers=['jshint']
" let g:syntastic_go_checkers = ['go', 'govet', 'errcheck']
let g:syntastic_quiet_messages = {"level":"warnings"}
let g:tern_show_argument_hints='on_hold'
let g:tern_map_keys=1
""""" end syntastic

""""" start nerdtree 
Plug 'scrooloose/nerdtree'
"handy shortcut for nerd tree
map <C-n> :NERDTreeToggle<CR>
""""" end nerdtree

""""" start neocomplete - for autocomplete from history/docs/fs
Plug 'Shougo/neocomplete'
"neocomplete config
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3

if !exists('g:neocomplete#force_omni_input_patterns')
	let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.java = '\k\.\k*'
let g:neocomplete#force_omni_input_patterns.scala = '\k\.\k*'
""""" end neocomplete

""""" start vim-airline - for status bar
Plug 'vim-airline/vim-airline'
"airline config
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline_powerline_fonts = 1
""""" end vim-airline


""""" start vim-go
" Plug 'fatih/vim-go', { 'tag': 'v1.19', 'do': ':GoUpdateBinaries' }
"vim-go config
" let g:go_fmt_command = "goimports"
""""" end vim-go

""""" start gocode
" Plug 'mdempsky/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }
""""" end gocode

" start closetag - to insert end tags in web markup
Plug 'alvan/vim-closetag'
"closetag config
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.htm'
""""" end closetag

""""" start vm-jsbeautify - for web scripting
Plug 'maksimr/vim-jsbeautify'
"vim-jsbeautify config
autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
" for json
autocmd FileType json noremap <buffer> <c-f> :call JsonBeautify()<cr>
" for jsx
autocmd FileType jsx noremap <buffer> <c-f> :call JsxBeautify()<cr>
" for html
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
" for css or scss
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>
""""" end vm-jsbeautify

""""" start snippets
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
""""" end snippets

""""" start comments plugin
Plug 'tpope/vim-commentary'
""""" end comments

""""" start surround
Plug 'tpope/vim-surround'
""""" end surround

""""" start ctrlp - fast file search
Plug 'kien/ctrlp.vim'
""""" end ctrlp

""""" start colorschemes - large collection of vim co
Plug 'flazz/vim-colorschemes'
""""" end colorschemes

""""" start solorized theme - better solorized 
Plug 'lifepillar/vim-solarized8'
""""" end solarized

"python stuff
" Plug 'python-mode/python-mode'
"end python stuff

"begin rainbow parens
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1
"end rainbow parens

"begin clojure mode
Plug 'guns/vim-clojure-static'
"end clojure mode

"begin autoclose/autopair
" Plug 'jiangmiao/auto-pairs'
"end autoclose/autopair

call plug#end()

""""" some ui stuff
"so entire background looks better
" set background=dark

"custom stuff
"theme name
colorscheme jellybeans
hi Visual ctermbg=4 ctermfg=0
"show some characters instead of white space
set listchars=tab:>~,nbsp:_,trail:.,extends:<,precedes:-
set list
""""" end ui stuff

"tab shorts from https://www.youtube.com/watch?v=1QD3u6NC5KU
nnoremap tn :tabnew<Space>

nnoremap tk :tabnext<CR>
nnoremap tj :tabprev<CR>

nnoremap th :tabfirst<CR>
nnoremap tl :tablast<CR>

nnoremap \s :SyntasticToggleMode<CR>
