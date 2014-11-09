" .vimrc
" Author: Franco Saliola <saliola@gmail.com>
" credit: various sources, including steve losh's vimrc http://bitbucket.org/sjl/dotfiles/src/tip/vim/

" Things to look up ------------------------------------------------------- {{{
"
" <C-x><C-f>
" <C-x><C-l>
" <C-x><C-]>
" g*
" g#
" g;
" g,
" gv (reselect last visual selection)
" =ip (format inner paragraph)
" `` (jump to position before last jump)
" Explore
" Texplore
" tip: s//bar/g will replace the current search pattern with bar
" vim-unimpaired mappings
" :set spell spelllang=fr
" cox from vim-unimpaired to toggle cursorline and cursorcolumn (x)
" @: -- repeat last command-line (then use @@ to repeat)
" @@ -- repeat last @{0-9a-z":*} command
" :w !cmd -- execute cmd with give lines as std input, but do not replace (:write_c)
" ------------------------------------------------------------------------- }}}

" Pathogen ---------------------------------------------------------------- {{{

execute pathogen#infect()

" ------------------------------------------------------------------------- }}}
" Leaders ----------------------------------------------------------------- {{{

let mapleader = " "
let maplocalleader = "_"

" ------------------------------------------------------------------------- }}}
" vimrc ------------------------------------------------------------------- {{{

map <leader>vrc :tabnew $MYVIMRC<CR>
map <leader>vb :Texplore $HOME/.vim/bundle/<CR>

" Source the vimrc file after saving it
augroup vimrc
    au!
    au bufwritepost .vimrc source $MYVIMRC
    au bufwritepost ~/.vim/vimrc source $MYVIMRC
augroup END

augroup ft_vim
    au!
    au FileType vim setlocal foldmethod=marker
    au FileType help setlocal textwidth=78
    au FileType vim setlocal keywordprg=:help
    au BufWinEnter *.txt if &ft == 'help' | setlocal keywordprg=:help | endif
augroup END

" ------------------------------------------------------------------------- }}}
" Basic options ----------------------------------------------------------- {{{

set visualbell

set viminfo='20,\"50 " read/write a .viminfo file with at most 50 lines

" General Editing {{{ "

set encoding=utf-8
set nojoinspaces " only put one space after periods
set textwidth=0 " set textwidth to 75 to cause wrapping
set scrolloff=1 " always show n screen lines to above and below the cursor
set tabstop=4|set shiftwidth=4|set softtabstop=4|set expandtab " tab settings for all files
set nowrap " don't wrap text ; I have a wide monitor

" show trailing spaces as dots, highlight tabs, etc.
set list
set listchars=tab:▸-,extends:❯,precedes:❮,trail:· ",eol:¬
"set listchars+=eol:¬
set showbreak=…
match ErrorMsg /\t/

set backspace=indent,eol,start " allow backspacing over everything in insert mode

set formatoptions+=1n

set linebreak

" }}} General Editing "
" Searching {{{ "

set hlsearch " hightlight search
set incsearch " incremental search

" }}} Searching "
" Status line {{{ "

set laststatus=2
set showmode
set showcmd
set ruler " show the cursor position all the time

" }}} Status line "
" Line numbers {{{ "

set number
set relativenumber

" }}} Line numbers "
" Undo / Backup / Swap {{{ "

set undofile
set undoreload=10000
set undodir=~/.vim/tmp/undo//     " undo files

set backup
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files

set noswapfile       " no swap files

" }}} Undo / Backup / Swap "
" Windows {{{ "

set splitbelow
set splitright

" Resize splits when the window is resized
au VimResized * :wincmd =

" use | and - to split windows, which mimics tmux behaviour
nnoremap <silent> <C-W>\| <C-W>v
nnoremap <silent> <C-W>- <C-W>s

" }}} Windows "
" Spelling {{{ "

set nospell
set spellsuggest=5
"set dictionary+=~/.vim/spell/fr.utf-8.spl

