" An example for a vimrc file.
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Dec 17
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
" if v:progname =~? "evim"
"   finish
" endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
"set backspace=indent,eol,start
set backspace=eol,start

"if has("vms")
"  set nobackup		" do not keep a backup file, use versions instead
"else
"  set backup		" keep a backup file
"endif

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq
"set columns=132
"set lines=40
set expandtab
set shiftwidth=2
set softtabstop=2
set t_kb= 

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
" Putty and VirtualBox copy/paste did not work in Window. Comment out
" if has('mouse')
"   set mouse=a
" endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
"
" let &t_Co=8
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif
" if $TERM == 'screen'
"   colorscheme evening
" endif

"if has("gui_running")
"  " changed directory to current file
"  " Used tab changed buffer autochdir not work
"  " set autochdir
"  autocmd BufEnter * silent! lcd%:p:h
"endif
"apply to both gui/nogui environment
autocmd BufEnter * silent! lcd%:p:h


" if has("gui_running")
"     set title
" else
"     set notitle
" endif

"if has("gui_running")
"  colorscheme desert
" else 
"   colorscheme evening
"endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on
  set pastetoggle=<F12>
  set autoindent		" always set autoindenting on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")


" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

set cpo+=W
autocmd BufReadPost * if &readonly | setlocal nomodifiable | else | setlocal modifiable | endif

" if version >= 700 && has("gui_running")
" endif
if version >= 700
    ":nnoremap gf <C-W>gf
    :nnoremap gf <C-W>f
    " :cab      e  tabe
    ":tab sball    
    "
    " set up tab labels with tab number, buffer name, number of windows
    if has("gui_running")
      set tabpagemax=25
      set guitablabel=\[%N\]\ %t\ %M
    "if exists("+showtabline")
    else
      "let Tlist_Inc_Winwidth=0
      set tabpagemax=5
      function MyTabLine()
        let s = ''
        let t = tabpagenr()
        let i = 1
        while i <= tabpagenr('$')
          let buflist = tabpagebuflist(i)
          let winnr = tabpagewinnr(i)

          "let s .= '%' . i . 'T'
          "let s .= (i == t ? '%1*' : '%2*')
          "let s .= i . ':'
          "let s .= ' %*'
          
          let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
          let s .= i . ':'
          let s .= winnr . '/' . tabpagewinnr(i,'$')
          let s .= ' '
          let bufnr = buflist[winnr - 1]
          let file = bufname(bufnr)
          let buftype = getbufvar(bufnr, 'buftype')
          if buftype == 'nofile'
            if file =~ '\/.'
              let file = substitute(file, '.*\/\ze.', '', '')
            endif
          else
            let file = fnamemodify(file, ':p:t')
          endif
          if file == ''
            let file = '[No Name]'
          endif
          if getbufvar(bufnr, "&modified")
            let file .= ' +'
          endif
          let s .= file . ' '
          let i = i + 1
        endwhile
        let s .= '%T%#TabLineFill#%='
        let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
        return s
      endfunction
      "set stal=2
      set tabline=%!MyTabLine()
  endif
endif

"set tags=$LOCAL_DV_DIR/tags,tags;/
"set tags=./tags;,$HOME/tags
set tags=./tags;,$LOCAL_DV_DIR/tags
"set path=./,$LOCAL_DV_DIR/share/**,$LOCAL_DV_DIR/verif/sys/env/**,$VERILIB/**,/users/home91/mattli/private/sv/uvm-1.1b/**,/usr/include/**,/proj/verif/share/veriLib/bin/gcc-4.7.2/include/**,/users/home91/mattli/private/sv/vmm-1.2.2b/**

set diffopt+=iwhite

"VCS Command 
"let VCSCommandEdit='edit'
"Show VCSInfo at statusline (slow)
"let g:VCSCommandEnableBufferSetup = 1
"set statusline=%<%f\ %{VCSCommandGetStatusLine()}\ %h%m%r%=%l,%c%V\ %P
"
"Full path file name
set statusline=%<%F\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set laststatus=2


let Tlist_Show_One_File=1
"let Tlist_Display_Prototype=1
"let Tlist_Show_Menu=1
"source $VIMRUNTIME/mswin.vim
"Copy to system clipboard not just for vim
"set clipboard=unnamed
"Window stype copy/paste
"source $VIMRUNTIME/mswin.vim
"This map is different from the one shown in vim documentation:
":noremap <LeftRelease> "+y<LeftRelease>

"augroup Systemverilog
"  autocmd!
"  autocmd FileType systemverilog setlocal omnifunc=syntaxcomplete#Complete foldmethod=indent
"augroup END

"Portable setting. It is useful when login to some share account
"alias gvim '~mattli/opt/bin/gvim -U ~mattli/.my_env_setup/vim/regression.vimrc'
"alias vim '~mattli/opt/bin/vim -u ~mattli/.my_env_setup/vim/regression.vimrc'

" set default 'runtimepath' (without ~/.vim folders)
let &runtimepath = printf('%s/vimfiles,%s,%s/vimfiles/after', $VIM, $VIMRUNTIME, $VIM)

" what is the name of the directory containing this file?
let s:portable = expand('<sfile>:p:h')

" add the directory to 'runtimepath'
let &runtimepath = printf('%s,%s,%s/after', s:portable, &runtimepath, s:portable)
