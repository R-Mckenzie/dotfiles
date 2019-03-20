scriptencoding utf8

call plug#begin('~/.local/share/nvim/plugged')
Plug 'morhetz/gruvbox'
Plug 'NLKNguyen/papercolor-theme'
Plug 'junegunn/goyo.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf.vim'
Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh'}
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
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
set shortmess+=aAcIws  " Hide or shorten certain messages
set scrolloff=5
set showmode

" ----- status line -----
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

set statusline+=%#PmenuSel#
set statusline+=%{StatuslineGit()}
set statusline+=\|\ %F
set statusline+=%=
set statusline+=\ %y
set statusline+=\ %p%%
set statusline+=\ \|\ ln\ %l:ch\ %c
set statusline+=\ 

" colorscheme
set t_Co=256
set background=light
colorscheme PaperColor

" enable mouse
set mouse=a
if has('mouse_sgr')
    " sgr mouse is better but not every term supports it
    set ttymouse=sgr
endif

set linebreak breakindent
set list listchars=tab:>>,trail:~

" jk mapped to escape
inoremap jk <ESC>

" Deoplete tab to cycle autocompletes
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" clear highlighting
nnoremap <leader><space> :noh<CR>

" goyo to leader+g
map <Leader>g :Goyo \| set linebreak<CR>

" spelling toggle
map <leader>o :setlocal spell! spelllang=en_gb<CR>

" match string to switch buffer
nnoremap <Leader>b :let b:buf = input('Match: ')<Bar>call <SID>bufferselect(b:buf)<CR>

" fzf hotkey
nnoremap <leader>f :FZF<CR>

" change windows with ctrl+(hjkl)
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" gj/k but preserve numbered jumps ie: 12j or 45k
nmap <buffer><silent><expr>j v:count ? 'j' : 'gj'
nmap <buffer><silent><expr>k v:count ? 'k' : 'gk'

" close current buffer and/or tab
nnoremap <silent> <Leader>q :B<CR>:silent tabclose<CR>gT

" ------ autocmd ------
" Reload changes if file changed outside of vim requires autoread
augroup load_changed_file
    autocmd!
    autocmd FocusGained,BufEnter * if mode() !=? 'c' | checktime | endif
    autocmd FileChangedShellPost * echo "Changes loaded from source file"
augroup END

" when quitting a file, save the cursor position
augroup save_cursor_position
    autocmd!
    autocmd BufReadPost * call setpos(".", getpos("'\""))
augroup END

" save and load folds
augroup remember_folds
    autocmd!
    autocmd BufWinLeave * mkview
    autocmd BufWinEnter * silent! loadview
augroup END

" when not running in a console or a terminal that doesn't support 256 colors
" enable cursorline in the currently active window and disable it in inactive ones
if $DISPLAY !=? '' && &t_Co == 256
    augroup cursorline
        autocmd!
        autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
        autocmd WinLeave * setlocal nocursorline
    augroup END
endif

" ------ adv maps ------

" switch active buffer based on pattern matching
" if more than one match is found then list the matches to choose from
function! <SID>bufferselect(pattern) abort
    let l:bufcount = bufnr('$')
    let l:currbufnr = 1
    let l:nummatches = 0
    let l:matchingbufnr = 0
    " walk the buffer count
    while l:currbufnr <= l:bufcount
        if (bufexists(l:currbufnr))
            let l:currbufname = bufname(l:currbufnr)
            if (match(l:currbufname, a:pattern) > -1)
                echo l:currbufnr.': '.bufname(l:currbufnr)
                let l:nummatches += 1
                let l:matchingbufnr = l:currbufnr
            endif
        endif
        let l:currbufnr += 1
    endwhile

    " only one match
    if (l:nummatches == 1)
        execute ':buffer '.l:matchingbufnr
    elseif (l:nummatches > 1)
        " more than one match
        let l:desiredbufnr = input('Enter buffer number: ')
        if (strlen(l:desiredbufnr) != 0)
            execute ':buffer '.l:desiredbufnr
        endif
    else
        echoerr 'No matching buffers'
    endif
endfunction
