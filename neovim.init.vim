scriptencoding utf-8
set encoding=utf-8

let mapleader = "\<Space>"
syntax on
set noincsearch
set nowrap
set nu
set numberwidth=5
set ts=4
set expandtab
set shiftwidth=4
set cindent
set hlsearch
set backspace=2
set t_Co=256
set background=dark
" mkdir -p ~/.config/nvim/autoload && wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -O ~/.config/nvim/autoload/plug.vim
" mkdir -p ~/.config/nvim/colors && curl -sSL 'https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim' -o ~/.config/nvim/colors/molokai.vim
colorscheme molokai
" colorscheme desert
" colorscheme elflord
" set mouse=a
set list listchars=tab:»·,trail:·

" Highlight current line
set cursorline nocursorcolumn

"set cscopequickfix=s-,c-,d-,i-,t-,e-
"if filereadable("./cscope.out")
"    cs a ./cscope.out
"endif

if filereadable("./tags")
    set tags+=./tags
    " set autochdir
endif

nmap    w=  :resize +3<CR>
nmap    w-  :resize -3<CR>
nmap    w,  :vertical resize -3<CR>
nmap    w.  :vertical resize +3<CR>
nmap    <leader>v :set paste!<CR>

map <C-d> :shell <CR>
nmap <C-w>t :let b:tmplinenum=line(".")<CR> :let b:tmpcolnum=col(".")<CR> :tabe %<CR> :cal cursor(b:tmplinenum, b:tmpcolnum)<CR>

set nocp "去掉讨厌的有关vi一致性模式，避免以前版本的一些bug和局限
set nocompatible  "去掉讨厌的有关vi一致性模式，避免以前版本的一些bug和局限

"""""""""""""""""""""""""""""""""""""""
filetype off
call plug#begin('~/.config/nvim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'majutsushi/tagbar'
Plug 'vim-php/tagbar-phpctags.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'jreybert/vimagit'
Plug 'ervandew/supertab'

"nvim-completion-manager
Plug 'roxma/nvim-completion-manager'
" Requires vim8 with has('python') or has('python3')
" Requires the installation of msgpack-python. (pip install msgpack-python)
if !has('nvim')
    Plug 'roxma/vim-hug-neovim-rpc'
endif

""""""""""""""""" LanguageClient-neovim
Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
" (Optional) Multi-entry selection UI.
Plug 'junegunn/fzf'
" (Optional) Multi-entry selection UI.
Plug 'Shougo/denite.nvim'
" (Optional) Completion integration with deoplete.
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" (Optional) Completion integration with nvim-completion-manager.
Plug 'roxma/nvim-completion-manager'
" (Optional) Showing function signature and inline doc.
Plug 'Shougo/echodoc.vim'

" Required for operations modifying multiple buffers like rename.
set hidden
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'javascript': ['/opt/javascript-typescript-langserver/lib/language-server-stdio.js'],
    \ }
" Automatically start language servers.
let g:LanguageClient_autoStart = 1
nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
""""""""""""""""" LanguageClient-neovim

Plug 'roxma/LanguageServer-php-neovim',  {'do': 'composer require felixfbecker/language-server && composer install && composer run-script parse-stubs && cd ~/.config/nvim/plugged/LanguageServer-php-neovim && composer run-script --working-dir=vendor/felixfbecker/language-server parse-stubs'}
autocmd FileType php LanguageClientStart

" requires phpactor
Plug 'phpactor/phpactor' ,  {'do': 'composer install'}
Plug 'roxma/ncm-phpactor'

Plug 'othree/csscomplete.vim'
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS noci

Plug 'nsf/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }

call plug#end()
filetype plugin indent on
"""""""""""""""""""""""""""""""""""""""

let g:SuperTabDefaultCompletionType = "<c-n>"

