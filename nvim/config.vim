function! ClipboardYank()
    call system('pbcopy',@@) 
endfunction

function! ClipboardPaste()
  let @@=system('pbpaste')
endfunction

inoremap <silent> <c-l> <Right>
inoremap <silent><expr><Tab> pumvisible() ? "\<C-N>" : "\<Tab>"
inoremap <silent><expr><S-Tab> pumvisible() ? "\<C-P>" : "\<S-Tab>"

nnoremap S :%s//g<Left><Left>
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
noremap Y y$

"copy/pase
vnoremap <silent> y y:call ClipboardYank()<cr>
vnoremap <silent> d d:call ClipboardYank()<cr>
" nnoremap <silent> p :call ClipboardPaste()<cr>p

" Goto previous/next diagnostic warning/error
" nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
" nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

"multiple cursors cursor{{
" highlight multiple_cursors_cursor term=reverse cterm=reverse gui=reverse
" highlight link multiple_cursors_visual Visual
"}}


"rust {{
let g:rustfmt_autosave = 1
"}}

"vista {{
function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_sidebar_width = 40
let g:vista_fzf_preview = ['right:50%']
let g:vista_default_executive = 'ctags'
set statusline+=%{NearestMethodOrFunction()}
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
nnoremap <silent><leader>v :Vista!!<CR>
"}}


" onedark vim{{
let bufferline = get(g:, 'bufferline', {})
let bufferline.animation = v:true
let bufferline.icon_separator_active = ''
let bufferline.icon_separator_inactive = ''
let bufferline.icon_close_tab = ''
let bufferline.icon_close_tab_modified = '●'
"}}

" setup for python
let g:python_host_prog = '/opt/homebrew/bin/python3'
let g:python3_host_prog = '/opt/homebrew/bin/python3'

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" setup for lens.vim
let g:lens#disabled_filetypes = ['nerdtree', 'fzf', 'defx', 'neo-tree']
let g:lens#animate = 0
let g:floaterm_keymap_toggle = "<C-\\"

autocmd BufWritePre *.rs lua vim.lsp.buf.format(nil, 200)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)



