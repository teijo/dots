" vim: noexpandtab sw=8 ts=8 sts=8
" .vimrc -- Teijo Laine (aropupu@aropupu.fi)

if has("language")
	language english " Use english due to the prompts
endif
syntax on		" Use syntax highlighting

let mapleader=","
map <Leader>t :CommandT<Enter>
map <Leader>v :execute 'silent !tmux send-keys -t .-1 ./view.sh Enter'<Bar>redraw!<C-M>

set autoindent		" Autoindent
set background=dark	" Set the colour schema to something reasonable
set bs=2		" Allow backspacing over everything in insert mode
set complete=.,w,b,t	" Word completion rules
set errorbells		" Signal errors
set guifont=courier_new:h12 " Font for gui vim
set hlsearch		" Highlight matching search patterns
set ignorecase		" Case-insensitive searching.
set incsearch		" Search while typing '/<search>' instead of after hitting return.
set infercase		" Correct case during completion
set laststatus=2	" Status line only when there are two windows
set magic		" Some regexp characters (like '(') need to be backslashed in order to work.
set matchtime=50	" Set show match time to 5 seconds
set nobackup		" Don't leave backup files in dir (swap files " work well enough for recovery)
set nocompatible	" Vim defaults
set noexpandtab		" Use tabs
set nojoinspaces	" Joining won't care about punctuation (.!?)
set nomore		" Do not pause screenfulls of output
set noruler		" No ruler (status line)
set scrolloff=2		" Set number of scroll padding lines
set shiftround		" Shift at columns that are indent multiples
set shiftwidth=8	" How many characters auto-indent indents.
set shortmess=aOtI	" Shorter messages
set showbreak=<<<<	" At the beginning of a wrapping line
set showmatch		" Show matching parens for short time
set showmode		" Display active mode like -- INSERT -- on status row.
set smartcase		" Upper case chars in search string turn search to case-sensitive.
set smarttab		" Spaces at beginning of line, tabs elsewhere
set softtabstop=8	" Tab expand size in spaces.
set tabstop=8		" Visible tab length in characters.
set textwidth=78	" The column at which 'gqq' wraps with a newline.
set viminfo='50,h
set visualbell		" Visual flash instead of noisy bell.
set wildmenu		" When using tab auto fill for filenames, list all options.
set wildmode=list:longest   " List all options like ls does. Tab fill by longest match.
set winwidth=80		" Minimum window (split) width when active
set winheight=24	" Minimum window (split) height when active
set tags=../../../tags,../../tags,../tags,./tags,tags	" ctags sources
set encoding=utf-8

nmap <Right> :vimgrep <cword> `find . -type f -exec grep -Iq '' '{}' ';' -print`<CR>:copen<CR>
nmap <Down> :cclose<CR>
nmap <Leader>d :tag <cWORD><CR>

