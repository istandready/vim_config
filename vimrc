set nocompatible                " be iMproved
filetype off                    " required!
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()
" let Vundle manage Vundle
" Bundle 'gmarik/vundle'
" "my Bundle here:
" "
" " original repos on github
Bundle 'ctrlpvim/ctrlp.vim'
Bundle 'tacahiroy/ctrlp-funky'
Bundle 'vim-airline/vim-airline'
Bundle 'vim-airline/vim-airline-themes'
Bundle 'scrooloose/nerdcommenter'
Bundle 'vim-scripts/cscope.vim'
Bundle 'Valloric/YouCompleteMe'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdtree'
Bundle 'majutsushi/tagbar'
Bundle 'easymotion/vim-easymotion'
Bundle 'tomasr/molokai'
"Bundle 'vim-scripts/visualMarks.vim'
Bundle 'octol/vim-cpp-enhanced-highlight'
Bundle 'klen/python-mode'
Bundle 'nvie/vim-flake8'
Bundle 'tpope/vim-fugitive'
Bundle 'Mark--Karkat'
Bundle 'a.vim'
Bundle 'rking/ag.vim'
call vundle#end()
filetype plugin indent on
filetype on

map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
syntax on
set autoindent  
set noautochdir
set smartindent
set cindent
set tabstop=4  
set expandtab 
set shiftwidth=4  
set cscopequickfix=s-,c-,d-,i-,t-,e-
set csto=0
set cst
"cs add ./cscope.out
set ignorecase
set ruler
set hlsearch
set nu
set autoread
set showmatch
" Enable folding
set foldmethod=indent
set foldlevel=99
set cursorline
set fenc=utf-8
set nowrap    "设置不折行"
set fileformat=unix    "设置以unix的格式保存文件"

