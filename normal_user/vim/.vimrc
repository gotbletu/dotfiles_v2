"       _                    
"__   _(_)_ __ ___  _ __ ___ 
"\ \ / / | '_ ` _ \| '__/ __|
" \ V /| | | | | | | | | (__ 
"  \_/ |_|_| |_| |_|_|  \___|
"                            
" gotbletu (@gmail|twitter|youtube|github|lbry)
"     https://www.youtube.com/user/gotbletu
"
"-------- Settings {{{
"------------------------------------------------------
""" General options
"set modeline
" set ls=2			" display jilename statusbar
" set title			" show title in console title bar
"set mouse-=a			" disable mouse automatically entering visual mode
"set mouse=a			" enable mouse support and activate visual mode with dragging

syntax on 			     " enable color syntax
" syntax enable                        " Enable syntax highlights
set ttyfast                          " Faster refraw
" set mouse=nv                         " Mouse activated in Normal and Visual Mode
set shortmess+=I                     " No intro when starting Vim
set autoindent                       " Copy the indent of the current line into a new line
set smartindent                      " Smart... indent
set expandtab                        " Insert spaces instead of tabs
set softtabstop=2                    " ... and insert two spaces
set shiftwidth=2                     " Indent with two spaces
set incsearch			     " Increamental search, find as you type word
set hlsearch                         " Highlight search results
set cursorline                       " Highligt the cursor line
" set cursorcolumn                     " Highlight the column line
set showmatch                        " When a bracket is inserted, briefly jump to the matching one
set matchtime=3                      " ... during this time
set virtualedit=onemore              " Allow the cursor to move just past the end of the line
set history=100                      " Keep 100 undo
set wildmenu                         " Better command-line completion
set scrolloff=10                     " Always keep 10 lines after or before when scrolling
set sidescrolloff=5                  " Always keep 5 lines after or before when side scrolling
set noshowmode                       " Don't display the current mode
set gdefault                         " The substitute flag g is on
set hidden                           " Hide the buffer instead of closing when switching
set backspace=indent,eol,start       " The normal behaviour of backspace
" set showtabline=2                    " Always show tabs
set laststatus=2                     " Always show status bar
set number                           " Show the line number
set relativenumber
set updatetime=1000
set ignorecase                       " Search insensitive
set smartcase                        " ... but smart
set showbreak=↪
set encoding=utf-8                   " The encoding displayed.
set fileencoding=utf-8               " The encoding written to file.
set synmaxcol=300                    " Don't try to highlight long lines
" set guioptions-=T                    " Don't show toolbar in Gvim

" Open all cmd args in new tabs
execute ":silent :tab all"

"}}}
"-------- Folding {{{
"------------------------------------------------------
" enable folding; http://vim.wikia.com/wiki/Folding
set foldmethod=marker

" fold color
hi Folded cterm=bold ctermfg=DarkBlue ctermbg=none
hi FoldColumn cterm=bold ctermfg=DarkBlue ctermbg=none

"refocus folds; close any other fold except the one that you are on
nnoremap ,z zMzvzz

" folding hotkeys
" S-v zf while in visual line mode create fold
" C-v zf while is visual block mode create fold
" zf#j   creates a fold from the cursor down numbers of lines.
" zf/    string creates a fold from the cursor to string .
" za     When on a closed fold, open it.and vice-versa.
" zA     When on a closed fold, open it recursively.and vice-versa
" zj     moves the cursor to the next fold.
" zk     moves the cursor to the previous fold.
" zo     opens a fold at the cursor.
" zO     opens all folds at the cursor.
" zm     increases the foldlevel by one.
" zM     closes all open folds.
" zr     decreases the foldlevel by one.
" zR     decreases the foldlevel to zero -- all folds will be open.
" zd     deletes the fold at the cursor.
" zE     deletes all folds.
" [z     move to start of open fold.
" ]z     move to end of open fold.

"}}}
"-------- Keybinding (BASH Commands) {{{
"------------------------------------------------------
" open with locate or find command
" tutorial video: https://www.youtube.com/watch?v=X0KPl5O006M
" leader = \

" convert current markdown file to pdf and open it in a pdf viewer
map <leader>cc :!md2pdf % -o /tmp/junk.pdf && nohup mupdf /tmp/junk.pdf >/dev/null 2>&1&<CR><CR>

" xdg-open
map <leader>oo :exec '!nohup xdg-open ' . shellescape(getline('.'), 1) . ' >/dev/null 2>&1&'<CR><CR>

" open parent directory of a file
" map <leader>fm :exec '!nohup xdg-open "$(echo ' . shellescape(getline('.'), 1) . ' \| rev \| cut -d\/ -f2- \| rev )" >/dev/null 2>&1&' <CR><CR>
map <leader>fm :exec '!nohup xdg-open "$(dirname ' . shellescape(getline('.'), 1) . ')" >/dev/null 2>&1&' <CR><CR>

" image viewer
map <leader>ff :exec '!nohup feh ' . shellescape(getline('.'), 1) . ' >/dev/null 2>&1&'<CR><CR>

" map <leader>mp :exec '!nohup mplayer ' . shellescape(getline('.'), 1) . ' >/dev/null 2>&1&'<CR><CR>


" stream justin tv ..etc
map <leader>li :exec '!livestreamer -p mplayer ' . shellescape(getline('.'), 1) . 'best' <CR><CR>

" watch streaming porn
" map <leader>p :exec '!youtube-dl -o - ' . shellescape(getline('.'), 1) . ' \| vlc -' <CR><CR>
" map <leader>p :exec '!nohup youtube-dl -o - ' . shellescape(getline('.'), 1) . ' \| vlc -' <CR><CR>

" audio player
map <leader>mm :exec '!mplayer ' . shellescape(getline('.'), 1) <CR><CR>

" add hash as torrent (newsbeuter via vim mode)
" e.g --> Size: 472 MB Seeds: 18 Peers: 10 Hash: aadb58a18f59ae5a3e8ca13eb06aa566a67a30ff
map <leader>hh :exec '!transmission-remote --add "magnet:?xt=urn:btih:$(echo ' . shellescape(getline('.'), 1) . ' \| cut -d\  -f9 )"' <CR><CR>

map <leader>ss :exec '!surfraw imagegoogle "$(echo ' . shellescape(getline('.'), 1) . ' \| cut -d\  -f2- )"' <CR><CR>
map <leader>ii :exec '!chromium --incognito "https://www.google.com/search?site=&tbm=isch&source=hp&biw=1280&bih=655&q=$(echo ' . shellescape(getline('.'), 1) . ' \| cut -d\  -f2- )"' <CR><CR>

map <leader>pp :exec '!tsp mpv --ontop --no-border --force-window --autofit=500x280 --geometry=-15-50 "$(echo ' . shellescape(getline('.'), 1) . ' \| cut -d\  -f4 )"' <CR><CR>

" video player
" map <leader>mp :exec '!nohup mpv ' . shellescape(getline('.'), 1) . ' >/dev/null 2>&1&'<CR><CR>
map <leader>mp :exec '!tsp mpv --ontop --no-border --force-window --autofit=500x280 --geometry=-15-50 ' . shellescape(getline('.'), 1) . ' && notify-send -t 5000 -i video-x-generic "MPV Queue" ' . shellescape(getline('.'), 1)<CR><CR>


" execute command on visual mode selection
" references: https://stackoverflow.com/a/5373376
xnoremap <leader>c <esc>:'<,'>:w !espeak<CR><CR>
xnoremap <leader>mk <esc>:'<,'>:w !mpv<CR><CR>

" download files
map <leader>yt :exec '!cd ~/Downloads; youtube-dl ' . shellescape(getline('.'), 1) <CR><CR>
map <leader>wg :exec '!cd ~/Downloads; wget -N -c ' . shellescape(getline('.'), 1) <CR><CR>

" open surfraw bookmarks
map <leader>sr :exec '!surfraw -browser=$BROWSER "$(echo ' . shellescape(getline('.'), 1) . ' \| cut -d" " -f1)"'<CR><CR>

" pyradio
" map <leader>ll :exec '!killall mplayer ; nohup mplayer "$(echo ' . shellescape(getline('.'), 1) . ' \| cut -d\, -f2 \| sed -r "s/\s+//g" )" >/dev/null 2>&1&' <CR><CR>
map <leader>ll :exec '!killall mpg123 ; nohup mpg123 -@ "$(echo ' . shellescape(getline('.'), 1) . ' \| cut -d\, -f2 \| sed -r "s/\s+//g" )" >/dev/null 2>&1&' <CR><CR>

"}}}
"-------- IntelliSense Autocomplete {{{
" https://importgeek.wordpress.com/2012/03/25/how-to-enable-autocomplete-in-vim-or-vim-intellisense/
" Ctrl+N to complete code
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete
"------------------------------------------------------
"}}}
"-------- Spell Checking {{{
"------------------------------------------------------
" http://vimcasts.org/episodes/spell-checking/
" http://tips.webdesign10.com/vim/how-use-vims-spellchecker
map <leader>sp :setlocal spell! spelllang=en_us<CR>
" en - all regions
" en_au - Australia
" en_ca - Canada
" en_gb - Great Britain
" en_nz - New Zealand
" en_us - USA

" spellchecking hotkeys
" ]s     move to the next mispelled word
" 4]s    skip to 4th mispelled word
" [s     move to the previous mispelled word
" zg     add a word to the dictionary
" zug    undo the addition of a word to the dictionary
" z=     view spelling suggestions for a mispelled word


" Spelling colors
" highlight clear SpellBad
" highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline
" highlight clear SpellCap
" highlight SpellCap term=underline cterm=underline
" highlight clear SpellRare
" highlight SpellRare term=underline cterm=underline
" highlight clear SpellLocal
" highlight SpellLocal term=underline cterm=underline

"}}}
"-------- Keybinding Commands {{{
"------------------------------------------------------
" http://www.jeffcomput.es/posts/2016/02/vim-tips-helpful-leader-key-commands/
" https://www.reddit.com/r/vim/comments/48n2ap/helpful_leader_key_commands_with_gifs/

" Command to toggle line wrapping
nnoremap <Leader>wr :set wrap! \| :set wrap?<CR>

" Commands to highlight the word under the cursor without moving the buffer view or cursor
" Useful for quickly identifying instances of a word. Use n or SHIFT-n to jump between matches and :noh to turn off highlighting.
"" Case sensitive, partial match inclusive.
nnoremap <Leader>hi :set hlsearch<CR>:let @/='<C-r><C-w>'<CR>
"" Case sensitive, no partial match.
nnoremap <Leader>ho :set hlsearch<CR>:let @/='\<<C-r><C-w>\>'<CR>
"" Case insensitive, partial match inclusive.
nnoremap <Leader>hu :set hlsearch<CR>:let @/='<C-r><C-w>\c'<CR>
"" Case insensitive, no partial match.
nnoremap <Leader>hy :set hlsearch<CR>:let @/='\<<C-r><C-w>\>\c'<CR>

" Toggle List (Whitespace) Display
" Can be useful depending on your Vim setup. I typically use 4 spaces for indentation but some people prefer tabs. My listchars variable is set to display tabs as >Â· but sometimes it is nice to quickly hide the list characters (especially if editing a file where someone mixed tabs and spaces, the savage).
nnoremap <Leader>li :set list! \| :set list?<CR>

" Zoom (Sorta)
" Zooming out can be useful for navigation (like the minimap in Sublime Text). Zooming in can be useful for presentations. Keep in mind this is not really a zoom, it is just changing the font size. This can cause some strange side-effects such as changing window size and position.
"" Simple zoom commands; Ultra, Extra, Normal, Out.
nnoremap <Leader>zu :set guifont=courier_new:h24<CR>
nnoremap <Leader>ze :set guifont=courier_new:h18<CR>
nnoremap <Leader>zn :set guifont=courier_new:h10<CR>
nnoremap <Leader>zo :set guifont=courier_new:h4<CR>

" Cursor Highlight
" Highlighting the cursor line is pretty standard but there is a known issue in Vim which causes slowdown when long lines are highlighted; quickly toggling line highlighting can be useful. Toggling column toggling can be occasionally useful too.
"" Bind command to toggle cursorline/cursorcolumn setting (slows scrolling speed when enabled).
nnoremap <Leader>cul :set cursorline!<CR>
nnoremap <Leader>cuc :set cursorcolumn!<CR>

" Fix Spelling
" Use this command to quickly fix spelling mistakes. Use ]s and [s to jump between flagged mistakes.
"" Bind command to fix spelling.
nnoremap <Leader>fs 1z=

" Bind command to open vimrc file.
nnoremap <Leader>vimrc :e $MYVIMRC<CR>


"}}}
"-------- Keybindings {{{
"------------------------------------------------------
" move thru word wrapped line
nnoremap k gk
nnoremap j gj

" highlight last inserted text
nnoremap gV `[v`]

" toggle line numbers
nmap <C-N><C-N> :set invnumber<CR>

" Go to beginning or end of line
" noremap H ^
" noremap L $

" keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" clear matching after search
noremap <silent> <leader><space> :noh<cr>:call clearmatches()<cr>

" move cursor to the center for the current line
" Note; gm = jumps to the middle of the screen only
" references: https://vi.stackexchange.com/a/2463
nnoremap gM :exe 'normal! '.(virtcol('$')/2).'\|'<cr>
noremap <expr> gM (virtcol('$') / 2) . '<Bar>'


"}}}
"-------- Visual {{{
"------------------------------------------------------
" auto toggle relativenumbers when changing between normal and insert mode
" autocmd InsertEnter * :set number norelativenumber
" autocmd InsertLeave * :set nonumber relativenumber


"}}}


""" Prevent lag when hitting escape
set ttimeoutlen=0
set timeoutlen=1000
au InsertEnter * set timeout
au InsertLeave * set notimeout

