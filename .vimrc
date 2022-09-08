"               _           _                      _
"         /\   | |         | |                    ( )
"        /  \  | | _____  _| |_ _ __ __ _ ______ _|/ ___
"       / /\ \ | |/ _ \ \/ / __| '__/ _` |_  / _` | / __|
"      / ____ \| |  __/>  <| |_| | | (_| |/ / (_| | \__ \
"     /_/    \_\_|\___/_/\_\\__|_|  \__,_/___\__,_| |___/
"
"
"               __      ___                              __ _
"               \ \    / (_)                            / _(_)
"                \ \  / / _ _ __ ___     ___ ___  _ __ | |_ _  __ _
"                 \ \/ / | | '_ ` _ \   / __/ _ \| '_ \|  _| |/ _` |
"                  \  /  | | | | | | | | (_| (_) | | | | | | | (_| |
"                   \/   |_|_| |_| |_|  \___\___/|_| |_|_| |_|\__, |
"                                                              __/ |
"                                                             |___/
"
"
" Замена leader-key на запятую
set tags=./tags;/
let mapleader=","
" Plugin manager
" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

""""""""""""""""""""""""""""""""""""""""""
" работа с git
"
""""""""""""""""""""""""""""""""""""""""""
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

""""""""""""""""""""""""""""""""""""""""""
" Gotham color scheme
"
""""""""""""""""""""""""""""""""""""""""""
Plug 'whatyouhide/vim-gotham'

""""""""""""""""""""""""""""""""""""""""""
" Gruvbox color scheme
"
""""""""""""""""""""""""""""""""""""""""""
Plug 'morhetz/gruvbox'
let g:gruvbox_contrast_dark = 'hard'

""""""""""""""""""""""""""""""""""""""""""
" Airline status bar
"
""""""""""""""""""""""""""""""""""""""""""
Plug 'vim-airline/vim-airline'

let g:airline_powerline_fonts = 1

""""""""""""""""""""""""""""""""""""""""""
" Добавляет линию таба
"
""""""""""""""""""""""""""""""""""""""""""
Plug 'Yggdroot/indentLine'

let g:indentLine_char = '┆'
let g:indentLine_setColors = 0
let g:indentLine_color_gui = '#A4E57E'

""""""""""""""""""""""""""""""""""""""""""
" Автоматическое закрытие
" скобок и кавычек
"
""""""""""""""""""""""""""""""""""""""""""
Plug 'jiangmiao/auto-pairs'

""""""""""""""""""""""""""""""""""""""""""
" NerdTree Дерево файловой системы
"
""""""""""""""""""""""""""""""""""""""""""
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}

" Открытие папки текущего файла
nmap <C-\> :NERDTreeFind<CR>
" Открытие-закрытие дерева файловой системы
nmap <silent> <leader>n :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" Разрешить показ закладок
let NERDTreeShowBookmarks=1
au FileType NERDTree set nolist

""""""""""""""""""""""""""""""""""""""""""
" отображает git статус в nerdtree
"
""""""""""""""""""""""""""""""""""""""""""
Plug 'Xuyuanp/nerdtree-git-plugin'

""""""""""""""""""""""""""""""""""""""""""
" отображает активные буферы
"
""""""""""""""""""""""""""""""""""""""""""
Plug 'jeetsukumaran/vim-buffergator'

""""""""""""""""""""""""""""""""""""""""""
" Добавление блока документации по
" <leader>doc
"
""""""""""""""""""""""""""""""""""""""""""
Plug 'mikehaertl/pdv-standalone'

nnoremap <leader>doc :call PhpDocSingle()<CR>
vnoremap <leader>doc :call PhpDocRange()<CR>
""""""""""""""""""""""""""""""""""""""""""
" Подстветка тегов
"
""""""""""""""""""""""""""""""""""""""""""
Plug 'Valloric/MatchTagAlways'
let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'php' : 1,
    \}

""""""""""""""""""""""""""""""""""""""""""
" добавление комментариев
"
""""""""""""""""""""""""""""""""""""""""""
Plug 'scrooloose/nerdcommenter'


