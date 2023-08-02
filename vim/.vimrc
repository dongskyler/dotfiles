" . Skyler Dong (dongskyler@gmail.com) <skylerdong.com>
" Homepage: <https://github.com/dongskyler/vim>

"------------------------------------------------------------
" Basic settings

set nocompatible

filetype indent plugin on

syntax on
set nocursorline
set nocursorcolumn
syntax sync minlines=200
syntax sync maxlines=500

set encoding=utf-8 nobomb
set spelllang=en_us

" -- Temporary files --
set directory=$HOME/.vim/tmp/swap
set backup
set backupdir=$HOME/.vim/tmp/backup
set undofile
set undodir=$HOME/.vim/tmp/undo

" History and undo
set history=1000
set undolevels=1000

" Buffer
set ttyfast
set updatetime=100
set lazyredraw
set redrawtime=1000
set hidden

" Note that not everyone likes working this way (with the hidden option).
" Alternatives include using tabs or split windows instead of re-using the same
" window as mentioned above, and/or either of the following options:
" set confirm
" set autowriteall

" File handling
set autoread
set path=.,src,node_modules
set suffixesadd=.js,.jsx,.ts,.tsx

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Better command-line completion
set wildmenu

" Search and regex
" set gdefault
set magic
set hlsearch
set incsearch
set shortmess-=S

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Mouse
set mouse=a

"------------------------------------------------------------
" Mappings

let mapleader=";"
" let maplocalleader="'"

set backspace=indent,eol,start
set nostartofline

" if !has('nvim')
" set esckeys
" end

set timeout
set timeoutlen=3000
set ttimeout
set ttimeoutlen=30

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>

" Undo tree
nnoremap <leader>u :UndotreeToggle<CR>

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

"------------------------------------------------------------
" UI

if (empty($TMUX))
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif

set guicursor=a:ver20-blinkon0