" unix or dos file format
" http://stackoverflow.com/a/82743
map <leader>unix :set fileformat=unix<CR>
map <leader>dos :set fileformat=dos<CR>

" copy or paste from X11 clipboard
" http://vim.wikia.com/wiki/GNU/Linux_clipboard_copy/paste_with_xclip
vmap <leader>xyy :!xclip -f -sel clip<CR>
map <leader>xpp mz:-1r !xclip -o -sel clip<CR>`z


vmap <leader>xtt :!tmux set-buffer<CR>

" write file if you forgot to give it sudo permission
" tutorial video: http://www.youtube.com/watch?v=C6xqO4Z1nIo
map <leader>sudo :w !sudo tee % <CR><CR>

" jump the the last / of a line
nmap <leader>/ $F/

"-------- important {{{
"------------------------------------------------------
" watch for changes then auto source vimrc
" http://stackoverflow.com/a/2403926
augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

"}}}
"-------- tabs and indenting {{{
"------------------------------------------------------
" move between matching opening and ending code; example { code }
map <tab> %

" Set tabstop, softtabstop and shiftwidth to the same value
" http://vimcasts.org/episodes/tabs-and-spaces/
" useage; :Stab
command! -nargs=* Stab call Stab()
function! Stab()
  let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
  if l:tabstop > 0
    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop
  endif
  call SummarizeTabs()
endfunction

function! SummarizeTabs()
  try
    echohl ModeMsg
    echon 'tabstop='.&l:ts
    echon ' shiftwidth='.&l:sw
    echon ' softtabstop='.&l:sts
    if &l:et
      echon ' expandtab'
    else
      echon ' noexpandtab'
    endif
  finally
    echohl None
  endtry
endfunction

"}}}
"-------- mapping {{{
"------------------------------------------------------



" quicker command line mode hotkey
" nmap ; :
" reload vimrc manually
map <leader>rld :source $MYVIMRC<CR>
" map <leader>rld :source ~/.vimrc<CR>


" Don't move on *
nnoremap * *<c-o>

" Heresy
inoremap <c-a> <esc>I
inoremap <c-e> <esc>A

" highlight current word; good to see different code
nnoremap <silent> <leader>h1 :execute 'match InterestingWord1 /\<<c-r><c-w>\>/'<cr>
nnoremap <silent> <leader>h2 :execute '2match InterestingWord2 /\<<c-r><c-w>\>/'<cr>
nnoremap <silent> <leader>h3 :execute '3match InterestingWord3 /\<<c-r><c-w>\>/'<cr>

" Clean trailing whitespace
nnoremap <leader>W mz:%s/\s\+$//<cr>:let @/=''<cr>`z

