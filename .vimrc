" vim: noexpandtab sw=8 ts=8 sts=8
" .vimrc -- Teijo Laine (aropupu@aropupu.fi)

let os = substitute(system('uname'), "\n", "", "")

if os == "Linux"
	language en_US.UTF-8
elseif os == "Darwin"
	language en_US
endif

syntax on		" Use syntax highlighting

execute pathogen#infect()
syntax on
filetype plugin indent on

let mapleader=","
map <Leader>t :CommandT<Enter>
map <Leader>v :execute 'silent !tmux send-keys -t .-1 "\!\!" Enter'<Bar>redraw!<C-M>

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
set listchars=nbsp:¬,tab:>-,extends:»,precedes:«,trail:•
set list

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

highlight Tab ctermfg=blue guifg=blue cterm=underline gui=underline
highlight UglySyntax ctermbg=green guibg=green
highlight MixedWhitespace ctermbg=cyan guibg=cyan
highlight ExtraWhitespace ctermbg=red guibg=red	cterm=reverse	ctermfg=red	ctermbg=red	gui=reverse

if has("autocmd")
	au BufEnter *.c,*.h		set cindent sts=4 sw=4 ts=4 et
	au BufEnter *.cpp,*.hpp		set cindent sts=4 sw=4 ts=4 et
	au BufEnter *.cljs		set sts=2 sw=2 ts=2 et syntax=clojure
	au BufEnter *.rb,*.sass,*.haml	set sts=2 sw=2 ts=2 et
	au BufEnter *.yml		set sts=2 sw=2 ts=2 et tw=0 syntax=yaml
	au BufEnter *.sh		set sts=2 sw=2 ts=2 et
	au BufEnter *.ls		set sts=2 sw=2 ts=2 et syntax=ls
	au BufEnter *.js,*.css		set sts=2 sw=2 ts=2 et tw=0
	au BufEnter *.jsp,*.ftl,*.html	set sts=2 sw=2 ts=2 noexpandtab tw=0
	au BufEnter *.ftl		set filetype=ftl
	au BufEnter *.cpd,*.cdt,*.cst	set filetype=c
	au BufEnter *.a38,*.a86		set filetype=asm
	au BufEnter *.j2		set syntax=jinja
	au BufRead,BufNewFile *.scala	set filetype=scala et ts=2 sts=2 sw=2

	au InsertEnter *	syn match ExtraWhitespace /\s\+\%#\@<!$/
	au BufEnter *		syn match MixedWhitespace / \+\ze\t\|\t \+/
	au BufEnter *		syn match UglySyntax /if(\|else{\|}else\|for(\|){\|\,[^ ]\|( \| )/
	au BufEnter,InsertLeave *	syn match ExtraWhitespace /\s\+$/ containedin=ALL
	au VimEnter *		syn match Tab /\t/ containedin=ALL
endif

" Inline compile-on-save script from
" http://markhansen.co.nz/autocompiling-haml/
au BufWritePost *.haml call HamlMake()
function! HamlMake()
    py << ENDOFPYTHON
import os
import vim
in_file = vim.current.buffer.name
dirname = os.path.dirname(in_file)
if os.path.exists(dirname + "/.autohaml"):
    out_file = in_file[0:-5] + ".html"
    os.system("haml %s > %s" % (in_file, out_file))
ENDOFPYTHON
endfunction