if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\e[5 q\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\e[2 q\<Esc>\\"
else
  let &t_SI = "\e[5 q"
  let &t_EI = "\e[2 q"
endif

let g:gruvbox_termcolors='256'
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_contrast_light='hard'
let g:gruvbox_bold=1
let g:gruvbox_hls_cursor='orange'
let g:gruvbox_number_column='bg0'
let g:gruvbox_sign_column='bg1'
let g:gruvbox_color_column='bg2'
let g:gruvbox_invert_tabline='0'

" -- vimdiff color scheme --
if &diff
  colorscheme apprentice
else
  autocmd vimenter * colorscheme gruvbox
endif

set bg=dark

set ruler
set cursorline
" Always display the status line, even if only one window is displayed
set laststatus=2
set number
set numberwidth=4
" set relativenumber

" Show all changes
set report=0

" Show partial commands in the last line of the screen
set showcmd
set showmode
set showmatch
set title
set splitbelow
set splitright
set scrolloff=6
set sidescrolloff=6
set sidescroll=1

set visualbell
" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set t_vb=

set cmdheight=1

"------------------------------------------------------------
" Indentation options

set expandtab
set autoindent
set smartindent
set copyindent
set softtabstop=2
set tabstop=2
set shiftwidth=2
set smarttab

set wrap
set textwidth=80
" set formatoptions=qrn1
" set formatoptions-=o
set pastetoggle=<leader>p

" Modelines have historically been a source of security vulnerabilities. As
" such, it may be a good idea to disable them and use the securemodelines
" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
set nomodeline

"------------------------------------------------------------
" Plugins

" -- Vim-Plug --
" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Theme
Plug 'morhetz/gruvbox'

" Better status line
Plug 'vim-airline/vim-airline'

" File browser
" Plug 'preservim/nerdtree'

" Finder
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" Manipulate delimiters
Plug 'tpope/vim-surround'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Comment
Plug 'preservim/nerdcommenter'

" JavaScript/TypeSCript syntax
Plug 'othree/yajs.vim', { 'for': 'javascript' }
Plug 'maxmellon/vim-jsx-pretty'
Plug 'leafgarland/typescript-vim'

" Language pack
Plug 'sheerun/vim-polyglot'

" Prettier integration
Plug 'prettier/vim-prettier', {
      \ 'do': 'yarn install',
      \ 'for': ['javascript', 'typescript', 'typescriptreact', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'ghmarkdown', 'vue', 'yaml', 'html', 'mdx'] }

" Prose
Plug 'junegunn/goyo.vim'

" Tags
Plug 'ludovicchabant/vim-gutentags'

" Find and replace
Plug 'mileszs/ack.vim'
Plug 'brooth/far.vim'

" Coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Undo tree
Plug 'mbbill/undotree'

call plug#end()

" Coc extensions
" let g:coc_global_extensions = [
      " \ 'coc-css',
      " \ 'coc-eslint',
      " \ 'coc-explorer',
      " \ 'coc-highlight',
      " \ 'coc-html',
      " \ 'coc-html-css-support',
      " \ 'coc-json',
      " \ 'coc-pairs',
      " \ 'coc-prettier',
      " \ 'coc-react-refactor',
      " \ 'coc-sh',
      " \ 'coc-styled-components',
      " \ 'coc-tsserver',
      " \ ]

" -- Coc-explorer --
" noremap <space>e <Cmd>CocCommand explorer<CR>
noremap <C-n> <Cmd>CocCommand explorer<CR>

"  " Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-l> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" -- Coc --
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <leader>do <Plug>(coc-codeaction)
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
" nmap <leader>cl  <Plug>(coc-codelens-action)
nmap <leader>c  <Plug>(coc-codelens-action)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" fzf
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>g :Rg<CR>
nnoremap <silent> <leader>b :Buffers<CR>

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" -- GitGutter --
" let g:gitgutter_grep=''
set signcolumn=yes

" -- Gutentags --
let g:gutentags_add_default_project_roots = 0
let g:gutentags_project_root = ['package.json', '.git']
let g:gutentags_cache_dir = expand("$HOME/.vim/tmp/tags/")
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0

" Add autogroup for tag generation
augroup tagAug
  autocmd!
  " If we're working in a git commit (or similar), disable tag file generation
  autocmd FileType git,gitcommit,gitrebase,gitsendemail :let g:gutentags_enabled=0
augroup end

let g:gutentags_ctags_extra_args = [
      \ '--tag-relative=yes',
      \ '--fields=+ailmnS',
      \ ]
let g:gutentags_ctags_exclude = [
      \ '*.git', '*.svg', '*.hg',
      \ '*/tests/*',
      \ 'build',
      \ 'dist',
      \ '*sites/*/files/*',
      \ 'bin',
      \ 'node_modules',
      \ 'bower_components',
      \ 'cache',
      \ 'compiled',
      \ 'docs',
      \ 'example',
      \ 'bundle',
      \ 'vendor',
      \ '*.md',
      \ '*-lock.json',
      \ '*.lock',
      \ '*bundle*.js',
      \ '*build*.js',
      \ '.*rc*',
      \ '*.json',
      \ '*.min.*',
      \ '*.map',
      \ '*.bak',
      \ '*.zip',
      \ '*.pyc',
      \ '*.class',
      \ '*.sln',
      \ '*.Master',
      \ '*.csproj',
      \ '*.tmp',
      \ '*.csproj.user',
      \ '*.cache',
      \ '*.pdb',
      \ 'tags*',
      \ 'cscope.*',
      \ '*.css',
      \ '*.less',
      \ '*.scss',
      \ '*.exe', '*.dll',
      \ '*.mp3', '*.ogg', '*.flac',
      \ '*.swp', '*.swo',
      \ '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
      \ '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
      \ '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
      \ ]

" -- NERDTree --
" let NERDTreeIgnore=['.DS_Store']
" let NERDTreeShowBookmarks=0 "show bookmarks on startup
" let NERDTreeHighlightCursorline=1 "Highlight the selected entry in the tree
" let NERDTreeShowLineNumbers=0
" let NERDTreeShowHidden=1
" let NERDTreeMinimalUI=1
" noremap <C-n> :NERDTreeToggle<CR>

" -- NERDCommenter --
let NERDSpaceDelims=1 " space around delimiters
let NERDRemoveExtraSpaces=1
let g:NERDCustomDelimiters = {
      \ 'scss': { 'left': '//' }
      \ }

" -- Syntastic : Linting / Error check --
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" close/open location list (errors)
noremap <silent><leader>lc :lcl<CR>
noremap <silent><leader>lo :Errors<CR> :lw<CR>
noremap <silent><leader>ln :lnext<CR>
noremap <silent><leader>lp :lprev<CR>
" let g:syntastic_javascript_checkers = ['eslint']
" let g:syntastic_javascript_eslint_exec = 'eslintme'
" let g:syntastic_javascript_eslint_generic = 1

