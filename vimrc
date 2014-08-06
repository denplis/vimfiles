set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" alternatively, pass a path where Vundle should install bundles
"let path = '~/some/path/here'
"call vundle#rc(path)

" let Vundle manage Vundle, required
Bundle 'A2K/practical.vim'
Bundle 'Lokaltog/powerline-fonts'
Bundle 'airblade/vim-gitgutter'
Bundle 'airblade/vim-rooter', {'rtp': 'vim-rooter/bindings/vim/'}
Bundle 'bling/vim-airline'
Bundle 'derekwyatt/vim-fswitch'
Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'oblitum/YouCompleteMe'
Bundle 'sjl/vitality.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'vim-scripts/openssl.vim'
Bundle 'guns/xterm-color-table.vim'
Bundle 'mileszs/ack.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'jistr/vim-nerdtree-tabs'
Bundle 'jiangmiao/auto-pairs'
Bundle 'sjl/gundo.vim'
Bundle 'majutsushi/tagbar'
Bundle 'kiev/ctrlp'
Bundle 'vim-scripts/pylint-mode'
Bundle 'vim-scripts/Indent-Guides'

filetype plugin indent on     " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install (update) bundles
" :BundleSearch(!) foo - search (or refresh cache first) for foo
" :BundleClean(!)      - confirm (or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle commands are not allowed.
" Put your stuff after this line
"

syntax on
set autoread
set autowrite

" Indentation
filetype plugin indent on
autocmd FileType xhtml,html,htmldjango setlocal tabstop=4 shiftwidth=4 expandtab
autocmd FileType r setlocal tabstop=4 shiftwidth=4 expandtab
hi IndentGuidesOdd  ctermbg=black
hi IndentGuidesEven ctermbg=darkgrey


