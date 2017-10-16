
"               _           _                      _
"         /\   | |         | |                    ( )
"        /  \  | | _____  _| |_ _ __ __ _ ______ _|/ ___
"       / /\ \ | |/ _ \ \/ / __| '__/ _` |_  / _` | / __|
"      / ____ \| |  __/>  <| |_| | | (_| |/ / (_| | \__ \
"     /_/    \_\_|\___/_/\_\\__|_|  \__,_/___\__,_| |___/
"
"
"  _   _        __      ___                              __ _
" | \ | |       \ \    / (_)                            / _(_)
" |  \| | ___  __\ \  / / _ _ __ ___     ___ ___  _ __ | |_ _  __ _
" | . ` |/ _ \/ _ \ \/ / | | '_ ` _ \   / __/ _ \| '_ \|  _| |/ _` |
" | |\  |  __/ (_) \  /  | | | | | | | | (_| (_) | | | | | | | (_| |
" |_| \_|\___|\___/ \/   |_|_| |_| |_|  \___\___/|_| |_|_| |_|\__, |
"                                                              __/ |
"                                                             |___/
"
"
" Замена leader-key на запятую
let mapleader=","
" Plugin manager
" Specify a directory for plugins
call plug#begin('~/.config/nvim/plugged')

""""""""""""""""""""""""""""""""""""""""""
" Solarized color scheme
"
""""""""""""""""""""""""""""""""""""""""""
Plug 'altercation/vim-colors-solarized'

""""""""""""""""""""""""""""""""""""""""""
" работа с git
"
""""""""""""""""""""""""""""""""""""""""""
Plug 'tpope/vim-fugitive'

""""""""""""""""""""""""""""""""""""""""""
" работа с gist
"
""""""""""""""""""""""""""""""""""""""""""
Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'

""""""""""""""""""""""""""""""""""""""""""
" Gotham color scheme
"
""""""""""""""""""""""""""""""""""""""""""
Plug 'whatyouhide/vim-gotham'

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
"let g:indentLine_setColors = 0
"let g:indentLine_color_gui = '#A4E57E'

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
" Начало сессии с открытым деревом файлов
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
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
" Автодополнение, прийдется удалить
"
""""""""""""""""""""""""""""""""""""""""""
Plug 'Shougo/deoplete.nvim'


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

"
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
Plug '2072/PHP-Indenting-for-VIm'
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

"""""""""""""""""""""""""""""""""""""""""""
" множественные курсоры
"
"""""""""""""""""""""""""""""""""""""""""""
Plug 'terryma/vim-multiple-cursors'

" Default mapping
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'
"
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
"""""""""""""""""""""""""""""""""""""""""""
" открывает/скрывает все окна, кроме текущего
" <C-W>m
"
"""""""""""""""""""""""""""""""""""""""""""

Plug 'dhruvasagar/vim-zoom'

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
" автодополнение для php
"
"""""""""""""""""""""""""""""""""""""""""""

Plug 'shawncplus/phpcomplete.vim'

"""""""""""""""""""""""""""""""""""""""""""
" исправляет форматирование исходниго кода
"
""""""""""""""""""""""""""""""""""""""""""
Plug 'stephpy/vim-php-cs-fixer'

let g:php_cs_fixer_path = "~/.config/composer/vendor/bin/php-cs-fixer" " define the path to the php-cs-fixer.phar
let g:php_cs_fixer_level = "psr2"                 " which level ?
let g:php_cs_fixer_fixers_list = "-psr0"          " disable PSR-0.
let g:php_cs_fixer_config = "default"             " configuration
let g:php_cs_fixer_enable_default_mapping = 1     " Enable the mapping by default (<leader>pcd)
let g:php_cs_fixer_dry_run = 0                    " Call command with dry-run option
let g:php_cs_fixer_verbose = 0                    " Return the output of command if 1, else an inline information.
nnoremap <silent><leader>pcf :call PhpCsFixerFixFile()<CR>

"""""""""""""""""""""""""""""""""""""""""""
" автодополнение по Ctrl+Space
"
"""""""""""""""""""""""""""""""""""""""""""
Plug 'ervandew/supertab'

let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:SuperTabMappingForward = '<c-space>'

""""""""""""""""""""""""""""""""""""""""""
" подстветки синтаксиса
"
""""""""""""""""""""""""""""""""""""""""""
Plug 'StanAngeloff/php.vim'
Plug 'pangloss/vim-javascript'

""""""""""""""""""""""""""""""""""""""""""
" окружение скобками, ковычками и т.д.
"
""""""""""""""""""""""""""""""""""""""""""
Plug 'tpope/vim-surround'

autocmd FileType php let b:surround_45 = "<?php \r ?>"
""""""""""""""""""""""""""""""""""""""""""
" Call PlugInstall to insttpope/vim-surroundall new plugins
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
set autoread                            " перечитывать файл при внешнем изменении
set dir=~/.swp/                         " каталог для swp файлов
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
autocmd FileType c,cpp,java,php,javascript,python,twig,xml,yml,phtml,css autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

"}

" nvim интерфейс {

"set termguicolors
colorscheme gotham                      " Цветовая схема
set number                              " Включение номеров страниц
set rnu                                 " номера сторок отсчитываются вверх/низ от текущей
set cursorline                          " Подветка текущей строки
set lazyredraw                          " убирает прорисовку, убирая тормоза
set mousemodel=popup                    " разрешить контекстное меню
set cpoptions+=$                        " показывает что заменяется
set showmatch                           " показывает совпадающие кавычки, скобки
set showcmd                             " показывать команды
set scrolljump=5                        " на сколько строк прокручивается скролл
set scrolloff=3                         " сколько строк от низа до курсора перед прокруткой
set textwidth=80                        " ширина текстового поля
set linebreak                           " перенос по словам
"set showbreak=                         " Показывать символ на месте переноса
set showbreak=↪\ 
set ignorecase                          " игнорировать написание при поиске
set title                               " Установить заголовок окна
set smartcase                           " учитывать регисть если с большой буквы

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
imap jj <esc>                           " выходить из insert по jj

" Easier copy/paste
map <leader>v "+gP
map <leader>c "+y

nnoremap Y y$                           " скопировать все от курсора, до конца строки
nmap <silent> <leader>/ :nohlsearch<CR>" очистить выделение поиска

" Better navigating through omnicomplete option list
" See http://stackoverflow.com/questions/2170023/how-to-map-keys-for-popup-menu-in-vim
set completeopt=longest,menuone
function! OmniPopup(action)
    if pumvisible()
        if a:action == 'j'
            return "\<C-N>"
        elseif a:action == 'k'
            return "\<C-P>"
        endif
    endif
    return a:action
endfunction

inoremap <silent><C-j> <C-R>=OmniPopup('j')<CR>
inoremap <silent><C-k> <C-R>=OmniPopup('k')<CR>
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
"
" Highlight trailing whitespace in red
" Source: http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()


set guioptions-=T
    set guioptions-=m
    set guioptions+=LlRrb " bug?
    set guioptions-=LlRrb
    "set guifont=monospace\ 9 " Way better than monospace

