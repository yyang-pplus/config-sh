" Turn on plug-in
filetype plugin on

" Indentation
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

" Show the next match while entering a search
set incsearch
" Highlighting search matches
set hlsearch

" Copy filename to clipboard
if has('win32')
    " Convert slashes to backslashes for Windows.
    nmap ,cs :let @+=substitute(expand("%"), "/", "\\", "g")<CR>
    nmap ,cl :let @+=substitute(expand("%:p"), "/", "\\", "g")<CR>

    " This will copy the path in 8.3 short format, for DOS and Windows 9x
    nmap ,c8 :let @+=substitute(expand("%:p:8"), "/", "\\", "g")<CR>
else
    nmap ,cs :let @+=expand("%")<CR>
    nmap ,cl :let @+=expand("%:p")<CR>
endif

" Spell check
set spell spelllang=en_us

" Auto-compile and run
autocmd filetype python nnoremap <F5> :w <bar> exec '!python '.shellescape('%')<CR>
autocmd filetype c nnoremap <F5> :w <bar> exec '!gcc '.shellescape('%').' -o '.shellescape('%:r').' -g && ./'.shellescape('%:r')<CR>
autocmd filetype cpp nnoremap <F5> :w <bar> exec '!g++ '.shellescape('%').' -o '.shellescape('%:r').' -g -std=c++11 && ./'.shellescape('%:r')<CR>
autocmd filetype c nnoremap <F6> :w <bar> exec '!gcc '.shellescape('%').' -o '.shellescape('%:r').' -g -pthread && ./'.shellescape('%:r')<CR>
autocmd filetype cpp nnoremap <F6> :w <bar> exec '!g++ '.shellescape('%').' -o '.shellescape('%:r').' -g -std=c++11 -pthread && ./'.shellescape('%:r')<CR>

" Tabs
" tabfind: look in the directory containing the current file (.), then the current directory (empty text between two commas), then each directory under the current directory ('**').
set path=.,,**