"NERDTree
"""""""""""""""""""""""""""""""""""""""
if filereadable(expand("~/.vim/bundle/nerdtree/plugin/NERD_tree.vim"))
    "show hidden files
    let NERDTreeShowHidden=1
    "open a NERDTree automatically when vim starts up
    autocmd vimenter * NERDTree | wincmd p
    let g:nerdtree_tabs_open_on_console_startup=1
    "let g:nerdtree_tabs_autofind=1
    "map a specific key or shortcut to open NERDTree
    map <C-n> :NERDTreeToggle<CR>
    "open NERDTree automatically when vim starts up on opening a directory
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
    "close vim if the only window left open is a NERDTree
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
endif
"""""""""""""""""""""""""""""""""""""""

"tagbar
"""""""""""""""""""""""""""""""""""""""
if filereadable(expand("~/.vim/bundle/tagbar/plugin/tagbar.vim"))
    " autocmd vimenter * Tagbar
    map <C-m> :TagbarToggle<CR>
endif
if filereadable(expand("~/.vim/bundle/tagbar-phpctags.vim/plugin/tagbar-phpctags.vim"))
    if filereadable(expand("/export/note/local/bin/phpctags"))
        let g:tagbar_phpctags_bin='/export/note/local/bin/phpctags'
        let g:tagbar_phpctags_memory_limit = '256M'
    endif
    let g:tagbar_type_ps1 = {
        \ 'ctagstype' : 'powershell',
        \ 'kinds'     : [
            \ 'f:function',
            \ 'i:filter',
            \ 'a:alias'
        \ ]
    \ }
endif
"""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""
" map <C-m> :call ToggleBackground()<CR>
" function! ToggleBackground()
"     if &background == "light"
"         set background=dark
"     else
"         set background=light
"     endif
" endfunction
"""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""
if filereadable(expand("~/.vim/bundle/nerdcommenter/plugin/NERD_commenter.vim"))
    " Add spaces after comment delimiters by default
    let g:NERDSpaceDelims = 1
    " Use compact syntax for prettified multi-line comments
    let g:NERDCompactSexyComs = 1
    " Align line-wise comment delimiters flush left instead of following code indentation
    let g:NERDDefaultAlign = 'left'
    " Set a language to use its alternate delimiters by default
    let g:NERDAltDelims_java = 1
    let g:NERDAltDelims_php = 1
    " Add your own custom formats or override the defaults
    let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
    " Allow commenting and inverting empty lines (useful when commenting a region)
    let g:NERDCommentEmptyLines = 1
    " Enable trimming of trailing whitespace when uncommenting
    let g:NERDTrimTrailingWhitespace = 1
endif
"""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""
if filereadable(expand("~/.vim/bundle/vim-airline-themes/plugin/airline-themes.vim"))
    let g:airline_powerline_fonts = 1
    let g:airline_theme='molokai'
    " let g:airline_extensions = ['tabline', 'branch']
    "
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#buffer_nr_show = 0
    let g:airline#extensions#tabline#show_buffers = 0
    let g:airline#extensions#tabline#show_tab_nr = 1
    let g:airline#extensions#tabline#tab_nr_type = 1
    let g:airline#extensions#tabline#left_sep = ' '
    let g:airline#extensions#tabline#left_alt_sep = '|'
    nmap <leader>1 <Plug>AirlineSelectTab1
    nmap <leader>2 <Plug>AirlineSelectTab2
    nmap <leader>3 <Plug>AirlineSelectTab3
    nmap <leader>4 <Plug>AirlineSelectTab4
    nmap <leader>5 <Plug>AirlineSelectTab5
    nmap <leader>6 <Plug>AirlineSelectTab6
    nmap <leader>7 <Plug>AirlineSelectTab7
    nmap <leader>8 <Plug>AirlineSelectTab8
    nmap <leader>9 <Plug>AirlineSelectTab9
    nmap <leader>- <Plug>AirlineSelectPrevTab
    nmap <leader>+ <Plug>AirlineSelectNextTab

    let g:airline#extensions#branch#enabled = 1
    let g:airline#extensions#branch#empty_message = ''
    let g:airline#extensions#branch#vcs_priority = ["git", "mercurial"]
    let g:airline#extensions#branch#use_vcscommand = 0
    let g:airline#extensions#branch#displayed_head_limit = 10
    let g:airline#extensions#branch#format = 0

    let g:airline#extensions#vimagit#enabled = 1

    " let g:minBufExplForceSyntaxEnable = 1
    " python from powerline.vim import setup as powerline_setup
    " python powerline_setup()
    " python del powerline_setup
    " set guifont=Inconsolata\ for\ Powerline:h14
    nnoremap <C-tab> :tabn<CR>
    nnoremap <C-s-tab> :tabp<CR>

    " 关闭状态显示空白符号计数,这个对我用处不大"
    let g:airline#extensions#whitespace#enabled = 0
    let g:airline#extensions#whitespace#symbol = '!'
