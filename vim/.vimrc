"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VUNDLE
"__   ___   _ _ __   __| | | ___
"\ \ / / | | | '_ \ / _` | |/ _ \
" \ V /| |_| | | | | (_| | |  __/
"  \_/  \__,_|_| |_|\__,_|_|\___|

" https://github.com/VundleVim/Vundle.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required
set modelines=0
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" 'vim +PluginInstall +qall' on terminal or :PluginInstall on vim to install a
" plugin

" USER plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"https://github.com/jiangmiao/auto-pairs
Plugin 'jiangmiao/auto-pairs'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-airline
" https://github.com/vim-airline/vim-airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" themes: https://github.com/vim-airline/vim-airline/wiki/Screenshots
let g:airline_theme='simple'
" fav themes: simple/monochrome/minimalist/serene

" if using a powerline font
let g:airline_powerline_fonts = 1

" disables "trailing" on airline (2 below lines = 2 ways to disable)
let g:airline#extensions#whitespace#enabled = 0
"let g:airline_section_warning=''

" :h airline
" if using monochrome theme, if not, comment below
"let g:airline_left_sep = ''
"let g:airline_left_alt_sep = ''
"let g:airline_right_sep = ''
"let g:airline_right_alt_sep = ''

" uncomment below to change symbol characters
let g:airline_symbols = {}
let g:airline_symbols.linenr = '≡:'

" if not using tabs, comment below
"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#show_splits = 1
"let g:airline#extensions#tabline#show_buffers = 1
"let g:airline#extensions#tabline#show_tab_type = 0
"let g:airline#extensions#tabline#show_tabs = 0
"let g:airline#extensions#tabline#show_tab_count = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'ap/vim-css-color'

" ctrl+f to use
"NERDTree
nmap <c-f> :NERDTree<CR>
imap <c-f> <Esc>:NERDTree<CR>

Plugin 'preservim/nerdtree'
let NERDTreeQuitOnOpen=1

Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'junegunn/fzf.vim'

""""""
Plugin 'terryma/vim-multiple-cursors'
" https://github.com/terryma/vim-multiple-cursors#installation
"start: <C-n> start multicursor and add a virtual cursor + selection on the match
"next: <C-n> add a new virtual cursor + selection on the next match
"skip: <C-x> skip the next match
"prev: <C-p> remove current virtual cursor + selection and go back on previous match
"select all: <A-n> start multicursor and directly select all matches
"
"after selecting everything you want, press shitf + I to interact
"""""""

" disable if in a terminal that doesn't support icons 
Plugin 'ryanoasis/vim-devicons'

" Enter key to enter/exit goyo
"map <ENTER> :Goyo<CR>

"Plugin 'junegunn/goyo.vim'

""""""
"Plugin 'junegunn/limelight.vim'
"let g:limelight_conceal_ctermfg = 'gray'
"let g:limelight_conceal_ctermfg = 240
"
"function! s:goyo_enter()
"  if executable('tmux') && strlen($TMUX)
"    silent !tmux set status off
"    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
"    set noshowmode
"    set noshowcmd
"  endif
"  set scrolloff=999
"  Limelight
"endfunction
"
"function! s:goyo_leave()
"  if executable('tmux') && strlen($TMUX)
"    silent !tmux set status on
"    silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
"    set showmode
"    set showcmd
"  endif
"  set scrolloff=5
"  Limelight!
"  set background=dark
"endfunction
"
"autocmd! User GoyoEnter nested call <SID>goyo_enter()
"autocmd! User GoyoLeave nested call <SID>goyo_leave()
"""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" VimCompletesMe
" https://github.com/ackyshake/VimCompletesMe
autocmd FileType vim let b:vcm_tab_complete = 'vim'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM
"       _
"__   _(_)_ __ ___
"\ \ / / | '_ ` _ \
" \ V /| | | | | | |
"  \_/ |_|_| |_| |_|
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set number
syntax on
filetype indent plugin on
set wrapmargin=8
set tabstop=4 softtabstop=0 expandtab smarttab
set shiftwidth=4
" fixes mouse for ST terminal
set ttymouse=sgr

" case ignore
set ignorecase
" useful if ignorecase is enabled. If you type a capitalized word, it will
" only match capitalized words
set smartcase

" only on a truecolor terminal
"set termguicolors

" Auto completition
set wildmode=longest,list,full

" Fix splitting
set splitbelow splitright

"set cursorline
"set cursorcolumn
"highlight CursorLine ctermbg=black cterm=bold guibg=#2b2b2b
"highlight CursorColumn ctermbg=black cterm=bold guibg=#2b2b2b

" enables backspace to delete characters in insert mode
set backspace=3

" Minimal number of screen lines to keep above and below the cursor.
set scrolloff=5

" Highlight selected matches
set hlsearch
" set ctrl+l to clear search
nnoremap <C-l> :nohl<CR><C-l>:echo "Search Cleared"<CR>
imap <C-l> <Esc>:nohl<CR>

" when its enabled, the copy key is the vim key yank, y
" Enable mouse scrolling
set mouse=a

" Stop vim from creating a new line
set textwidth=0 wrapmargin=0

" To wrap lines visually (i.e. the line is still one line of text, but Vim displays it on multiple lines) [DEFAULT].
set wrap

" To display long lines as just one line (i.e. you have to scroll horizontally to see the entire line).
":set nowrap

" Before trying to use system clipboard, check if installed vim is compatible
" use: vim --version | grep 'clipboard'
" if theres +clipboard, with a + not a -, its compatible, if not, do:
" git clone https://github.com/vim/vim.git
" cd vim
" make distclean
" ./configure --enable-gui=no --with-x --prefix=/usr
" make && sudo make install
" Use system clipboard
set clipboard=unnamedplus

" Fix different colors (brown) with urxvt
set background=dark

" Vertically center document when entering insert mode
""autocmd InsertEnter * norm zz

" Remove trailing (useless) whitespaces on save
" (causes weird movment when saving
"autocmd BufWritePre * %s/\s\+$//e

"Autorun code on save
"autocmd BufWritePost *.sh !clear;sh %
"autocmd BufWritePost *.py !clear;python %

"Automatically run xrdb /.Xresouces when the file is changed
autocmd BufWritePost .Xresources !xrdb %

" auto apply tmux conf
autocmd BufWritePost ~/.tmux.conf !tmux source-file %
autocmd BufWritePost ~/.tmux.conf.local !tmux source-file %


" auto compile .c files
"autocmd BufWritePost *.c !gcc %

"Set spaces for different file types
autocmd Filetype html set softtabstop=0 expandtab shiftwidth=2 smarttab

autocmd BufRead */polybar/config set syntax=dosini
autocmd BufRead */.i3/config set syntax=dosini
autocmd BufRead */.i3/config* set syntax=dosini

" disable vim to change window title
set notitle

"Disable :X to encryption and make it write and quit, like :x
cnoreabbrev <expr> X (getcmdtype() is# ':' && getcmdline() is# 'X') ? 'x' : 'X'

:command Q q
:command W w


" Key maps

"quit after save
nmap <c-q> :q<CR>
imap <c-q> <Esc>:q<CR>

"save/write file and "move" to the next character (actually stays where it was
"before saving, because the default behaviour is to go to the previous
"character)
nmap <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>l

"set M to show all marks using fzf
nnoremap M :Marks<CR>

"map ctrl backspace to delete word, like ctrl w
noremap! <C-BS> <C-w>
noremap! <C-h> <C-w>

"map "a" to act like "i" and switch to insert mode
nmap a i

"""""""""""""""
"" clipboard
"""""""""""""""
"prevent x, in normal and visual mode, to yank while deleting
nnoremap x "_x
vnoremap x "_x

"prevent ci (change in ...) from yaking the selection
nnoremap ci "_ci

"since p pastes the content after the letter the cursor is, P is more useful than p
nnoremap p P
nnoremap P p

" Shortcut for replace command
nnoremap S :%s///gc<Left><Left><Left><Left>

"Run code on CTRL X
"nnoremap <buffer> <c-x> :exec '!clear;python' shellescape(@%, 1)<cr>

" Move selected lines with CTRL up and down
xnoremap <C-Up> :move '<-2<CR>gv-gv
xnoremap <C-Down> :move '>+1<CR>gv-gv

" Removes Q binding
nnoremap Q <nop>

"Keyboard shortcuts
"https://unix.stackexchange.com/questions/93144/exit-vim-more-quickly
"Put this 3 lines to your ~/.bashrc or ~/.zshrc:
" bind -r '\C-s'
" stty -ixon
" alias vim='stty stop "" -ixoff; vim'
