""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""               
"           
"           ██╗   ██╗██╗███╗   ███╗██████╗  ██████╗
"           ██║   ██║██║████╗ ████║██╔══██╗██╔════╝
"           ██║   ██║██║██╔████╔██║██████╔╝██║     
"           ╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║     
"            ╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗
"             ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝
"           
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible
set encoding=utf-8
set exrc
set secure
syntax on
filetype plugin indent on
set nowrap
set ts=2 sts=2 sw=2 et ai si
set nu
set cursorline
set nowrap
set ignorecase
set showcmd
set showmode
set mouse=a
"set path+=**
set hlsearch
set wildmenu
set wildmode=list:longest
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
let &path.="src/include,/usr/include/AL,"

""" Theme
colo molokai

""" File Browsing
let g:netrw_banner=0
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_liststyle=3
let g:netrw_list_hide=netrw_gitignore#Hide()

""" Mapping
nnoremap <C-s> :write<CR>
nnoremap <C-t> :NERDTreeToggle<CR>

""" Plugins
call plug#begin()
Plug 'preservim/NERDTree'
Plug 'vim-airline/vim-airline'
call plug#end()

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