" Look up word under cursor in a dictionary:
" - <Leader>d : Dictionary.app in Mac OSX
" - <Leader>gd : google dictionary (launch browser)
" - <Leader>wd : wordnet (launch browser)
" - <Leader>mw : merriam-webster thesaurus (launch browser)
if has("unix")
    let s:uname = system("uname")
    if s:uname == "Darwin\n"
        " Source: http://tammersaleh.com/posts/using-dictionary-app-with-vim/
        nnoremap <silent> <Leader>d :!open dict://<cword><CR><CR>
    else
        nnoremap <silent> <Leader>d :!open "https://www.google.ca/webhp?\#q=define:"<cword><CR><CR>
    endif
endif
nnoremap <silent> <Leader>gd :!open "https://www.google.ca/webhp?\#q=define:"<cword><CR><CR>
nnoremap <silent> <Leader>wn :!open "http://wordnetweb.princeton.edu/perl/webwn?s="<cword><CR><CR>
nnoremap <silent> <Leader>mw :!open "http://www.merriam-webster.com/thesaurus/"<cword><CR><CR>

" }}} Spelling "
" Thesaurus {{{ "

set thesaurus+=~/.vim/thesaurus/mthesaur.txt

" }}} Thesaurus "
" Command line mode ------------------------------------------------------- {{{

" wild card settings
set wildmenu
set wildmode=list:full

set history=50 " 50 lines of command lines history

" cursor movement in command line mode
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" ------------------------------------------------------------------------- }}}
" ------------------------------------------------------------------------- }}}
" Line Return ------------------------------------------------------------- {{{

" Make sure Vim returns to the same line when you reopen a file.
" Thanks, Steve Losh https://bitbucket.org/sjl/dotfiles/src/tip/vim/vimrc
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

" ------------------------------------------------------------------------- }}}
" Mappings ---------------------------------------------------------------- {{{

" Insert the current directory into a command-line path
" Notes:
" - if path contains whitespace, then ``escape`` will escape them
cmap <C-P> <C-R>=escape(expand("%:p:h"),' ') . "/"<CR>
" Insert the current filename into a command-line path
cmap %% <C-R>=escape(expand("%"),' ')<CR>

" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <Leader>t
map <Leader>t :tabnew
map <Leader>tp :tabnew <C-p>
map <Leader>tn :tabnew 
map <Leader>tN :tabnew ~/Dropbox/notes/
command! Notes :tabnew ~/Dropbox/notes/

" Scratchpad settings
command! ScratchPad :tabnew ~/Dropbox/scratchpad.rst

" Fullscreen with 
" command! FullScreenEditing :vertical new readonly | :vertical resize 120 | :wincmd w
command! FullScreenEditing :vertical new | :vertical resize 120 | :wincmd w

" Make the help key do something useful.
noremap  <F1> :checktime<cr>
inoremap <F1> <esc>:checktime<cr>

" Make the Q key to something useful.
nnoremap Q gqip
vnoremap Q gq

" Join an entire paragraph.
" Source: Steve Losh
nnoremap <Leader>J mzvipJ`z

" Don't move on *
" Source: Steve Losh
nnoremap <silent> * :let stay_star_view = winsaveview()<cr>*:call winrestview(stay_star_view)<cr>

" Highlight next search by pulsing the CursorLine and CursorColumn
" Source: mashup of Damien Conway's idea and Steve Losh's Pulse
nnoremap <silent> n   n:PulseX<cr>
nnoremap <silent> N   N:PulseX<cr>

" ------------------------------------------------------------------------- }}}
" Folding ----------------------------------------------------------------- {{{

" From Steve Losh:
" "Focus" the current line.  Basically:
"
" 1. Close all folds.
" 2. Open just the folds containing the current line.
" 3. Move the line a few lines above the center of the screen.
" 4. Pulse the cursor line.
"
" Warning: This mapping wipes out the z mark.
nnoremap <Leader>f mzzMzvzz10<c-e>`z:Pulse<cr>

