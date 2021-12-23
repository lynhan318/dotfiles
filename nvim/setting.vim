let mapleader = "\<Space>"
syntax enable
filetype plugin indent on
set expandtab
set list
set nocompatible
syntax on
set encoding=UTF-8
set mouse=a
set scroll=15
set history=1000
set undolevels=1000
set hlsearch
set splitbelow
set splitright
set number
set relativenumber
set ignorecase
set smartcase
set smartindent
" set cursorline
set incsearch
set tabstop=4
set softtabstop=0
set shiftwidth=4
set lazyredraw
set nobackup
set noswapfile
set nowrap
set visualbell
set noshowmode "hide mod insert,normal,...
set noerrorbells
set autoindent
set backspace=indent,eol,start
set smarttab
set noshowmode "hide mod insert,normal,...
set wildmenu
set expandtab
set completeopt=menuone,noselect
set shortmess+=c
set updatetime=3000
set termguicolors

"imap
inoremap <silent> <c-l> <Right>
inoremap <silent><expr><Tab> pumvisible() ? "\<C-N>" : "\<Tab>"
inoremap <silent><expr><S-Tab> pumvisible() ? "\<C-P>" : "\<S-Tab>"
"nmap
inoremap jk <ESC>
inoremap ww <ESC>:w<cr>
nnoremap ; :
nnoremap <Esc><Esc> :nohlsearch<CR>
nnoremap S :%s//g<Left><Left>
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
noremap Y y$
nmap <silent> ff <Plug>(easymotion-overwin-f2)
nmap <silent> fl <Plug>(easymotion-overwin-line)

noremap <silent> <c-k> :wincmd k<CR>
noremap <silent> <c-j> :wincmd j<CR>
noremap <silent> <c-h> :wincmd h<CR>
noremap <silent> <c-l> :wincmd l<CR>

"escape highlight search
"copy/pase
vnoremap < <gv
vnoremap > >gv
nnoremap <nowait><c-w> :BD<cr>
nnoremap <c-s> :w!<cr>
nnoremap <nowait><c-w><c-k> :bufdo bd<cr>
nnoremap <leader>a ggVG<cr>
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

autocmd BufNewFile,BufRead *.mdx set filetype=markdown.mdx