""""""""""""""""""""""""""""""""""""""""""
" Подстветка цветов цвeтом в стилях
"
""""""""""""""""""""""""""""""""""""""""""
Plug 'gko/vim-coloresque'

""""""""""""""""""""""""""""""""""""""""""
" Emmet
"
""""""""""""""""""""""""""""""""""""""""""
Plug 'mattn/emmet-vim'

""""""""""""""""""""""""""""""""""""""""""
" Разноцветные скобки
"
""""""""""""""""""""""""""""""""""""""""""
Plug 'kien/rainbow_parentheses.vim'

""""""""""""""""""""""""""""""""""""""""""
" иконки
"
""""""""""""""""""""""""""""""""""""""""""
Plug 'ryanoasis/vim-devicons'

""""""""""""""""""""""""""""""""""""""""""
" отступы PHP vim
"
""""""""""""""""""""""""""""""""""""""""""
"Plug '2072/PHP-Indenting-for-VIm'
Plug 'captbaritone/better-indent-support-for-php-with-html'

"""""""""""""""""""""""""""""""""""""""""""
" проверка на ошибки
"
"""""""""""""""""""""""""""""""""""""""""""
Plug 'scrooloose/syntastic'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Syntastic configuration for PHP
let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']
let g:syntastic_php_phpcs_exec = '.config/composer/vendor/bin/phpcs'
let g:syntastic_php_phpcs_args = '--standard=psr2'
"let g:syntastic_php_phpmd_exec = '/home/alextraza/.config/composer/vendor/bin/phpmd'
let g:syntastic_php_phpmd_post_args = 'codesize,controversial,design,unusedcode'
"""""""""""""""""""""""""""""""""""""""""""
" быстрый переход
"
"""""""""""""""""""""""""""""""""""""""""""
Plug 'easymotion/vim-easymotion'

" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

""""""""""""""""""""""""""""""""""""""""""
" окружение скобками, ковычками и т.д.
"
""""""""""""""""""""""""""""""""""""""""""
Plug 'tpope/vim-surround'

autocmd FileType php let b:surround_45 = "<?php \r ?>"

"""""""""""""""""""""""""""""""""""""""""""
" переключатель раскладки клавиатуры
"
"""""""""""""""""""""""""""""""""""""""""""

Plug 'lyokha/vim-xkbswitch'

let g:XkbSwitchEnabled = 1
let g:XkbSwitchIMappings = ['ru']
let g:XkbSwitchAssistNKeymap = 1    " for commands r and f
let g:XkbSwitchAssistSKeymap = 1    " for search lines
let g:XkbSwitchDynamicKeymap = 1
let g:XkbSwitchKeymapNames = {'ru' : 'russian-jcukenwin',
            \ 'uk' : 'ukrainian-jcuken'}

"""""""""""""""""""""""""""""""""""""""""""
" добавляет use <leader>u
"
"""""""""""""""""""""""""""""""""""""""""""
Plug 'arnaud-lb/vim-php-namespace'
let g:php_namespace_sort_after_insert = 1


"""""""""""""""""""""""""""""""""""""""""""
" Автодополнение для php
"
"""""""""""""""""""""""""""""""""""""""""""
Plug 'phpactor/phpactor'

"""""""""""""""""""""""""""""""""""""""""""
" Подсветка для SASS
"
"""""""""""""""""""""""""""""""""""""""""""
Plug 'cakebaker/scss-syntax.vim'

"""""""""""""""""""""""""""""""""""""""""""
" org-mode for vim
"
"""""""""""""""""""""""""""""""""""""""""""
Plug 'jceb/vim-orgmode'
Plug 'tpope/vim-speeddating'


Plug 'rking/ag.vim'

call plug#end()

" Основные настройки {