let mapleader = ","

    " ctrlp {
        if isdirectory(expand("~/.vim/bundle/ctrlp.vim/"))
            let g:ctrlp_by_filename = 1
            let g:ctrlp_map = '<c-p>'
            let g:ctrlp_cmd = 'CtrlP'
            let g:ctrlp_working_path_mode = 'w'
            nnoremap <silent> <D-t> :CtrlP<CR>
            nnoremap <silent> <D-r> :CtrlPMRU<CR>
            let g:ctrlp_custom_ignore = {
                \ 'dir':  '\.git$\|\.hg$\|\.svn$',
                \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }

            if executable('ag')
                let s:ctrlp_fallback = 'ag %s --nocolor -l -g '
            elseif executable('ack-grep')
                let s:ctrlp_fallback = 'ack-grep %s --nocolor -f'
            elseif executable('ack') 
                let s:ctrlp_fallback = 'ack %s --nocolor -f'
           " On Windows use "dir" as fallback command.
           "elseif WINDOWS()
           "    let s:ctrlp_fallback = 'dir %s /-n /b /s /a-d'
            else
                let s:ctrlp_fallback = 'find %s -type f -name'
            endif
            if exists("g:ctrlp_user_command")
                unlet g:ctrlp_user_command
            endif
            let g:ctrlp_user_command = {
                \ 'types': {
                    \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
                    \ 2: ['.hg', 'hg --cwd %s locate -I .'],
                \ },
                \ 'fallback': s:ctrlp_fallback
            \ }

            let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:20,results:100'
			let g:ctrlp_regexp = 1
			let g:ctrlp_clear_cache_on_exit = 0

            if isdirectory(expand("~/.vim/bundle/ctrlp-funky/"))
                " CtrlP extensions
                let g:ctrlp_extensions = ['funky']
                let g:ctrlp_funky_syntax_highlight = 1
                "funky
                nnoremap <Leader>fu :CtrlPFunky<Cr>
            endif
        endif
    "}
	
    " syntastic {
        if isdirectory(expand("~/.vim/bundle/syntastic/"))
            set statusline+=%#warningmsg#
            set statusline+=%{SyntasticStatuslineFlag()}
            set statusline+=%*
	
            let g:syntastic_always_populate_loc_list = 1
            let g:syntastic_auto_loc_list = 1
            let g:syntastic_check_on_open = 1
            let g:syntastic_check_on_wq = 0
			let g:syntastic_enable_signs = 1
			let g:syntastic_cpp_checkers = ['gcc']
			let g:syntastic_auto_jump = 1
			let g:syntastic_enable_balloons = 1
			let g:syntastic_cpp_compiler = 'g++'
			let g:syntastic_cpp_compiler_options = '-std=c++11'
			let g:syntastic_cpp_check_header = 1
			let g:syntastic_cpp_auto_refresh_includes = 1
		endif
    "}

    " NerdTree {
        if isdirectory(expand("~/.vim/bundle/nerdtree"))
            map <C-e> <plug>NERDTreeTabsToggle<CR>
            map <leader>e :NERDTreeFind<CR>
            nmap <leader>nt :NERDTreeFind<CR>

            let NERDTreeShowBookmarks=1
            let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
            let NERDTreeChDirMode=0
            let NERDTreeQuitOnOpen=1
            let NERDTreeMouseMode=2
            let NERDTreeShowHidden=1
            let NERDTreeKeepTreeInNewTab=1
            let g:nerdtree_tabs_open_on_gui_startup=1
        endif
    " }

    " vim-airline {
        if isdirectory(expand("~/.vim/bundle/vim-airline/"))
            " Set configuration options for the statusline plugin vim-airline.
            " Use the powerline theme and optionally enable powerline symbols.
            " To use the symbols , , , , , , and .in the statusline
            " segments add the following to your .vimrc.before.local file:
            let g:airline_powerline_fonts=1
	    	let g:airline#extensions#tabline#enabled = 1
	    	" tabline中当前buffer两端的分隔字符
	        let g:airline#extensions#tabline#left_sep = ' '
	    	" tabline中未激活buffer两端的分隔字符
	    	let g:airline#extensions#tabline#left_alt_sep = '|'
	    	" tabline中buffer显示编号
	    	let g:airline#extensions#tabline#buffer_nr_show = 1
	    	" 映射切换buffer的键位
	    	"nnoremap <leader>[ :bp<CR>
	    	"nnoremap <leader>] :bn<CR>
	    	" 映射<leader>num到num buffer
	    	map <leader>1 :b 1<CR>
	    	map <leader>2 :b 2<CR>
	    	map <leader>3 :b 3<CR>
	    	map <leader>4 :b 4<CR>
	    	map <leader>5 :b 5<CR>
	    	map <leader>6 :b 6<CR>
	    	map <leader>7 :b 7<CR>
	    	map <leader>8 :b 8<CR>
	    	map <leader>9 :b 9<CR>
	    endif
        " If the previous symbols do not render for you then install a
        " powerline enabled font.

        " See `:echo g:airline_theme_map` for some more choices
        " Default in terminal vim is 'dark'
        if isdirectory(expand("~/.vim/bundle/vim-airline-themes/"))
            if !exists('g:airline_theme')
                let g:airline_theme = 'badwolf'
            endif
            if !exists('g:airline_powerline_fonts')
                " Use the default set of separators with a few customizations
                let g:airline_left_sep='›'  " Slightly fancier than '>'
                let g:airline_right_sep='‹' " Slightly fancier than '<'
            endif
        endif
    " }

    " TagBar {
        if isdirectory(expand("~/.vim/bundle/tagbar/"))
            nnoremap <silent> <leader>tt :TagbarToggle<CR>
        endif
    "}
	"
    "cscope   {
        if isdirectory(expand("~/.vim/bundle/cscope.vim"))
            nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
            nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
            nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
            nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
            nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
            nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
            nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
            nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
            nmap <S-n> :cnext<CR>
            nmap <S-m> :cprev<CR>
            "nmap <C-t> :colder<CR>:cc<CR>
        endif
    "}
	"Molokai {
        if isdirectory(expand("~/.vim/bundle/molokai"))
	        colorscheme  molokai  
	        set t_Co=256
	        set background=dark
		endif
	"}

    "EasyMotion {
        if isdirectory(expand("~/.vim/bundle/vim-easymotion"))
            nmap fs <Plug>(easymotion-s)
        endif
    "}

    "Ag.vim {
        if isdirectory(expand("~/.vim/bundle/ag.vim"))
            nmap <Leader>a :Ag <C-R>=expand("<cword>")<CR><CR>
        endif
    "}
	
