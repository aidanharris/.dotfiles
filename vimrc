"
" dotvim : https://github.com/dotphiles/dotvim
"
" Setup vim and load required plugins before dotvim
"
" Authors:
"   Ben O'Hara <bohara@gmail.com>
"

set encoding=utf-8
" Call dotvim
source ~/.vim/dotvim.vim

if has("user_commands")
  set nocompatible
  filetype off
  let g:python3_host_prog='python3'
  let g:python_host_prog='python2'
  set rtp+=~/.vim/bundle/vundle/
  call vundle#rc()
  "let g:vundles=['general', 'git', 'hg', 'programming', 'completion', 'ruby', 'python', 'misc']
  "let g:vundles=['general', 'misc', 'python', 'programming', 'git']
  let g:vundles=[]
  "let g:neocomplcache_enable_at_startup = 1
  " Load 'vundles'
  source ~/.vim/vundles.vim
  Bundle 'scrooloose/nerdtree'
  Bundle 'Xuyuanp/nerdtree-git-plugin'
  Bundle 'vim-airline/vim-airline-themes'
  Bundle 'rust-lang/rust.vim'
  Bundle 'KabbAmine/zeavim.vim'
  Bundle 'racer-rust/vim-racer'
  Bundle 'git://github.com/tpope/vim-dispatch.git'
  Bundle 'git://github.com/digitaltoad/vim-pug.git'
  Bundle 'editorconfig/editorconfig-vim'
  Bundle 'git://github.com/saltstack/salt-vim.git'
  Bundle 'git://github.com/leafgarland/typescript-vim.git'
  Bundle 'git://github.com/lambdatoast/elm.vim.git'
  Bundle 'OmniSharp/Omnisharp-vim'
  Bundle 'git://github.com/Valloric/YouCompleteMe.git'
  Bundle 'rdnetto/YCM-Generator'
  Bundle 'mattn/emmet-vim'
  Bundle 'rbgrouleff/bclose.vim'
  Bundle 'francoiscabrol/ranger.vim'
  Bundle 'PProvost/vim-ps1'
  Bundle 'gregsexton/gitv'
  Bundle 'mxw/vim-jsx'
  Bundle 'walm/jshint.vim'
  Bundle 'rhysd/open-pdf.vim'
  Bundle 'https://github.com/google/vim-ft-go.git'
  Bundle 'https://github.com/fatih/vim-go.git'
  Bundle 'sindresorhus/vim-xo'
  Bundle 'Chiel92/vim-autoformat'
  Bundle 'neomake/neomake'

  " Colour Schemes
  Bundle 'arcticicestudio/nord-vim'
  Bundle 'tomasr/molokai'
  Bundle 'altercation/vim-colors-solarized'
  Bundle 'google/vim-colorscheme-primary'
  Bundle 'https://github.com/joshdick/onedark.vim.git'
  Bundle 'sickill/vim-monokai'
  Bundle 'trusktr/seti.vim'
endif

filetype plugin on
":let base16colorspace=256

" JavaScript
let g:syntastic_javascript_checkers = ['standard']
let g:syntastic_javascript_standard_exec = 'semistandard'

" C#
let g:syntastic_cs_checkers = ['code_checker']
let g:OmniSharp_server_type = 'roslyn'

" Override colorscheme from base16
" Customize to your needs...
" Map NERDTree to Ctrl+\
map <C-\> :NERDTreeToggle<CR>
" Open NERDTree if no files were specified when starting vim
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Clear Vim Search with 'C'
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[]]

" Overrides for using Vim over an ssh connection
if $SSH_CONNECTION
  let g:dotvim_colorscheme = 'molokai'
endif

if $TERM == "xterm"
  set background = "dark"
endif

"if $VIM_COLOR_SCHEME != "" && $TERM != "xterm"
"  :let g:dotvim_colorscheme = $VIM_COLOR_SCHEME
"endif

"if has("gui_running")
"  :let $LC_TERM_PROFILE = "light"
"  set guifont=Hack\ 13
"  set background=light
"  colorscheme solarized
"endif

if $LC_TERM_PROFILE == "light"
  set background=light
else
  set background=dark
endif

if $VIM_COLOR_SCHEME != ""
  colorscheme $VIM_COLOR_SCHEME
else
  colorscheme molokai
endif

if $VIM_COLOR_SCHEME == "molokai" || $VIM_COLOR_SCHEME == ""
  let g:molokai_original = 1
  let g:rehash256 = 1
endif

" Remap Commands
" https://stackoverflow.com/questions/3878692/aliasing-a-command-in-vim#3879737
fun! SetupCommandAlias(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun

" Map semicolon to colon
nnoremap ; :
vnoremap ; :

" If the term command exists (e.g in Neovim) alias is to '!'
if exists("term")
  call SetupCommandAlias("!", "term")
  call SetupCommandAlias("!*", "term")
endif

" Set formatting options last so that it's not immediately
" overriden by any other plugins.
set tabstop=2
set shiftwidth=2
set softtabstop=0
set expandtab