filetype plugin on
filetype indent on
filetype plugin indent on               " автоматическое определение типа файла
set omnifunc=syntaxcomplete#Complete
syntax on                               " Включение подстветки синтаксиса
set mouse=a                             " разрешение мыши
"set virtualedit=all                    " разрешить курсору перемещаться дальше текста
set history=1000                        " хранить много истории
set encoding=utf8                       " кодировка по дефолту
set termencoding=utf8                   " Кодировка вывода на терминал
set fileencodings=utf8,cp1251,koi8r     " Возможные кодировки файлов (автоматическая перекодировка)
set clipboard=unnamed                   " копирование в системный буфер обмена
set helplang=ru                         " справка на русском
"set autoread                            " перечитывать файл при внешнем изменении
set dir=~/.swp//                         " каталог для swp файлов
" set backupdir=~/.swp/bkup//
" Подсветка непечатаемых символов
set listchars=tab:┆\ ,eol:¶,precedes:«,extends:»,trail:␣,nbsp:·
set list
"}

" форматирование {

set autoindent	                        " отступ на некоторый уровень от предыдущей линии
set smartindent                         " включаем умные отступы (в частности, отступы перед {, }, # и тд
set shiftwidth=4	                    " отступ в 4 пробела
set expandtab	                        " табуляции являются пробелами
set tabstop=4	                        "
set softtabstop=4	                    " backspase удаляет отступ
" Remove trailing whitespaces and ^M chars
autocmd FileType c,cpp,java,php,javascript,python,twig,xml,yml,phtml,css,sass autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))
"}

" vim интерфейс {

set termguicolors
"colorscheme gotham                      " Цветовая схема
colorscheme gruvbox                      " Цветовая схема
set background=dark
set number                              " Включение номеров страниц
set rnu                                 " номера сторок отсчитываются вверх/низ от текущей
set cursorline                          " Подветка текущей строки
set lazyredraw                          " убирает прорисовку, убирая тормоза
set mousemodel=popup                    " разрешить контекстное меню
"set cpoptions+=$                        " показывает что заменяется
set showmatch                           " показывает совпадающие кавычки, скобки
set showcmd                             " показывать команды
set scrolljump=5                        " на сколько строк прокручивается скролл
set scrolloff=3                         " сколько строк от низа до курсора перед прокруткой
set textwidth=85                        " ширина текстового поля
set linebreak                           " перенос по словам
set hlsearch
"set showbreak=                         " Показывать символ на месте переноса
set showbreak=↪\ 
set ignorecase                          " игнорировать написание при поиске
set title                               " Установить заголовок окна
set smartcase                           " учитывать регистр если с большой буквы

set clipboard=autoselect,unnamed,exclude:cons\|linux    " Помещать выделение в буфер обмена

" }

" "Allow to copy/paste between VIM instances
" "Copy the current visual selection to ~/.vbuf
vmap <Leader>y :w! ~/.vbuf<CR>
" "copy the current line to the buffer file if no visual selection
nmap <Leader>y :.w! ~/.vbuf<CR>
" "paste the contents of the buffer file
nmap <Leader>p :r ~/.vbuf<CR>

" Better command line editing
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" Перемещение между окнами
map <C-k> <C-w>k
map <C-j> <C-w>j
map <C-l> <C-w>l
map <C-h> <C-w>h
map <C-m> <C-w>m                        " скрыть остальные окна


"Easier copy/paste
map <leader>v "+gP
map <leader>c "+y

nnoremap Y y$                           " скопировать все от курсора, до конца строки

nmap <silent> <leader>/ :nohlsearch<CR>" очистить выделение поиска

" Highlight trailing whitespace in red
" Source: http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

set iskeyword=@,48-57,_,192-255 "w,b,e при нелатинской раскладке

function! IPhpExpandClass()
    call PhpExpandClass()
    call feedkeys('a', 'n')
endfunction
autocmd FileType php inoremap <Leader>e <Esc>:call IPhpExpandClass()<CR>
autocmd FileType php noremap <Leader>e :call PhpExpandClass()<CR>

function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
endfunction
autocmd FileType php inoremap <Leader><Leader>u <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <Leader><Leader>u :call PhpInsertUse()<CR>

if has("gui_running")
    set guioptions -=T
    set guioptions -=m
    set nomousehide
    set guioptions -=LlRrb
    set guifont=FiraCode\ Nerd\ Font\ 12

    set guicursor +=a:blinkon0
endif
