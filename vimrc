
syntax on
filetype plugin indent on

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
  Plug 'tpope/vim-commentary'
  Plug 'StanAngeloff/php.vim'
  Plug 'stephpy/vim-php-cs-fixer'

  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

  Plug 'vim-vdebug/vdebug'
call plug#end()

" For Colemak :
" Navigation :
noremap n j
noremap e k
noremap i l
" End of word navigation :
noremap j e
" Next in search mode :
noremap k n
" l becomes the equivalent of i, for insert mode :
noremap l i

" Moving between splits :
noremap <C-w>n <C-w>j
" noremap <C-w>H <C-w>K
noremap <C-w>e <C-w>k
" noremap <C-w>J <C-w>H
" noremap <C-w>K <C-w>J
" Focus to the right window:
noremap <C-w>i <C-w>l
" Move the window to the right:
noremap <C-w>I <C-w>L
" Move the window to the left:
noremap <C-w>J <C-w>H

" We don't want to necessarily ignore files that start with a dot:
let g:ctrlp_show_hidden=1
" But we don't want to include `.git/*` files either:
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
" If it's more than 40 dirs deep, something is wrong:
let g:ctrlp_max_depth=40
" No maximum number of files found:
let g:ctrlp_max_files=0
" Ignore node_modules and binary files:
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]node_modules$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }

set exrc " enable per-directory .vimrc files

" For multi-byte character support
set encoding=utf-8
set fileencoding=utf-8

set tabstop=2       " Number of spaces that a <Tab> in the file counts for.
set shiftwidth=2    " Number of spaces to use for each step of (auto)indent.
set expandtab       " Use the appropriate number of spaces to insert a <Tab>. Spaces are used in indents with the '>' and '<' commands and when 'autoindent' is on. To insert a real tab when 'expandtab' is on, use CTRL-V <Tab>.
set smarttab        " When on, a <Tab> in front of a line inserts blanks according to 'shiftwidth'. 'tabstop' is used in other places. A <BS> will delete a 'shiftwidth' worth of space at the start of the line.
set showcmd         " Show (partial) command in status line.
set nonumber        " DONT show line numbers.
set showmatch       " When a bracket is inserted, briefly jump to the matching one. The jump is only done if the match can be seen on the screen. The time to show the match can be set with 'matchtime'.
set hlsearch        " When there is a previous search pattern, highlight all its matches.
set incsearch       " While typing a search command, show immediately where the so far typed pattern matches.
set ignorecase      " Ignore case in search patterns.
set smartcase       " Override the 'ignorecase' option if the search pattern contains upper case characters.
set backspace=2     " Influences the working of <BS>, <Del>, CTRL-W and CTRL-U in Insert mode. This is a list of items, separated by commas. Each item allows a way to backspace over something.
set autoindent      " Copy indent from current line when starting a new line (typing <CR> in Insert mode or when using the "o" or "O" command).
set textwidth=79    " Maximum width of text that is being inserted. A longer line will be broken after white space to get this width.
set formatoptions=c,q,r,t " This is a sequence of letters which describes how automatic formatting is to be done.
                    " letter    meaning when present in 'formatoptions'
                    " ------    ---------------------------------------
                    " c         Auto-wrap comments using textwidth, inserting
                    "           the current comment leader automatically.
                    " q         Allow formatting of comments with "gq".
                    " r         Automatically insert the current comment leader
                    "           after hitting <Enter> in Insert mode.·
                    " t         Auto-wrap text using textwidth (does not apply
                    "           to comments)

set ruler           " Show the line and column number of the cursor position, separated by a comma.
set background=light " When set to "dark", Vim will try to use colors that look good on a dark background. When set to "light", Vim will try to use colors that look good on a light background. Any other value is illegal.
colorscheme darkblue
" set mouse=a         " Enable the use of the mouse.
let mapleader = ","

" CTRL-C to copy in the clipboard the text that is currently selected.
" "+y is provided by vim-fakeclip plugin, to copy the text into the system's
" clipboard.
vmap <C-c> "+y

" Toggle paste mode using Leader + p:
map <Leader>p :set paste!<CR>
" Remove highlighting of search results:
map <Leader>h :nohlsearch<CR>

" StatusLine:
set laststatus=2                             " always show statusbar··
set statusline=··
set statusline+=%-10.3n\                     " buffer number··
set statusline+=%f\                          " filename···
set statusline+=%h%m%r%w                     " status flags··
" set statusline+=\[%{strlen(&ft)?&ft:'none'}] " file type··
set statusline+=%=                           " right align remainder··
" set statusline+=0x%-8B                       " character value··
set statusline+=%-14(%l,%c%V%)               " line, character··
set statusline+=%<%P                         " file position··

" Vim Commentary:
noremap <leader>/ :Commentary<cr>

" NerdTree stuff:
let NERDTreeShowHidden=1
let NERDTreeChDirMode=2
let NERDTreeMapOpenExpl='E' " Make sure the 'e' is usable for navigating in the NERDTree buffer
map <Leader>n :NERDTreeToggle<CR>

set secure " disable unsafe commands in local .vimrc files

" everytime you save, it will generate the tags you have in your PHP file:
au BufWritePost *.php silent! !eval '[ -f ".git/hooks/ctags" ] && .git/hooks/ctags' &