" ------------------------------------------------------------------------- }}}
" Appearance -------------------------------------------------------------- {{{

" Pretty Colours
syntax enable " enable syntax highlighting
if has('gui_running')
    set background=light
    colorscheme solarized
else
    set background=dark
    set t_Co=256
    let g:solarized_termtrans = 1
    let g:solarized_termcolors=256
    let g:solarized_italic=0 " disable display of italics (bgcolor is too dark)
    colorscheme solarized
endif

" syntax colouring for folded blocks: turn off underlining in the terminal
highlight Folded term=none cterm=none

" Crosshair
set cursorline
set cursorcolumn

" Cursor column : highlight the 81st column of wide lines
" Source: Damien Conway
highlight ColorColumn ctermfg=16 ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

function! RedCursorLine()
    let w:red_cursor = exists('w:red_cursor') ? !w:red_cursor : 0
    if w:red_cursor
        colorscheme solarized
        set cursorline
        set cursorcolumn
        call matchadd('ColorColumn', '\%81v', 100)
    else
        set cursorline
        hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
        set nocursorcolumn
        hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
        set colorcolumn=
    endif
endfunction
command! RedCursorLine :call RedCursorLine()

" ------------------------------------------------------------------------- }}}
" Plugin settings --------------------------------------------------------- {{{

" CtrlP ------------------------------------------------------------------- {{{

" List of recent files, using CtrlP <https://github.com/kien/ctrlp.vim>
let g:ctrlp_cmd = 'CtrlPMRUFiles'
let g:ctrlp_by_filename = 1 " toggle with <c-d>
let g:ctrlp_regexp = 0 " toggle with <c-r>
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }
nmap <C-p> :<C-U>CtrlPMRUFiles<CR>

" ------------------------------------------------------------------------- }}}
" UltiSnips --------------------------------------------------------------- {{{

let g:snips_author="Franco Saliola"
let g:snips_author_email="saliola@gmail.com"

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

let g:UltiSnipsEditSplit="vertical"

" ------------------------------------------------------------------------- }}}
" Commentary -------------------------------------------------------------- {{{

nmap <leader>c <Plug>CommentaryLine
xmap <leader>c <Plug>Commentary

augroup plugin_commentary
    au!

    au FileType python,sage setlocal commentstring=#%s
augroup END

" ------------------------------------------------------------------------- }}}
" vim-tmux-navigator {{{ "

" vim-tmux-navigator overwrites <C-l>, so I need another way to use nohlsearch.
nnoremap <silent> <Esc><Esc> <Esc>:nohlsearch<CR><Esc>

" }}} vim-tmux-navigator "
" ------------------------------------------------------------------------- }}}
" Filetype-specific ------------------------------------------------------- {{{

" txt / rst {{{

augroup ft_txt
    au!

    " Use ReStructuredText syntax highlighting for .txt files
    autocmd BufWinEnter *.txt if &ft != 'help' | set filetype=rst | endif
augroup END

augroup ft_rst
    au!

    " set iskeyword (rst syntax file loads the lisp syntax file for code
    " blocks, which overwrites iskeyword)
    " au FileType rst setlocal iskeyword=@,48-57,a-z,A-Z,192-255
    au FileType rst setlocal iskeyword=@,48-57,_,192-255
augroup END

" }}}
" notes {{{

augroup ft_notes
    au!

    " Use ReStructuredText syntax highlighting for .notes and .txt files
    autocmd BufRead,BufNewFile *.notes set filetype=rst
augroup END

" }}}
" Hg {{{

function! OpenHGRejectFile()
    " splits window and opens the %.rej
    let filename=expand('%')
    let rejectsfile = filename.'.rej'
    split
    execute 'edit '.rejectsfile
endfunction
command! HGRejects :call OpenHGRejectFile()

" }}}
" Python {{{

augroup ft_python
    au!

    au FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
augroup END

