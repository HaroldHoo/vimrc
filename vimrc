scriptencoding utf-8
set encoding=utf-8

let mapleader = "\<Space>"
syntax on
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
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" mkdir -p ~/.vim/colors && curl -sSL 'https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim' -o ~/.vim/colors/molokai.vim
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

"vundle
"""""""""""""""""""""""""""""""""""""""
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'majutsushi/tagbar'
Plugin 'vim-php/tagbar-phpctags.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'airblade/vim-gitgutter'
Plugin 'jreybert/vimagit'
Plugin 'artur-shaik/vim-javacomplete2'
Plugin 'ervandew/supertab'
Plugin 'shawncplus/phpcomplete.vim'
Plugin 'Shougo/neocomplete.vim'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
" Plugin 'joker1007/vim-markdown-quote-syntax'
"
call vundle#end()
filetype plugin indent on
"""""""""""""""""""""""""""""""""""""""

"NERDTree
"""""""""""""""""""""""""""""""""""""""
if filereadable(expand("~/.vim/bundle/nerdtree/plugin/NERD_tree.vim"))
    "show hidden files
    let NERDTreeShowHidden=1
    let g:NERDTreeWinSize=20
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

set ofu=syntaxcomplete#Complete

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
        call append(line(".")+2, 	"\# author: yaolong")
        call append(line(".")+3, 	"\# mail: mail@yaolong.net")
        call append(line(".")+4, 	"\# date: ".strftime("%Y-%m-%d"))
        call append(line(".")+5, 	"\##############################################")
        call append(line(".")+6, 	"")
    endif
    if &filetype == 'go' 
        call setline(1,				"/**")
        call append(line("."), 		" * Copyright ". strftime("%Y") ." harold. All rights reserved.")
        call append(line(".")+1, 	" * Filename: ".expand("%"))
        call append(line(".")+2, 	" * Author: yaolong")
        call append(line(".")+3, 	" * Mail: mail@yaolong.net")
        call append(line(".")+4, 	" * Date: ".strftime("%Y-%m-%d"))
        call append(line(".")+5, 	" */")
        call append(line(".")+6, 	"")
        call append(line(".")+7, 	"package ")
    endif
    if &filetype == 'php'
        call setline(1,				"<?php")
        call append(line("."), 		"/**")
        call append(line(".")+1, 	" * @filename: ".expand("%"))
        call append(line(".")+2, 	" * @description:")
        call append(line(".")+3, 	" * @author: mail@yaolong.net")
        call append(line(".")+4, 	" * @date: ".strftime("%Y-%m-%d"))
        call append(line(".")+5, 	" */")
        call append(line(".")+6, 	"")
    endif
    "新建文件后，自动定位到文件末尾
    exec ":$"
endfunc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if filereadable(expand("~/.vim/bundle/vim-javacomplete2/README.md"))
    autocmd FileType java setlocal omnifunc=javacomplete#Complete
    nmap <F4> <Plug>(JavaComplete-Imports-AddSmart)
    nmap <F5> <Plug>(JavaComplete-Imports-Add)
    nmap <F6> <Plug>(JavaComplete-Imports-AddMissing)
    nmap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)
    nmap <leader>jI <Plug>(JavaComplete-Imports-AddMissing)
    nmap <leader>jR <Plug>(JavaComplete-Imports-RemoveUnused)
    nmap <leader>ji <Plug>(JavaComplete-Imports-AddSmart)
    nmap <leader>jii <Plug>(JavaComplete-Imports-Add)

    imap <C-j>I <Plug>(JavaComplete-Imports-AddMissing)
    imap <C-j>R <Plug>(JavaComplete-Imports-RemoveUnused)
    imap <C-j>i <Plug>(JavaComplete-Imports-AddSmart)
    imap <C-j>ii <Plug>(JavaComplete-Imports-Add)

    nmap <leader>jM <Plug>(JavaComplete-Generate-AbstractMethods)

    imap <C-j>jM <Plug>(JavaComplete-Generate-AbstractMethods)

    nmap <leader>jA <Plug>(JavaComplete-Generate-Accessors)
    nmap <leader>js <Plug>(JavaComplete-Generate-AccessorSetter)
    nmap <leader>jg <Plug>(JavaComplete-Generate-AccessorGetter)
    nmap <leader>ja <Plug>(JavaComplete-Generate-AccessorSetterGetter)
    nmap <leader>jts <Plug>(JavaComplete-Generate-ToString)
    nmap <leader>jeq <Plug>(JavaComplete-Generate-EqualsAndHashCode)
    nmap <leader>jc <Plug>(JavaComplete-Generate-Constructor)
    nmap <leader>jcc <Plug>(JavaComplete-Generate-DefaultConstructor)

    imap <C-j>s <Plug>(JavaComplete-Generate-AccessorSetter)
    imap <C-j>g <Plug>(JavaComplete-Generate-AccessorGetter)
    imap <C-j>a <Plug>(JavaComplete-Generate-AccessorSetterGetter)

    vmap <leader>js <Plug>(JavaComplete-Generate-AccessorSetter)
    vmap <leader>jg <Plug>(JavaComplete-Generate-AccessorGetter)
    vmap <leader>ja <Plug>(JavaComplete-Generate-AccessorSetterGetter)

    nmap <silent> <buffer> <leader>jn <Plug>(JavaComplete-Generate-NewClass)
    nmap <silent> <buffer> <leader>jN <Plug>(JavaComplete-Generate-ClassInFile)
endif

" append servlet jar libs
if filereadable(expand("/usr/share/tomcat/lib/annotations-api.jar"))
    let g:JavaComplete_LibsPath = "/usr/share/tomcat/lib/annotations-api.jar:/usr/share/tomcat/lib/catalina-ant.jar:/usr/share/tomcat/lib/catalina-ha.jar:/usr/share/tomcat/lib/catalina.jar:/usr/share/tomcat/lib/catalina-tribes.jar:/usr/share/tomcat/lib/commons-collections.jar:/usr/share/tomcat/lib/commons-dbcp.jar:/usr/share/tomcat/lib/jasper-el.jar:/usr/share/tomcat/lib/jasper.jar:/usr/share/tomcat/lib/jasper-jdt.jar:/usr/share/tomcat/lib/log4j.jar:/usr/share/tomcat/lib/tomcat7-websocket.jar:/usr/share/tomcat/lib/tomcat-api.jar:/usr/share/tomcat/lib/tomcat-coyote.jar:/usr/share/tomcat/lib/tomcat-el-2.2-api.jar:/usr/share/tomcat/lib/tomcat-i18n-es.jar:/usr/share/tomcat/lib/tomcat-i18n-fr.jar:/usr/share/tomcat/lib/tomcat-i18n-ja.jar:/usr/share/tomcat/lib/tomcat-jdbc.jar:/usr/share/tomcat/lib/tomcat-jsp-2.2-api.jar:/usr/share/tomcat/lib/tomcat-juli.jar:/usr/share/tomcat/lib/tomcat-servlet-3.0-api.jar:/usr/share/tomcat/lib/tomcat-util.jar:/usr/share/tomcat/lib/websocket-api.jar"
endif

if filereadable(expand("~/.vim/bundle/supertab/README.rst"))
    let g:SuperTabDefaultCompletionType = '<C-x><C-o>'
endif

autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
let g:phpcomplete_add_class_extensions = ['mongo']
let g:phpcomplete_add_function_extensions = ['mongo']
" let g:phpcomplete_add_class_extensions = ['memcached']
" let g:phpcomplete_add_function_extensions = ['memcached']

let g:neocomplete#enable_at_startup = 1
