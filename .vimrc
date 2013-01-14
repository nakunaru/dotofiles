"" .vimrc

set nocompatible


" #############################
" ### Vundle settings start ###
" #############################
filetype off

set rtp+=~/.vim/vundle.git/
call vundle#rc()

" original repos on github
" Bundle 'tpope/vim-fugitive'
Bundle 'gmarik/vundle'
Bundle 'Shougo/unite.vim'
Bundle 'ujihisa/unite-colorscheme'


" Color Scheme
Bundle 'altercation/solarized'


" vim-scripts repos
" Bundle 'rails.vim'

" non github repos
" Bundle 'git://git.wincent.com/command-t.git'

filetype plugin indent on

" ###########################
" ### Vundle settings end ###
" ###########################


" ###########################
" ### 表示設定            ###
" ###########################
syntax on
set t_Co=256
set number
set background=dark
colorscheme darkblue


" TAB
set expandtab
set tabstop=4 shiftwidth=4 softtabstop=4
set cindent

" TAB, 行末の空白, 改行の可視化
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%

" 全角スペース
if has("syntax")
    syntax on

    " PODバグ対策
    syn sync fromstart

    function! ActivateInvisibleIndicator()
        " 下の行の"　"は全角スペース
        syntax match InvisibleJISX0208Space "　" display containedin=ALL
        highlight InvisibleJISX0208Space term=underline ctermbg=Blue guibg=darkgray gui=underline
    endf
    augroup invisible
        autocmd! invisible
        autocmd BufNew,BufRead * call ActivateInvisibleIndicator()
    augroup END
endif


" 検索設定
" インクリメントサーチ
set incsearch

" 検索ハイライト
set hlsearch    " 検索ハイライトon

" Esc*2でハイライトoff
nnoremap <Esc><Esc> :<C-u>set nohlsearch<Return>

" /, *, ?, # でハイライトon
nnoremap / :<C-u>set hlsearch <Return>/
nnoremap * :<C-u>set hlsearch <Return>*
nnoremap ? :<C-u>set hlsearch <Return>?
nnoremap # :<C-u>set hlsearch <Return>#




" ステータスバー
" ステータスバーを常に表示
set laststatus=2
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [ENC=%{&fileencoding}]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]

""""""""""""""""""""""""""""""
"挿入モード時、ステータスラインの色を変更
""""""""""""""""""""""""""""""
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=red ctermbg=black cterm=none'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction

if has('unix') && !has('gui_running')
  " ESC後にすぐ反映されない対策
  inoremap <silent> <Esc> <Esc>
endif



" 行カーソル
set cursorline



" ######################
" ### キー設定       ###
" ######################

"Insertモード中にカーソルキーを使用する
imap OA <UP>
imap OB <Down>
imap OC <Right>
imap OD <Left>

" Insertモード中のカーソル移動
inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-a> <Esc>0i
inoremap <C-e> <Esc>$a

" 括弧の中へ移動
inoremap () ()<Left>
inoremap <> <><Left>
inoremap [] []<Left>
inoremap {} {}<Left>
inoremap "" ""<Left>
inoremap '' ''<Left>
inoremap 「」 「」<Left>


" Unite settings
" バッファ一覧
nnoremap <C-u><C-b> :<C-u>Unite buffer<CR>
nnoremap <C-u><C-f> :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <C-u><C-r> :<C-u>Unite -buffer-name=register register<CR>


 



" ビジュアルモードでカッコを開始したら自動で選択範囲のカッコを閉じる
 " 参考：http://d.hatena.ne.jp/spiritloose/20061113/1163401194
vnoremap { "zdi{<C-R>z}<ESC>
vnoremap [ "zdi[<C-R>z]<ESC>
vnoremap ( "zdi(<C-R>z)<ESC>
vnoremap " "zdi"<C-R>z"<ESC>
vnoremap ' "zdi'<C-R>z'<ESC>
vnoremap % "zdi%<C-R>z<ESC>

 " 挿入モードでの移動
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>