" }}}
" bash vi-input mode {{{
" Syntax highlighting in Bash vi-input mode
" Source: http://stackoverflow.com/questions/7115324/syntax-highlighting-in-bash-vi-input-mode/7115478#7115478

augroup bash_vi_input_mode
    au!

    au BufRead,BufNewFile bash-fc-* set filetype=sh
augroup END

" }}}

" ------------------------------------------------------------------------- }}}
" Latex ------------------------------------------------------------------- {{{

augroup ft_tex
    au!

    " ignore these filenames during tab completion
    au FileType tex setlocal wildignore+=*.out,*.synctex.gz,*.aux,*.ilg,*.log,*.nls,*.idx,*.ind,*.blg,*.nlo,*.pdf,*.toc

    " load configuration
    au FileType tex source ~/.vim/bundle/my-vim-latex-config/latexbox-conf.vim

    " set iskeyword (tex syntax file overides this....)
    au FileType tex setlocal iskeyword=@,48-57,_,192-255
augroup END

" ------------------------------------------------------------------------- }}}
" Useful functions -------------------------------------------------------- {{{

" mapping to toggle (no)paste before pasting from the clipboard ----------- {{{

" Reference: http://tilvim.com/2014/03/18/a-better-paste.html
map <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>

" ------------------------------------------------------------------------- }}}
" Diff current file with the version on disk ------------------------------ {{{

" [From Hacking Vim, Chapter 4, by Kim Schulz]
function! DiffWithFileFromDisk()
    let filename=expand('%')
    let diffname = filename.'.fileFromBuffer'
    execute 'saveas! '.diffname
    diffthis
    vsplit
    execute 'edit '.filename
    diffthis
endfunction

" ------------------------------------------------------------------------- }}}
" Open the url under the cursor with gx ----------------------------------- {{{

if has("unix")
    let s:uname = system("uname")
    if s:uname == "Darwin\n"
        " defaults to 'open' on Mac OSX
        let g:netrw_browsex_viewer='-'
    else
        let g:netrw_browsex_viewer='gvfs-open'
    endif
endif

" ------------------------------------------------------------------------- }}}
" Show the highlight group syntax under the cursor ------------------------ {{{

