" __  __        __     ___                    
"|  \/  |_   _  \ \   / (_)_ __ ___  _ __ ___ 
"| |\/| | | | |  \ \ / /| | '_ ` _ \| '__/ __|
"| |  | | |_| |   \ V / | | | | | | | | | (__ 
"|_|  |_|\__, |    \_/  |_|_| |_| |_|_|  \___|
"        |___/                                
"
"
"


" ┌─────────┐
" │ Options │
" └─────────┘

set mouse=a
set notermguicolors
set encoding=utf-8
let mapleader = " "
syntax on
set number relativenumber
set noswapfile
set scrolloff=6
"set wrap
"set wildmenu
"set wildmode=list:longest
set hlsearch
"exec "nohlsearch"
set ignorecase
set smartcase
set nocompatible
set tabstop=4 softtabstop=4
" set shiftwidth=4
set nu

"python
set softtabstop=4 shiftwidth=4 expandtab
set autoindent
set fileformat=unix


" ┌──────┐
" │ edit │
" └──────┘

nmap H ^
nmap L $
vmap H ^
vmap L $


" Insert
imap jk <C-[>
imap <C-a> <esc>I
imap <C-e> <esc>A
imap <C-b> <Left>
imap <C-f> <Right>



nmap \ :
imap ; <C-[>
map S :w<CR>
map Q :q<CR>
map R :source $MYVIMRC<CR>
noremap <LEADER><CR> :nohlsearch<CR>

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


" ┌──────────┐
" │ Cmd Mode │
" └──────────┘
cmap <C-b> <Left>
cmap <C-f> <Right>
cmap <C-a> <Home>
cmap <C-e> <End>
cmap <C-d> <Del>
cmap <C-h> <BS>

"number 1: moving text 
"vnoremap K :m '<-2<CR>gv=gv
"vnoremap J :m '>+1<CR>gv=gv 
"inoremap <C-J> <esc>: m .+1<CR>== 
"inoremap <C-K> <esc>: m .-2<CR>==
"nnoremap <Leader>k :m .-2<CR>==
"nnoremap <Leader>j :m .+1<CR>==


"https://github.com/skywind3000/asyncrun.git 
"https://github.com/skywind3000/asyncrun.vim

"===
"=== indent guides
"===
let g:indent_guides_enable_on_vim_startup = 1


" NERDTree快捷键
" map <silent> <C-e> :NERDTreeToggle<CR>

" Find files using Telescope command-line sugar.
"nnoremap <leader>ff <cmd>Telescope find_files<cr>
"nnoremap <leader>fg <cmd>Telescope live_grep<cr>
"nnoremap <leader>fb <cmd>Telescope buffers<cr>
"nnoremap <leader>fh <cmd>Telescope help_tags<cr>


"colorscheme onedark
"colorscheme tokyonight

" tokyonight:start
"set termguicolors
"let g:tokyonight_style = 'night' " available: night, storm
"let g:tokyonight_enable_italic = 1
"colorscheme tokyonight
"" tokyonight:end
"colorscheme material
"let g:material_theme_style = 'palenight'
"
"" Fix italics in Vim
"if !has('nvim')
"  let &t_ZH="\e[3m"
"  let &t_ZR="\e[23m"
"endif
"let g:material_terminal_italics = 1
"

"set background=dark
"set t_Co=256


if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" python
"nmap <C-_> <Plug>NERDCommenterToggle
"vmap <C-_> <Plug>NERDCommenterToggle<CR>gv
"
" Tabs
nmap <TAB> gt
nmap <S-TAB> gT
nmap <C-w> :bd<CR>



"let g:floaterm_keymap_new = '<Leader>ft'
"nnoremap <leader>ft <cmd>FloatermNew<cr>
"nnoremap <leader>fs <cmd>FloatermKill<cr>

" whichkey
set timeoutlen=100
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

" F5 to run sh/python3
"map <F5> :call CompileRunGcc()<CR>
map <C-p> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'sh'
        :!time bash %
    elseif &filetype == 'python'
        exec "!time python %"
    elseif &filetype == 'go'
        exec "!time go run %"
    endif
endfunc



" Better tabbing
vnoremap < <gv
vnoremap > >gv

" tweaks for browsiing
let g:netrw_banner=0   " don't show the banner
let g:netrw_browse_split=4 " split the window in half
let g:netrw_altv=1     " use alt-v for vertical split

augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \	execute 'normal! g`"zvzz' |
        \ endif
augroup END
