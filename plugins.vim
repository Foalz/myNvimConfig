syntax enable
set showcmd
set ruler
set cursorline
set encoding=utf-8
set showmatch
set sw=2
set clipboard+=unnamedplus
set relativenumber
set laststatus=2
set noshowmode
set nocompatible
set splitright
let file_name = expand('%:t:r')
let NERDTreeShowHidden=1
autocmd VimEnter * NERDTree 

call plug#begin('~/.config/nvim/autoload/plugged')

    "syntax
    Plug 'sheerun/vim-polyglot'

    "status bar
    Plug 'maximbaz/lightline-ale'
    Plug 'itchyny/lightline.vim'

    "typing
    Plug 'alvan/vim-closetag'
    Plug 'tpope/vim-surround'
    
    "IDE
    Plug 'easymotion/vim-easymotion'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'terryma/vim-multiple-cursors'
    Plug 'yggdroot/indentline'
    Plug 'scrooloose/nerdcommenter'
    Plug 'mhinz/vim-signify'

    "Themes 
    Plug 'morhetz/gruvbox'
    Plug 'tomasiser/vim-code-dark'
    
    " File Explorer
    Plug 'scrooloose/NERDTree'
    
    " Auto pairs for '(' '[' '{'
    Plug 'jiangmiao/auto-pairs'

    "autocomplete
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'honza/vim-snippets'

    "test
    Plug 'tyewang/vimux-jest-test'
    Plug 'janko-m/vim-test'

    "Finding words in project
    Plug 'ggreer/the_silver_searcher'    

    
call plug#end()
"set background=dark 
"let g:gruvbox_contrast_dark = 
"colorscheme gruvbox

" Activates italicized comments (make sure your terminal supports italics)
let g:codedark_italics=1
" Make the background transparent
let g:codedark_transparent=1
" If you have vim-airline, you can also enable the provided theme
let g:airline_theme = 'codedark'

colorscheme codedark

syntax on
set cursorline

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

let g:UltiSnipsEditSplit="vertical"

let mapleader=" "

"mappings

autocmd FileType python nnoremap <Leader>b :vsp <bar> :terminal python3 %<CR>
autocmd FileType python nnoremap <Leader>; $a:<Esc>
autocmd FileType javascript nnoremap <Leader>b :vsp <bar> :terminal node %<CR>
autocmd FileType javascript nnoremap <Leader>, :vsp <bar> :terminal npx nodemon %<CR>
autocmd FileType javascript nnoremap <Leader>. :vsp <bar> :terminal npm run dev<CR>
autocmd FileType javascript nnoremap <Leader>; $a;<Esc>
autocmd FileType json nnoremap <Leader>; $a,<Esc>

" Find and replace
nmap <Leader>h :%s/

"   testings
nnoremap <Leader>t :TestNearest<CR>
nnoremap <Leader>T :TestFile<CR>
nnoremap <Leader>TT :TestSuite<CR>

   "split resize
"nnoremap <Leader>. 20 <C-w>>
"nnoremap <Leader>, 20 <C-w><

"   quick semi colon 

"   quick save and quit
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>e :q!<CR>
nnoremap <Leader>ay ggVGy<CR>
nnoremap <Leader>ad ggVGd<CR>

nmap <Leader>s <Plug>(easymotion-s2)
nmap <Leader>nn :NERDTreeFind<CR>
nmap <Leader>ff :FZF<CR>
nmap <Leader>p :Ag<CR>

"   diagnostics
nnoremap <Leader>kp :let @*=expand("%")<CR>

"   faster scrolling
nnoremap <C-e> 10<C-e>
nnoremap <C-y> 10<C-y>

"   run current file
nnoremap <Leader>x :!node %<cr>

"Configurations for coc.nvim 


" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-k> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}