" C indent options
set cinoptions=(0	" Indent lines following '(' to same level as the '('

colorscheme elflord	" Dark default color scheme
set t_Co=256

if has("statusline")
  set statusline=%<%F%=%([%M%R%H%W]\ %)%l,%c%V\ %P\ (%n)
endif			" Set statusline format
if has("mouse")
  set mouse=a		" Allow mouse in all modes.
  set nomousehide	" Don't hide the mouse when typing.
endif

" Gui features

if has("gui_running")
	" Take some advantage of the room in gui mode
	set lines=80
	set columns=120
	set nowrap
	set nonumber
	"set winwidth=86 " Extra width from the line numbers

	set guioptions-=m " No menubar
	set guioptions-=l " No left scrollbar
	set guioptions-=L " .. even if vertical split
	set guioptions-=r " No right scrollbar
	set guioptions-=b " No bottom scrollbar
	set guioptions+=c " Console dialogs
	set guioptions-=e " Console dialogs
	set guioptions-=T " No toolbar
endif

" Colors

hi LineNr	guifg=orange	guibg=darkred	ctermfg=black	ctermbg=gray
hi StatusLine	ctermfg=white	ctermbg=red	guifg=black	guibg=gray
hi StatusLineNC	ctermfg=gray	ctermbg=darkred	guifg=gray	guibg=black
hi Folded	guibg=yellow	guifg=red
hi VertSplit	guifg=black	guibg=gray


" Integrated color scheme
	hi clear
"	set background=light
	if exists("syntax_on")
		syntax reset
	endif
	let g:colors_name = "aro"

" Dark colors
	hi Normal	guifg=#DDDDDD	guibg=#111111
	hi Comment	guifg=#33FF33			gui=italic
	hi Constant	guifg=#FF0099			gui=bold
	hi Identifier	guifg=#6699FF			gui=none
	hi Ignore	guifg=bg
	hi PreProc	guifg=#CC33FF			gui=bold
	hi Search	guifg=#FFFFFF	guibg=#FF0000
	hi Special	guifg=#FF0000
	hi Statement	guifg=#FF9900 " Control structure
	hi Type		guifg=#3399FF
	hi Todo		guifg=#3399FF	guibg=#FFFF00
	" From the source:
	hi Cursor	guifg=#000000	guibg=#00FF00
	hi CursorLine	guibg=#EEEEEE
	hi Directory	guifg=#006699
	hi DiffAdd	guifg=#336633	guibg=#99FF99
	hi DiffChange	guifg=#000000	guibg=#CCCC00
	hi DiffDelete	guifg=#CC6666	guibg=#FFCCCC
	hi DiffText	guifg=#FFFFFF	guibg=#999900
	hi ErrorMsg	guifg=#FFFFFF	guibg=#FF0000
	hi IncSearch					gui=reverse
	hi LineNr	guifg=#CCCCCC	guibg=#666666
	hi ModeMsg					gui=bold
	hi MoreMsg	guifg=#006699			gui=bold
	hi NonText	guifg=#3399FF	guibg=#222222	gui=bold
	hi Question	guifg=#006699			gui=bold
	hi SpecialKey	guifg=#006699
	hi StatusLine	guifg=#EEEEEE	guibg=#666666	gui=bold
	hi StatusLineNC	guifg=#CCCCCC	guibg=#333333	gui=none
	hi Title	guifg=Pink			gui=bold
	hi WarningMsg	guifg=Red
	hi Visual	guifg=white	guibg=#009900	gui=bold
	hi Function	guifg=#3399FF
	hi Repeat	guifg=#FF9900			gui=bold " Control structure
	hi Operator	guifg=#663300			gui=bold
	hi Folded	guifg=#333333	guibg=#FFCC00	gui=italic
	hi VertSplit	guifg=#333333	guibg=#666666
	hi TabLineSel	guifg=#EEEEEE	guibg=#666666	gui=bold
	hi TabLine	guifg=#CCCCCC	guibg=#333333
	hi TabLineFill	guifg=#333333	guibg=#333333
	hi WildMenu	guifg=#333333	guibg=#FF0000

" Gui and cli compatible colors
hi Error	ctermfg=darkred	ctermbg=yellow	guifg=#FFFF00	guibg=#FF0000

if has("autocmd")
	au BufEnter *.c,*.h		set cindent
	au BufEnter *.cpp,*.hpp		set cindent sts=4 sw=4 ts=4 et
	au BufEnter *.rb,*.sass,*.haml	set sts=2 sw=2 ts=2 et
	au BufEnter *.sh		set sts=2 sw=2 ts=2 et
	au BufEnter *.js,*.css		set sts=2 sw=2 ts=2 et tw=0
	au BufEnter *.jsp,*.ftl,*.html	set sts=2 sw=2 ts=2 noexpandtab tw=0
	au BufEnter *.ftl		set filetype=ftl
	au BufEnter *.cpd,*.cdt,*.cst	set filetype=c
	au BufEnter *.a38,*.a86		set filetype=asm
	au BufRead,BufNewFile *.scala	set filetype=scala et ts=2 sts=2 sw=2
endif

" Highlight invalid whitespace
highlight Tab ctermfg=blue guifg=blue cterm=underline gui=underline
highlight UglySyntax ctermbg=green guibg=green
highlight MixedWhitespace ctermbg=cyan guibg=cyan
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace  /\s\+$/

autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
"autocmd BufWinLeave * call clearmatches()

autocmd Syntax * syn match MixedWhitespace / \+\ze\t\|\t \+/

"autocmd Syntax * syn match UglySyntax /if(\|else(\|for(\|while(/
autocmd Syntax * syn match UglySyntax /if(\|else{\|}else\|for(\|){\|\,[^ ]\|( \| )/
autocmd Syntax * syn match Tab /\t/


