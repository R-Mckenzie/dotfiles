scriptencoding utf8

filetype plugin on

call plug#begin('~/.local/share/nvim/plugged')
Plug 'NLKNguyen/papercolor-theme'
Plug 'junegunn/goyo.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'mattn/emmet-vim'
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
call plug#end()

let mapleader=','
syntax enable
set hlsearch           " highlight search items
set incsearch          " searches are performed as you type
set number             " enable line numbers
set confirm            " ask confirmation like save before quit.
set wildmenu           " Tab completion menu when using command mode
set expandtab          " Tab key inserts spaces not tabs
set softtabstop=4      " spaces to enter for each tab
set shiftwidth=4       " amount of spaces for indentation
set scrolloff=5
set clipboard=unnamedplus
set updatetime=100
set inccommand=split
set shortmess+=c

set statusline=%f
set statusline+=\ %y\ \|\ 
set statusline+=%=
set statusline+=%{coc#status()}
set statusline+=%=
set statusline+=\ \|\ 
set statusline+=[col:%c]
set statusline+=\ [ln\ %l
set statusline+=/%L]

" use 2 spaces per tab in html
autocmd FileType html setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab

" tab and trailing whitespace indicators
set linebreak breakindent
set list listchars=tab:>>,trail:.

"----- Language Client -----"
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set signcolumn=yes

" tab to cycle completions
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-space> coc#refresh()
" select completion with enter
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>=  <Plug>(coc-format-selected)
nmap <leader>=  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
"----- Language Client -----"

" colorscheme "
set t_Co=256

" background color by time of day
if strftime("%H") > 7 && strftime("%H") < 19
    set background=light
    colorscheme PaperColor
else
    set background=dark
    colorscheme PaperColor
endif
" end colorscheme "

" enable mouse
set mouse=a
if has('mouse_sgr')
    " sgr mouse is better but not every term supports it
    set ttymouse=sgr
endif



"----neosnpippet----"
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif
let g:neosnippet#enable_completed_snippet = 1
"----neosnpippet----"

"----netrw----"
"let g:netrw_winsize      = 12
"let g:netrw_browse_split = 4
"let g:netrw_banner       = 0
"let g:netrw_keepdir      = 0
"let g:netrw_liststyle    = 3
"let g:netrw_sort_options = 'i'

"nnoremap <leader>e :Vexplore<CR>
"----netrw----"

"----key remaps----"
inoremap jk <ESC>
nnoremap <leader><space> :noh<CR>
nnoremap <leader>g :Goyo<CR>
map <leader>o :setlocal spell! spelllang=en_gb<CR>
nnoremap <leader>f :FZF<CR>

" change windows with ctrl+(hjkl)
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" gj/k but preserve numbered jumps ie: 12j or 45k
nmap <buffer><silent><expr>j v:count ? 'j' : 'gj'
nmap <buffer><silent><expr>k v:count ? 'k' : 'gk'

"----end key remaps----"