" Show the stack of syntax hilighting classes affecting whatever is under the
" cursor.
" Source: Steve Losh
function! SynStack()
  echo join(map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")'), " > ")
endfunc

" ------------------------------------------------------------------------- }}}
" Pulse Line -------------------------------------------------------------- {{{
" Source: Steve Losh

function! s:PulseX(pulsesteps, pulseline, pulsecolumn, color) " {{{
    if a:pulseline == 1
        redir => old_hi_cursorline
            silent execute 'hi CursorLine'
        redir END
        let old_hi_cursorline = split(old_hi_cursorline, '\n')[0]
        let old_hi_cursorline = substitute(old_hi_cursorline, 'xxx', '', '')
    endif

    if a:pulsecolumn == 1
        redir => old_hi_cursorcolumn
            silent execute 'hi CursorColumn'
        redir END
        let old_hi_cursorcolumn = split(old_hi_cursorcolumn, '\n')[0]
        let old_hi_cursorcolumn = substitute(old_hi_cursorcolumn, 'xxx', '', '')
    endif

    let steps = a:pulsesteps
    let width = 1
    let start = width
    let end = steps * width
    let color = a:color

    for i in range(start, end, width)
        if a:pulseline
            execute "hi CursorLine ctermbg=" . (color + i)
        endif
        if a:pulsecolumn
            execute "hi CursorColumn ctermbg=" . (color + i)
        endif
        redraw
        sleep 6m
    endfor
    for i in range(end, start, -1 * width)
        if a:pulseline
            execute "hi CursorLine ctermbg=" . (color + i)
        endif
        if a:pulsecolumn
            execute "hi CursorColumn ctermbg=" . (color + i)
        endif
        redraw
        sleep 6m
    endfor

    if a:pulseline
        execute 'hi ' . old_hi_cursorline
    endif
    if a:pulsecolumn
        execute 'hi ' . old_hi_cursorcolumn
    endif
endfunction " }}}
command! -nargs=0 Pulse call s:PulseX(4, 1, 0, 160)
command! -nargs=0 PulseX call s:PulseX(2, 1, 1, 240)

" ------------------------------------------------------------------------- }}}
" Indent Guides ----------------------------------------------------------- {{{

let g:indentguides_state = 0
function! IndentGuides() " {{{
    if g:indentguides_state
        let g:indentguides_state = 0
        2match None
    else
        let g:indentguides_state = 1
        execute '2match IndentGuides /\%(\_^\s*\)\@<=\%(\%'.(0*&sw+1).'v\|\%'.(1*&sw+1).'v\|\%'.(2*&sw+1).'v\|\%'.(3*&sw+1).'v\|\%'.(4*&sw+1).'v\|\%'.(5*&sw+1).'v\|\%'.(6*&sw+1).'v\|\%'.(7*&sw+1).'v\)\s/'
    endif
endfunction " }}}
hi def IndentGuides guibg=#303030 ctermbg=234
nnoremap <leader>I :call IndentGuides()<cr>

" ------------------------------------------------------------------------- }}}
" Highlight Word ---------------------------------------------------------- {{{
"
" Source: Steve Losh
" This mini-plugin provides a few mappings for highlighting words temporarily.
"
" Sometimes you're looking at a hairy piece of code and would like a certain
" word or two to stand out temporarily.  You can search for it, but that only
" gives you one color of highlighting.  Now you can use <leader>N where N is
" a number from 1-6 to highlight the current word in a specific color.
"
" <leader>0 will clear the highlighting.

function! HiInterestingWord(n) " {{{
    if a:n == 0
        for m in range(1, 9)
            let mid = 86750 + m
            silent! call matchdelete(mid)
        endfor

    else
        " Save our location.
        normal! mz

        " Yank the current word into the z register.
        normal! "zyiw

        " Calculate an arbitrary match ID.  Hopefully nothing else is using it.
        let mid = 86750 + a:n

        " Clear existing matches, but don't worry if they don't exist.
        silent! call matchdelete(mid)

        " Construct a literal pattern that has to match at boundaries.
        let pat = '\V\<' . escape(@z, '\') . '\>'

        " Actually match the words.
        call matchadd("InterestingWord" . a:n, pat, 1, mid)

        " Move back to our original location.
        normal! `z
    endif
endfunction " }}}

" Mappings {{{

nnoremap <silent> <leader>1 :call HiInterestingWord(1)<cr>
nnoremap <silent> <leader>2 :call HiInterestingWord(2)<cr>
nnoremap <silent> <leader>3 :call HiInterestingWord(3)<cr>
nnoremap <silent> <leader>4 :call HiInterestingWord(4)<cr>
nnoremap <silent> <leader>5 :call HiInterestingWord(5)<cr>
nnoremap <silent> <leader>6 :call HiInterestingWord(6)<cr>
nnoremap <silent> <leader>7 :call HiInterestingWord(7)<cr>
nnoremap <silent> <leader>8 :call HiInterestingWord(8)<cr>
nnoremap <silent> <leader>9 :call HiInterestingWord(9)<cr>
nnoremap <silent> <leader>0 :call HiInterestingWord(0)<cr>

" }}}

" Default Highlights {{{

hi def InterestingWord1 guifg=#000000 ctermfg=16 guibg=#ffa724 ctermbg=214
hi def InterestingWord2 guifg=#000000 ctermfg=16 guibg=#aeee00 ctermbg=154
hi def InterestingWord3 guifg=#000000 ctermfg=16 guibg=#8cffba ctermbg=121
hi def InterestingWord4 guifg=#000000 ctermfg=16 guibg=#b88853 ctermbg=137
hi def InterestingWord5 guifg=#000000 ctermfg=16 guibg=#ff9eb8 ctermbg=211
hi def InterestingWord6 guifg=#000000 ctermfg=16 guibg=#ff2c4b ctermbg=195
hi def InterestingWord7 guifg=#000000 ctermfg=16 guibg=#d75faf ctermbg=169
hi def InterestingWord8 guifg=#000000 ctermfg=16 guibg=#ff005f ctermbg=197
hi def InterestingWord9 guifg=#000000 ctermfg=16 guibg=#ffd7ff ctermbg=225

" }}}

" ------------------------------------------------------------------------- }}}
" GetDigraphWrapper {{{ "

" Wrap C-k to allow backspace to interrupt digraph insertion;
" currently, it spits out <BS>, which is completely useless
" Source: loosely inspired by Damien Conway's HUDigraphs
function! GetDigraphWrapper ()
    let char1 = getchar()
    if (char1 == "\<BS>") | return "" | endif

    let char2 = getchar()
    if (char2 == "\<BS>") | return "" | endif

    return "\<C-K>" . nr2char(char1) . nr2char(char2)
endfunction

inoremap <expr> <C-K> GetDigraphWrapper()
cnoremap <expr> <C-K> GetDigraphWrapper()

" }}} GetDigraphWrapper "
" ------------------------------------------------------------------------- }}}
" Mac OSX Specific -------------------------------------------------------- {{{

" For the French keyboard on the MacBook: map the key §/± key to `/~
map! § `
map! ± ~

" enable copy/paste on Mac OSX and tmux (see also notes/macosx.notes)
set clipboard=unnamed

" ------------------------------------------------------------------------- }}}
" Experimental {{{ "

" Date-stamped file {{{ "
function! EditNewDatestampedFile(filename, extension)
    execute 'tabnew '.a:filename.'.'.strftime("%Y-%m-%d").'.'.a:extension
endfunction
" }}} Date-stamped file "
" Quick-fix grep {{{ "

function! GrepResultsInQuickFixWindow(searchpattern)

    " Save the current view
    let b:currentview = winsaveview()

    " Save the current iskeyword setting.
    let save_iskeyword = &iskeyword

    " Set last search pattern to a:searchpattern
    if a:searchpattern =~ "/.\\+/"
        let @/=a:searchpattern[1:-2]
    else
        let @/=a:searchpattern
    endif

    " Call vimgrep (populates the quickfix window)
    execute "lvimgrep ".a:searchpattern.' '.escape(expand("%"),' ')

    " open the quickfix window
    lopen

    " Use the same iskeyword setting as the original window so that search
    " matches agree. For instance, if the original window's iskeyword does not
    " contain _ (.tex files), then \<alpha\> will not match the alpha in
    " alpha_n if _ is in iskeyword. (iskeyword contains _, by default.)
    execute 'setlocal iskeyword=' . save_iskeyword

    " Use conceal to hide the filename from the location list.
    set conceallevel=2 concealcursor=nc
    syntax match qfFileName /^[^|]*/ transparent conceal
    " For some reason, conceal disables the syntax highlighting of the line
    " number, so let's re-establish it.
    syntax match myqfLineNr /[0-9]\+ col [0-9]\+/
    highlight link myqfLineNr qfLineNr

    " Match the current search pattern
    execute '2match GrepQuickfixTerm ' . a:searchpattern

    " Move to previous window
    wincmd w

    " Restore the view
    call winrestview(b:currentview)
endfunction

hi def GrepQuickfixTerm guifg=#000000 ctermfg=16 guibg=#ffa724 ctermbg=214


" You cannot set the last used search pattern and highlighting from within
" a function, see :help function-search-undo.

command! -nargs=1 QuickFixGrep call GrepResultsInQuickFixWindow(<f-args>)
nnoremap <Leader>g  :QuickFixGrep //<Left>
nnoremap <Leader>*  "zyiw:execute "QuickFixGrep /\\<".@z."\\>/"<CR>
nnoremap <Leader>g* "zyiw:execute "QuickFixGrep /".@z."/"<CR>

" }}} Quick-fix grep "

" }}} Experimental "
