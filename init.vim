scriptencoding utf8

filetype plugin on

if !exists("g:gui_oni")
    call plug#begin('~/.local/share/nvim/plugged')
    Plug 'vimwiki/vimwiki'
    Plug 'majutsushi/tagbar'
    Plug 'liuchengxu/vim-which-key'
    Plug 'mhinz/vim-startify'
    Plug 'ap/vim-buftabline'
    Plug 'arcticicestudio/nord-vim'
    Plug 'Lokaltog/vim-monotone'
    Plug 'pbrisbin/vim-colors-off'
    Plug 'KKPMW/distilled-vim'
    Plug 'jaredgorski/fogbell.vim'
    Plug 't184256/vim-boring'
    Plug 'junegunn/goyo.vim'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
    Plug 'ap/vim-css-color'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    call plug#end()
endif

let mapleader=','
syntax enable
set hlsearch           " highlight search items
set incsearch          " searches are performed as you type
set number             " enable line numbers
set confirm            " ask confirmation like save before quit.
set wildmenu           " Tab completion menu when using command mode
set complete+=kspell
set completeopt=menuone
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
set statusline+=\ %{coc#status()}\ 
set statusline+=%=
set statusline+=\ \|\ 
set statusline+=[col:%c]
set statusline+=\ [ln\ %l
set statusline+=/%L]


" use 2 spaces per tab in html
autocmd FileType html setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab

" tab and trailing whitespace indicators
set linebreak breakindent
set list listchars=tab:--,trail:.

"----- Language Client -----"
if !exists("g:gui_oni")
    set hidden
    set nobackup
    set nowritebackup
    set cmdheight=2
    set signcolumn=yes
    set updatetime=400

    " Use tab for trigger completion with characters ahead and navigate.
    " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
    " other plugin before putting this into your config.
    inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    inoremap <silent><expr> <c-space> coc#refresh()

    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
    " position. Coc only does snippet and additional edit on confirm.
    " <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
    if exists('*complete_info')
      inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
    else
      inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    endif

    " Use `[g` and `]g` to navigate diagnostics
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)

    " GoTo code navigation.
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Symbol renaming.
    nmap <leader>rn <Plug>(coc-rename)

    vmap <leader>a <Plug>(coc-codeaction-selected)
    nmap <leader>a <Plug>(coc-codeaction-selected)
    nmap <leader>ac <Plug>(coc-codeaction)

    nnoremap <silent> K :call <SID>show_documentation()<CR>

    autocmd CursorHold * silent call CocActionAsync('highlight')
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfunction

    " Map function and class text objects
    " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
    xmap if <Plug>(coc-funcobj-i)
    omap if <Plug>(coc-funcobj-i)
    xmap af <Plug>(coc-funcobj-a)
    omap af <Plug>(coc-funcobj-a)
    xmap ic <Plug>(coc-classobj-i)
    omap ic <Plug>(coc-classobj-i)
    xmap ac <Plug>(coc-classobj-a)
    omap ac <Plug>(coc-classobj-a)

"----- END LANGUGE CLIENT -----"

    " colorscheme "
    if(has("termguicolors"))
        set termguicolors
    endif
    set t_Co=256
    set background=dark
    colorscheme nord

    " enable mouse
    set mouse=a
    if has('mouse_sgr')
        " sgr mouse is better but not every term supports it
        set ttymouse=sgr
    endif

    "----netrw----"
    let g:netrw_winsize      = 20
    let g:netrw_wiw          = 20
    let g:netrw_banner       = 0
    let g:netrw_keepdir      = 0
    let g:netrw_liststyle    = 3
    let g:netrw_sort_options = 'i'

    nnoremap <leader>e :Lexplore<CR>
endif
"----netrw----"
"
"----key remaps----"
inoremap jk <ESC>
nnoremap <leader><space> :noh<CR>
nnoremap <leader>t :TagbarToggle<CR> :wincmd l<CR>
nnoremap <leader>g :Goyo<CR>
map <leader>o :setlocal spell! spelllang=en_gb<CR>
nnoremap <leader>z :GFiles<CR>
nnoremap <leader>f :FZF /<CR>
nnoremap <silent> <leader> :WhichKey ','<CR>
vnoremap <silent> <leader> :WhichKeyVisual ','<CR>
" Escape quits terminal input mode
tnoremap <Esc> <C-\><C-n>

" change windows with ctrl+(hjkl)
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" gj/k but preserve numbered jumps ie: 12j or 45k
nmap <buffer><silent><expr>j v:count ? 'j' : 'gj'
nmap <buffer><silent><expr>k v:count ? 'k' : 'gk'
"----end key remaps----"

nnoremap <leader>so :source ~/.config/nvim/init.vim<CR>

noremap <Tab> :bn<CR>
noremap <S-Tab> :bp<CR>