endif
"""""""""""""""""""""""""""""""""""""""

"autocmd InsertLeave * se nocul  " 用浅色高亮当前行  
"autocmd InsertEnter * se cul    " 用浅色高亮当前行  
set showcmd         " 输入的命令显示出来，看的清楚些

" 显示中文帮助
if version >= 603
    set helplang=cn
    set encoding=utf-8
endif

set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936
set fileencoding=utf-8

"""""新文件模板""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"autocmd BufNewFile *.php 0r ~/.vim/template/php.tpl
"新建.c,.h,.sh,.java文件，自动插入文件头 
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java,*.php,*.go exec ":call GetTemplates()"
""定义函数GetTemplates，自动插入文件头 
func GetTemplates() 
    "如果文件类型为.sh文件 
    if &filetype == 'sh' 
        call setline(1,				"\#!/bin/bash")
        call append(line("."), 		"\##############################################")
        call append(line(".")+1, 	"\# filename: ".expand("%"))
        call append(line(".")+2, 	"\# author: huyaolong")
        call append(line(".")+3, 	"\# mail: huyaolong@yongche.com")
        call append(line(".")+4, 	"\# date: ".strftime("%Y-%m-%d"))
        call append(line(".")+5, 	"\##############################################")
        call append(line(".")+6, 	"")
    endif
    if &filetype == 'go' 
        call setline(1,				"/**")
        call append(line("."), 		" * Copyright ". strftime("%Y") ." harold. All rights reserved.")
        call append(line(".")+1, 	" * Filename: ".expand("%"))
        call append(line(".")+2, 	" * Author: harold")
        call append(line(".")+3, 	" * Mail: mail@yaolong.me")
        call append(line(".")+4, 	" * Date: ".strftime("%Y-%m-%d"))
        call append(line(".")+5, 	" */")
        call append(line(".")+6, 	"")
        call append(line(".")+7, 	"package ")
    endif
    " if &filetype == 'go'
    "     call setline(1,				"// Copyright ". strftime("%Y") ." harold. All rights reserved.")
    "     call append(line("."), 		"// Filename: ".expand("%"))
    "     call append(line(".")+1, 	"// Author: harold")
    "     call append(line(".")+2, 	"// Mail: mail@yaolong.me")
    "     call append(line(".")+3, 	"// Date: ".strftime("%Y-%m-%d"))
    "     call append(line(".")+4, 	"")
    "     call append(line(".")+5, 	"package ")
    " endif
    if &filetype == 'php'
        call setline(1,				"<?php")
        call append(line("."), 		"/**")
        call append(line(".")+1, 	" * @filename: ".expand("%"))
        call append(line(".")+2, 	" * @description:")
        call append(line(".")+3, 	" * @author: huyaolong@yongche.com")
        call append(line(".")+4, 	" * @date: ".strftime("%Y-%m-%d"))
        call append(line(".")+5, 	" */")
        call append(line(".")+6, 	"")
    endif
    "新建文件后，自动定位到文件末尾
    exec ":$"
endfunc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
