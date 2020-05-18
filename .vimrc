" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=500
" Enable filetype plugins
filetype off
filetype plugin on
filetype indent on
" Set to auto read when a file is changed from the outside
set autoread
" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
" Fast saving
nmap <leader>w :w!<CR>
" :W sudo saves the file
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null
" Automatically save before commands like :next and :make"
set autowrite
" Enable mouse usage (all modes)"
set mouse=a
nnoremap <C-s> :w!<CR>
" Highlight line which cursor is on
set cursorline
nnoremap j gj
nnoremap k gk
" Disable automatic commenting on new line
autocmd Filetype * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" Splits open windows bottom and right
set splitbelow splitright
" Don't increment numbers in octal notation
set nrformats-=octal
" Use OS clipboard by default
set clipboard^=unnamed,unnamedplus

" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 1 line to the cursor - when moving vertically using j/k
set so=1
" Avoid garbled characters in Chinese language windows OS
let $LANG='en'
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
" Turn on the Wild menu
set wildmenu
set wildmode=longest:full,full
" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif
"Always show current position
set ruler
" Height of the command bar
set cmdheight=2
" A buffer becomes hidden when it is abandoned
set hid
" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
" Ignore case when searching
set ignorecase
" When searching try to be smart about cases
set smartcase
" Highlight search results
set hlsearch
" Makes search act like search in modern browsers
set incsearch
" Don't redraw while executing macros (good performance config)
set lazyredraw
" For regular expressions turn magic on
set magic
" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2
" No annoying sound on errors
set noerrorbells
set novisualbell
set noeb vb t_vb=
" Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif
" Add a bit extra margin to the left
" set foldcolumn=1
" if -- INSERT -- is unnecessary
set noshowmode

" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable
let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status'
      \ },
      \ }
" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif
try
    colorscheme gruvbox
catch
endtry
set background=dark
hi cCustomFunc  gui=bold guifg=yellowgreen
hi cCustomClass gui=reverse guifg=#00FF00
" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set guitablabel=%M\ %t
endif
set t_Co=256
" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
  set t_Co=16
endif
" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8
" Use Unix as the standard file type
set ffs=unix,dos,mac

" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowritebackup
set nowb
set noswapfile

" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set autoindent
set expandtab
" Be smart when using tabs ;)
set smarttab
" 1 tab == 2 spaces
set formatoptions=tcqrn1
set shiftwidth=2
set tabstop=2
set softtabstop=2
set noshiftround
" Linebreak on 500 characters
set lbr
set tw=79
set ai "Auto indent
set si "Smart indent
" set wrap "Wrap lines
set showbreak=+++ " Wrap-broken line prefix
set number              " show line numbers
set relativenumber      " show relative numbers
set showcmd             " show command in bottom bar
set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
set foldmethod=indent
highlight ColorColumn ctermbg=058

" => Status line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2
" Format the status line
" set statusline=\ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ Line:\ %l\ \ \ \ \
" \ \ \ \ \ \ \ \ \ \ \ \ \ \ Column:\ %c
" set statusline=[TYPE=%Y]\ [POS=%l,%v][%p%%]\ [BUFFER=%n]\ %{strftime('%c')}
" hi StatusLine ctermbg=Gray ctermfg=Black cterm=Bold
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction
call plug#begin('~/.vim/plugged')
  Plug 'itchyny/lightline.vim'
  Plug 'jiangmiao/auto-pairs'
  Plug 'bfrg/vim-cpp-modern'
  Plug 'sheerun/vim-polyglot'
  Plug 'scrooloose/nerdtree'
  Plug 'scrooloose/nerdcommenter'
  Plug 'Yggdroot/indentLine'
  Plug 'junegunn/goyo.vim'
  Plug 'ntpeters/vim-better-whitespace'
call plug#end()
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
let g:AutoPairsFlyMode = 1
let g:NERDSpaceDelims = 1
map <C-f> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
fun! ToggleCC()
  if &cc == ''
    set cc=80
  else
    set cc=
  endif
endfun
nnoremap <C-i> :call ToggleCC()<CR>
nmap <leader>c   <Plug>NERDCommenterToggle
vmap <leader>c   <Plug>NERDCommenterToggle<CR>gv
let g:NERDCustomDelimiters = { 'c': { 'left': '//','right': ''  }  }
vnoremap <leader>s    y/<C-r>"<CR>
" Use <leader>s to clear search highlighting
if maparg('<leader>s', 'n') ==# ''
  nnoremap <silent> <leader>s :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><leader>s
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Specific Directories