" Change case
inoremap <C-u> <esc>mzgUiw`za

" Emacs bindings in command line mode
" cnoremap <c-a> <home>
" cnoremap <c-e> <end>

" Select (charwise) the contents of the current line, excluding indentation.
" Great for pasting Python lines into REPLs.
nnoremap vv ^vg_


" color highlight line
"set cul                                           " highlight current line
"hi CursorLine term=none cterm=none ctermbg=3      " adjust color


" reopen file where you left off at
" http://stackoverflow.com/questions/774560
" make sure to have permissions to ~/.viminfo if it doesnt work
" sudo chown user:group ~/.viminfo
" where user is your username and group is often the same as your username
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

"}}}


"------------------------------------------////
"	    VIM CONFIGURATION
"------------------------------------------////
set t_Co=256  " enable 256color support

scriptencoding utf-8
set encoding=utf-8
"set listchars=trail:Â·,precedes:Â«,extends:Â»,eol:â²,tab:â¸\

"-------- Themes {{{
"------------------------------------------------------
syntax enable
" set background=light
set background=dark


"}}}
"-------- New Shit {{{
"------------------------------------------------------
" http://blog.bodhizazen.net/linux/command-line-spell-checking/
" Show matching [] and {}
"	set showmatch
"
"	" Spell check on
"	set spell spelllang=en_us
"	setlocal spell spelllang=en_us
"
"	" Toggle spelling with the F7 key
"	nn <F7> :setlocal spell! spelllang=en_us<CR>
"	imap <F7> <C-o>:setlocal spell! spelllang=en_us<CR>
"
"	" Spelling
"	highlight clear SpellBad
"	highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline
"	highlight clear SpellCap
"	highlight SpellCap term=underline cterm=underline
"	highlight clear SpellRare
"	highlight SpellRare term=underline cterm=underline
"	highlight clear SpellLocal
"	highlight SpellLocal term=underline cterm=underline
"
"	" where it should get the dictionary files
"	let g:spellfile_URL = 'http://ftp.vim.org/vim/runtime/spell'

"}}}
" Indent Guides {{{

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
hi def IndentGuides guibg=#303030
nnoremap <leader>I :call IndentGuides()<cr>

" }}}

" Send visual selection to gist.github.com as a private, filetyped Gist
" Requires the gist command line too (brew install gist)
" vnoremap <leader>G :w !gist -p -t %:e \| pbcopy<cr>
" vnoremap <leader>UG :w !gist -p \| pbcopy<cr>

" Visual Mode */# from Scrooloose {{{

function! s:VSetSearch()
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  let @@ = temp
endfunction

vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR><c-o>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR><c-o>

" }}}


" Word Processor Mode
" http://jasonheppler.org/2012/12/05/word-processor-mode-in-vim/
" http://robots.thoughtbot.com/wrap-existing-text-at-80-characters-in-vim
func! WordProcessorMode()
    setlocal formatoptions=t1
    setlocal textwidth=80
    map j gj
    map k gk
    setlocal smartindent
    setlocal spell spelllang=en_us
    setlocal noexpandtab
endfu
com! WP call WordProcessorMode()

" http://robots.thoughtbot.com/wrap-existing-text-at-80-characters-in-vim
" http://www.drbunsen.org/writing-in-vim/

"{{{ Word Wrapping
" better word wrapping: breaks at spaces or hyphens
set formatoptions=l
set lbr

"}}}







" Block Colors
" let g:blockcolor_state = 0
" function! BlockColor() "
"     if g:blockcolor_state
"         let g:blockcolor_state = 0
"         call matchdelete(77881)
"         call matchdelete(77882)
"         call matchdelete(77883)
"         call matchdelete(77884)
"         call matchdelete(77885)
"     else
"         let g:blockcolor_state = 1
"         call matchadd("BlockColor1", '^ \{4}.*', 1, 77881)
"         call matchadd("BlockColor2", '^ \{8}.*', 2, 77882)
"         call matchadd("BlockColor3", '^ \{12}.*', 3, 77883)
"         call matchadd("BlockColor4", '^ \{16}.*', 4, 77884)
"         call matchadd("BlockColor5", '^ \{20}.*', 5, 77885)
"     endif
" endfunction "

" Ranger as a drop-in replacement for the vim file selector
" source: https://www.reddit.com/r/vim/comments/2va2og/ranger_the_cli_file_manager_xpost_from/cog2ley/
function! RangerChooser()
    let temp = tempname()
    exec 'silent !ranger --choosefiles=' . shellescape(temp)
    if !filereadable(temp)
        redraw!
        " Nothing to read.
        return
    endif
    let names = readfile(temp)
    if empty(names)
        redraw!
        " Nothing to open.
        return
    endif
    " Edit the first item.
    exec 'edit ' . fnameescape(names[0])
    " Add any remaning items to the arg list/buffer list.
    for name in names[1:]
        exec 'argadd ' . fnameescape(name)
    endfor
    redraw!
endfunction

command! RangerChooser :call RangerChooser()
nnoremap <leader>rr :<C-U>RangerChooser<CR>

" vim statusline bar color
hi StatusLine ctermbg=white ctermfg=black


" move visual selection
" https://www.youtube.com/watch?v=X5IAdaN6IwM
" xnoremap <silent> K :call wincent#mappings#visual#move_up()<CR>
" xnoremap <silent> J :call wincent#mappings#visual#move_down()<CR>


"-------- Macros {{{
"------------------------------------------------------
" references: https://stackoverflow.com/a/2024537
" q<letter> = record (e.g qf)
" :reg to list all macros in register (dont copy and paste with mouse)
" use --> ("<letter>p) --> (e.g "fp)

" let @x = '0Akbj0'
let @r = '0~wl~wl~wl~wl~wl~wl~wl~wl~wl~wl~wl~wl~wl~wl~wl~wl~wl~wl~wl~wl~wl~'
let @q = ":let a=line('.')<cr>0~wl~wl~wl~wl~wl~wl~wl~wl~wl~wl~wl~wl~wl~wl~wl~wl~wl~wl~wl~wl~wl~\r" . @q . ":if line('.')==a|exe 'norm @q'|endif\r"



" add single qoutes to w3m links then save exit vim
let @b = "0wi't a'"
nmap <leader>bb @b:x<CR>


" Capitalize First Letter of everyword
" references:
" https://stackoverflow.com/a/17440797
" https://stackoverflow.com/a/99182
" http://vim.wikia.com/wiki/Switching_case_of_characters
" http://vim.wikia.com/wiki/Mapping_keys_in_Vim_-_Tutorial_(Part_2)
" capitalize | lowercase last extension and add in period e.g .mp4 | clear highlight
" nmap <leader>zz :s/\<./\u&/ \| :norm $guiw<CR>:norm $bhx<ESC>:normal i.<ESC> \| :noh <CR>
" vnoremap <leader>zz :s/\<./\u&/ \| :norm $guiw<CR>:norm $bhx<ESC>:normal i.<ESC> \| :noh <CR>
" vnoremap <leader>zz :s/\<./\u&/<CR>:noh<CR>
nmap <leader>zz :s/\<./\u&/<CR>:noh<CR>


"}}}
"-------- Find and Replace Text {{{
"------------------------------------------------------
" Search only in a visual range (author: David Fishburn)
" http://vim.wikia.com/wiki/Search_only_over_a_visual_range
function! RangeSearch(direction)
  call inputsave()
  let g:srchstr = input(a:direction)
  call inputrestore()
  if strlen(g:srchstr) > 0
    let g:srchstr = g:srchstr.
          \ '\%>'.(line("'<")-1).'l'.
          \ '\%<'.(line("'>")+1).'l'
  else
    let g:srchstr = ''
  endif
endfunction
vnoremap <silent> / :<C-U>call RangeSearch('/')<CR>:if strlen(g:srchstr) > 0\|exec '/'.g:srchstr\|endif<CR>
vnoremap <silent> ? :<C-U>call RangeSearch('?')<CR>:if strlen(g:srchstr) > 0\|exec '?'.g:srchstr\|endif<CR>

" find and replace: search for text and replace all text
" usage: use / to find text then hit <leader>fr to replace all
nmap <leader>fr :%s///<Left>

"}}}
"-------- Mapping Legends {{{
"------------------------------------------------------
" http://vim.wikia.com/wiki/Mapping_keys_in_Vim_-_Tutorial_(Part_1)
"
" nunmap - Unmap a normal mode map
" vunmap - Unmap a visual and select mode map
" xunmap - Unmap a visual mode map
" sunmap - Unmap a select mode map
" iunmap - Unmap an insert and replace mode map
" cunmap - Unmap a command-line mode map
" ounmap - Unmap an operator pending mode map
"
" mapclear  - Clear all normal, visual, select and operating pending mode maps
" mapclear! - Clear all insert and command-line mode maps
" nmapclear - Clear all normal mode maps
" vmapclear - Clear all visual and select mode maps
" xmapclear - Clear all visual mode maps
" smapclear - Clear all select mode maps
" imapclear - Clear all insert mode maps
" cmapclear - Clear all command-line mode maps
" omapclear - Clear all operating pending mode maps
"
" nmap, nnoremap, nunmap          Normal mode
" imap, inoremap, iunmap          Insert and Replace mode
" vmap, vnoremap, vunmap          Visual and Select mode
" xmap, xnoremap, xunmap          Visual mode
" smap, snoremap, sunmap          Select mode
" cmap, cnoremap, cunmap          Command-line mode
" omap, onoremap, ounmap          Operator pending mode

"}}}
"-------- empty {{{
"------------------------------------------------------

"}}}
"-------- empty {{{
"------------------------------------------------------

"}}}
"-------- empty {{{
"------------------------------------------------------

"}}}


"-------- vim-plug - Minimalist Vim Plugin Manager {{{
"------------------------------------------------------
" https://github.com/junegunn/vim-plug
" Usage: add in new Plug <url> then save vimrc then do :PlugInstall
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'https://github.com/vimwiki/vimwiki.git'
Plug 'https://github.com/tomtom/tcomment_vim.git'
Plug 'https://github.com/suan/vim-instant-markdown.git'
" Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
Plug 'https://github.com/altercation/vim-colors-solarized.git'
Plug 'https://github.com/sirver/UltiSnips'    " snippet program only, no code snippet provided
Plug 'https://github.com/honza/vim-snippets'  " code snippet of many programming language
Plug 'https://github.com/tpope/vim-surround'  " :help surround
" Plug 'https://github.com/ctrlpvim/ctrlp.vim'

call plug#end()

"}}}
"-------- vimwiki - Personal Wiki for Vim (Markdown Supported) {{{
"------------------------------------------------------
" https://github.com/vimwiki/vimwiki
set nocompatible
filetype plugin on
syntax on

" enable markdown in vimwiki
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}

" helppage -> :h vimwiki-syntax
"}}}
"-------- vim-instant-markdown - Instant Markdown previews from Vim {{{
"------------------------------------------------------
" https://github.com/suan/vim-instant-markdown
let g:instant_markdown_autostart = 0	" disable autostart

" start instant markdown preview manually
map <leader>md :InstantMarkdownPreview<CR>

"}}}
"-------- vim-colors-solarized - Solarized Theme {{{
"------------------------------------------------------
" https://github.com/altercation/vim-colors-solarized
colorscheme solarized


"}}}
"-------- ultisnips - The ultimate snippet solution for Vim {{{
"------------------------------------------------------
" https://github.com/SirVer/ultisnips

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
"}}}



" Sorting words on the same line
" https://stackoverflow.com/questions/1327978/sorting-words-not-lines-in-vim/1329899#1329899
vnoremap <F10> d:execute 'normal i' . join(sort(split(getreg('"'))), ' ')<CR>
