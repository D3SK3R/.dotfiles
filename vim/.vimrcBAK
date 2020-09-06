"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VUNDLE
" https://github.com/VundleVim/Vundle.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'

" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'

" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'

" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'

" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" 'vim +PluginInstall +qall' on terminal or :PluginInstall on vim to install a
" plugin

" USER plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-airline
" https://github.com/vim-airline/vim-airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" themes: https://github.com/vim-airline/vim-airline/wiki/Screenshots
" To set in .vimrc, use let g:airline_theme='<theme>', e.g. let g:airline_theme='simple'
let g:airline_theme='monochrome' 
" fav themes: simple/minimalist/lucius/monochrome/serene

" if using a powerline font
"let g:airline_powerline_fonts = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'ap/vim-css-color'

" ctrl+f to use
Plugin 'preservim/nerdtree'

Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'junegunn/fzf.vim'

" urxvt doesn't support icons so I have to disable... :(
"Plugin 'ryanoasis/vim-devicons'


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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number
syntax on
filetype indent plugin on
set wrapmargin=8
set tabstop=4 softtabstop=0 expandtab smarttab
set shiftwidth=4

" enables backspace to delete characters in insert mode
set backspace=3

" Minimal number of screen lines to keep above and below the cursor.
set scrolloff=5

" Highlight selected matches
set hlsearch

" when its enables, the copy key is the vim key yank, y
" Enable mouse scrolling
set mouse=a

" Stop vim from creating a new line
set textwidth=0 wrapmargin=0

" To wrap lines visually (i.e. the line is still one line of text, but Vim displays it on multiple lines) [DEFAULT].
:set wrap

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

"Autorun code on save
"autocmd BufWritePost *.sh !clear;sh %
"autocmd BufWritePost *.py !clear;python %

"Run code on CTRL X
"nnoremap <buffer> <c-x> :exec '!clear;python' shellescape(@%, 1)<cr>

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
autocmd BufRead */i3/config set syntax=dosini
autocmd BufRead */.i3/config set syntax=dosini
autocmd BufRead */.i3/config* set syntax=dosini

"Keyboard shortcuts
"https://unix.stackexchange.com/questions/93144/exit-vim-more-quickly
"Put this 3 lines to your ~/.bashrc or ~/.zshrc:
" bind -r '\C-s'
" stty -ixon
" alias vim='stty stop "" -ixoff; vim'

" disable vim to change window title
set notitle

"map "a" to act like "i" and switch to insert mode
nmap a i

"save/write file and "move" to the next character (actually stays where it was
"before saving, because the default behaviour is to go to the previous
"character)
nmap <c-s> :w<CR>l
imap <c-s> <Esc>:w<CR>l

"quit after save
nmap <c-q> :q<CR>
imap <c-q> <Esc>:q<CR>

"Disable :X to encryption and make it write and quit, like :x
cnoreabbrev <expr> X (getcmdtype() is# ':' && getcmdline() is# 'X') ? 'x' : 'X'

"NERDTree
nmap <c-f> :NERDTree<CR>
imap <c-f> <Esc>:NERDTree<CR>

:command Q q
:command W w

" Powerline
"set  rtp+=/usr/lib/python3.7/site-packages/powerline/bindings/vim/
"set laststatus=2
"set t_Co=256