set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set expandtab
set smartindent
set cino=(0
set cinkeys=0{,0},0#,!^F

" indent
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4


" Looks
colorscheme practical
"set gfn=Menlo\ Regular:h12
set gfn=Menlo\ for\ Powerline:h12
set mouse=a
set visualbell
set showcmd
set number
set cursorline
set clipboard=unnamed
set backspace=indent,eol,start
set linespace=0
set encoding=utf-8
set t_Co=256
set fillchars+=stl:\ ,stlnc:\
set term=xterm-256color
set termencoding=utf-8
set hlsearch
set scrolloff=7


set undodir=~/.vim/undodir
set undofile
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

let g:ackhighlight = 1

" Hide search highlight on Esc
nnoremap <silent> <ESC> :noh<CR>

" File switch plugin hotkey for terminal
map <ESC>*h <D-M-UP>
imap <ESC>*h <D-M-UP>
map <D-M-Up> :FSHere<CR>
imap <D-M-Up> <C-O>:FSHere<CR>

" automatically open and close the popup menu / preview window
"au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest

" remove trailing spaces on save
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd FileType c,cpp,h,hpp,py autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" remove extra empty lines on end or add empty line if it is missing
function TrimEndLines()
    let save_cursor = getpos(".")
    :silent! %s#\($\n\s*\)*\%$#\r#
    call setpos('.', save_cursor)
endfunction
autocmd BufWritePre * :call TrimEndLines()

" restore cursor position
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction
augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

set nobackup
set nowritebackup
set noswapfile

map <C-Tab> gt
map <C-S-Tab> gT
map <S-Right> gt
map <S-Left> gT
map ,t <Esc>:tabnew<CR>

cmap w!! %!sudo tee > /dev/null %

set laststatus=2

set wildignore+=*/tmp/*,*.so,*.swp,*.zip  " MacOSX/Linux
set wildignore+=tmp\*,*.swp,*.zip,*.exe   " Windows


set guioptions-=T

" Ctrlp 
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
map <c-p> CtrlP

let s:IgnoreChange=0
autocmd! FileChangedRO * nested
    \ let s:IgnoreChange=1 |
    \ call system("p4 edit " . expand("%")) |
    \ set noreadonly
autocmd! FileChangedShell *
    \ if 1 == s:IgnoreChange |
    \   let v:fcs_choice="" |
    \   let s:IgnoreChange=0 |
    \ else |
    \   let v:fcs_choice="ask" |
    \ endif


map <silent> F <C-C>:.!~/bin/vim-format-helper<CR>'[=']']
vmap <silent> F !~/bin/vim-format-helper<CR>'[=']']A

let auto_format_cmd = "inoremap <silent> } }<C-C>:set formatprg=~/bin/vim-format-helper<CR>=%:set formatprg=<CR>=%]}a"
au FileType cpp execute auto_format_cmd
au FileType h execute auto_format_cmd

" Auto correction
iab namesapce namespace
iab namsapce namespace
iab calss class

" Hide <# #> around completed args
set conceallevel=2
set concealcursor=vin
set mousemodel=popup_setpos

let g:airline_powerline_fonts = 1

" Disable delay when pressing ESC or other key that appears in mapped sequence
" This will not break terminal escape sequences
"set timeout ttimeout timeoutlen=0 ttimeoutlen=500

" ALT+UP, ALT+DOWN
map <silent> <ESC>[B }
map <silent> <ESC>[A {

" HOME
map <ESC>[H <HOME>
imap <ESC>[H <HOME>
" END
map <ESC>[F <END>
imap <ESC>[F <END>
" Behavior of HOME and END
noremap <expr> <silent> <Home> col('.') == match(getline('.'),'\S')+1 ? '0' : '^'
imap <silent> <Home> <C-O><Home>

" CMD+C
imap <silent> <ESC>[C <C-O>y
map <silent> <ESC>[C y
" CMD+X
imap <silent> <ESC>[X <C-O>d
map <silent> <ESC>[X d
"CMD+Z
imap <silent> <ESC>[Z <C-O>u
map <silent> <ESC>[Z u
"SHIFT+CMD+Z
imap <silent> <ESC>[` <C-O><C-R>
map <silent> <ESC>[` <C-R>
"CMD+S
imap <silent> <ESC>[y <C-O>:w<CR>
map <silent> <ESC>[y :w<CR>
"CMD+Q
imap <silent> <ESC>[q <C-O>:q<CR>
map <silent> <ESC>[q :q<CR>
"OPTION+LEFT
map <ESC>b <C-Left>
imap <ESC>b <C-Left>
"OPTION+RIGHT
map <ESC>f <C-Right>
imap <ESC>f <C-Right>
"CMD+UP
map <ESC>[5- gg
imap <silent> <ESC>[5- <C-O>gg
"CMD+DOWN
map <ESC>[6- G
imap <silent> <ESC>[6- <C-O>G
"CMD+A
map <m-a> ggVG
imap <m-a> <ESC>ggVG
"Moving left and right a word like in OS X
map <ESC>f el
imap <silent> <ESC>f <C-O>e<C-O>l
map <ESC>b b
imap <silent> <ESC>b <C-O>b
imap <silent> <ESC>[selectall <C-C>ggvG
map <silent> <ESC>[selectall <C-C>ggvG

imap § <C-C>

" Enable pasting of text in terminal
if &term =~ "xterm.*"
    let &t_ti = &t_ti . "\e[?2004h"
    let &t_te = "\e[?2004l" . &t_te
    function XTermPasteBegin(ret)
        set pastetoggle=<Esc>[201~
        set paste
        return a:ret
    endfunction
    map <expr> <Esc>[200~ XTermPasteBegin("i")
    imap <expr> <Esc>[200~ XTermPasteBegin("")
    vmap <expr> <ESC>[200~ XTermPasteBegin("\"_di") 
    cmap <Esc>[200~ <nop>
    cmap <Esc>[201~ <nop>
endif

if has('mouse_sgr')
    set ttymouse=sgr
endif

noremap <C-LeftMouse> <4-LeftMouse>
inoremap <C-LeftMouse> <4-LeftMouse>
onoremap <C-LeftMouse> <C-C><2-LeftMouse>
noremap <C-LeftDrag> <LeftDrag>
inoremap <C-LeftDrag> <LeftDrag>
onoremap <C-LeftDrag> <C-C><LeftDrag>

"Better mouse wheel scrolling
map <ScrollWheelUp> <C-Y><C-Y><C-Y>
map <ScrollWheelDown> <C-E><C-E><C-E>

let g:vitality_fix_focus = 0
let g:ycm_confirm_extra_conf = 0
let g:ycm_enable_diagnostic_signs = 0

map <silent> <C-\> :call NERDComment('n', 'Toggle')<CR>
imap <silent> <C-\> <C-O>:call NERDComment('n', 'Toggle')<CR>

"let g:ycm_key_list_select_completion = ['<Down>']
"let g:ycm_key_list_previous_completion = ['<Up>']

let g:ack_autoclose = 1
let g:ackpreview = 1

let g:ctrlp_user_command = "/Users/a2k/bin/vimfind %s"

let g:NERDTreeWinPos = "right"
let g:nerdtree_tabs_open_on_console_startup=1
let g:NERDTreeMouseMode = 3
let g:NERDTreeStatusline = 1

let mapleader=","

let g:AutoPairsMapBS = 0

set makeprg=make\ -j$(get_thread_count)

let g:tagbar_left = 1
let g:tagbar_compact = 1
let g:tagbar_indent = 1
let g:tagbar_show_visibility = 1
let g:tagbar_singleclick = 1
let g:AutoPairs = {'{':'}'}

