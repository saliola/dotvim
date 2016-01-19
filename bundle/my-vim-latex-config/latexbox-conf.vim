" set default viewer
if has("unix")
    let s:uname = system("uname")
    if s:uname == "Darwin\n"
        let g:LatexBox_viewer = "open -a /Applications/Skim.app"
        " use SyncTeX with the Skim viewer
        map <silent> <Leader>ls :silent
                \ !/Applications/Skim.app/Contents/SharedSupport/displayline
                \ <C-R>=line('.')<CR> "<C-R>=LatexBox_GetOutputFile()<CR>"
                \ "%:p" <CR>
    else
        let g:LatexBox_viewer = "gvfs-open"
    endif
endif

let g:LatexBox_output_type = "pdf"
"let g:LatexBox_latexmk_options = '-pdfdvi'

" disable async compile since it requires a vim server (complains in terminal)
let g:LatexBox_latexmk_async = 0

" run latexmk in continuous mode
let g:LatexBox_latexmk_preview_continuously = 1

" disable automatic opening the quickfix window post-compilation;
" use :copen to open the window; or use <Leader>le (latexbox errors)
let g:LatexBox_quickfix = 2

let g:LatexBox_show_warnings = 1
let g:LatexBox_ignore_warnings = [
            \ 'Underfull',
            \ 'Overfull',
            \ 'specifier changed to',
            \ 'LaTeX Font Warning: Font shape',
            \ 'Package xcolor Warning: Incompatible color definition on input line',
            \ ]


" Turn off folding of all environments, except for those explicitly specified.
let g:LatexBox_fold_envs = 0
let g:LatexBox_fold_envs_force = [
            \ "abstract",
            \ "exercice",
            \ "figure",
            \ "frame",
            \ "proof",
            \ "solution"
            \ ]

" activate folding, but turn off auto calculation of folds (*really slow*)
let g:LatexBox_Folding = 1
let g:LatexBox_fold_automatic = 0

augroup ft_tex
    autocmd!

    " ignore these filenames during tab completion
    autocmd FileType tex setlocal wildignore+=*.out,*.synctex.gz,*.aux,*.ilg,*.log,*.nls,*.idx,*.ind,*.blg,*.nlo,*.pdf,*.toc

    " set iskeyword (tex syntax file overides this....)
    autocmd FileType tex setlocal iskeyword=@,48-57,_,192-255

    " calculate folds when a file is loaded
    " autocmd BufRead *.tex LatexFold

    " If a key has not been pressed for some time, stop all latexmk processes.
    " If latexmk is running continuously in two different instances of vim, both
    " editing the same file that happens to be synced via Dropbox, then there is
    " a compilation loop and each loop creates "conflicted" versions of the file.
    set updatetime=300000
    autocmd CursorHold,CursorHoldI *.tex if !empty(g:latexmk_running_pids) | call LatexBox_LatexmkStop(0) | endif

    " makeprg: set the default makeprg to be compile with latexmk, if there is
    " no Makefile in the directory
    if filereadable("./Makefile")
        set makeprg=make
    else
        set makeprg=latexmk\ -g\ -pdf\ -output-directory=latexoutput\ %;\ cp\ latexoutput/%:r.pdf\ .;\ killall\ -s\ SIGHUP\ mupdf
    endif
augroup END
