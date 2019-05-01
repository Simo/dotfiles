packadd minpac
call minpac#init()

"" BASIC
call minpac#add('vim-airline/vim-airline')
call minpac#add('vim-airline/vim-airline-themes')

"" THEMES
call minpac#add('morhetz/gruvbox')
call minpac#add('trusktr/seti.vim')

"" UTILITIES
call minpac#add('tpope/vim-unimpaired')
call minpac#add('tpope/vim-surround')

"" PLUGINS
call minpac#add('kien/ctrlp.vim')
call minpac#add('scrooloose/nerdtree')
call minpac#add('Xuyuanp/nerdtree-git-plugin')
call minpac#add('thoughtbot/vim-rspec')

"" SNIPMATE
call minpac#add('tomtom/tlib_vim')
call minpac#add('MarcWeber/vim-addon-mw-utils')
call minpac#add('garbas/vim-snipmate')
call minpac#add('honza/vim-snippets')


"" APPEARANCE
if has('gui_running')
	colorscheme railscasts
	set background=dark
	set guifont=Menlo:h16
else
	colorscheme gruvbox
	"" colorscheme seti
	set background=dark
endif


"" LEADER
let mapleader=","

"" quick colon
nnoremap ; :

"" quick exit insert mode
inoremap jj <ESC>

"" who needs arrows?
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

"" cursor highlight
set cursorline   " highlight current line
set cursorcolumn " highlight current column

" set clipboard to unnamed
set clipboard=unnamed

"" set character encoding
set encoding=utf-8
" set the cursor to a vertical line in insert mode and a solid block
" in command mode
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

set synmaxcol=800 " don't try to highlight long lines
"" set number        " line numbers aren't needed

set number relativenumber

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Allow backgrounding buffers without writing them, and remember
" marks/undo
" " for backgrounded buffers
 set hidden
"
" " Auto-reload buffers when file changed on disk
 set autoread
"
" " Disable swap files; systems don't crash that often these days
 set updatecount=0

"" Make Vim able to edit crontab files again.
 set backupskip=/tmp/*,/private/tmp/*"

"" Whitespace
" set nowrap                        " don't wrap lines

"" setting wrap
set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=85
set list                          " Show invisible characters

"" tabs vs spaces
set tabstop=2                     " a tab is two spaces
set shiftwidth=2                  " an autoindent (with <<) is two spaces
set expandtab                     " use spaces, not tabs

"" Searching
set hlsearch                      " highlight matches
set ignorecase                    " searches are case insensitive...
set smartcase                     " ... unless they contain at least one capital letter
set incsearch
set showmatch

nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

"" fix vim broken regex
nnoremap / /\v
vnoremap / /\v
set gdefault                      " have :s///g flag by default on

set notimeout

"" autosave on focus out
au FocusLost * :wa

cnoremap %% <C-R>=expand('%:h').'/'<cr>

""rapidly gets Ack
nnoremap <leader>a :Ack

"" create an empty split window and move to it
nnoremap <leader>w <C-w>v<C-w>l

"" open .vimrc file in a new split window
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>

"" easier navigation between split windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l


"" AIRLINE THEME
let g:airline_theme='gruvbox'

let g:airline#extensions#tabline#enabled = 1

let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = ' '

"" NERDTree
map <C-n> :NERDTreeToggle<CR>

"" CTRL-P
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
nnoremap <leader>. :CtrlPTag<cr>

"" RSpec.vim mappings
let g:rspec_command = "!rspec --color {spec}"
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

"" OLD STYLE
"" per far girare automaticamente la classe di test con rspec
"" nnoremap <leader>t :w\|!rspec %:p<cr>


"" FUNCTIONS

function! DelTagOfFile(file)
  let fullpath = a:file
  let cwd = getcwd()
  let tagfilename = cwd . "/tags"
  let f = substitute(fullpath, cwd . "/", "", "")
  let f = escape(f, './')
  let cmd = 'sed -i "/' . f . '/d" "' . tagfilename . '"'
  let resp = system(cmd)
endfunction

function! UpdateTags()
  let f = expand("%:p")
  let cwd = getcwd()
  let tagfilename = cwd . "/tags"
  let cmd = 'ctags -a -f ' . tagfilename . ' --c++-kinds=+p --fields=+iaS --extra=+q ' . '"' . f . '"'
  call DelTagOfFile(f)
  let resp = system(cmd)
endfunction
autocmd BufWritePost *.rb,*.erb call UpdateTags()
