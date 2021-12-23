function s:defx_toggle_zoom() abort "{{{
    let b:DefxOldWindowSize = get(b:, 'DefxOldWindowSize', winwidth('%'))
    let size = b:DefxOldWindowSize
    if exists("b:DefxZoomed") && b:DefxZoomed
        exec "silent vertical resize ". size
        let b:DefxZoomed = 0
    else
        exec "vertical resize ". get(g:, 'DefxWinSizeMax', '')
        let b:DefxZoomed = 1
    endif
endfunction "}}}

function s:defx_toggle_tree() abort
  if defx#is_directory()
    return defx#do_action('open_or_close_tree')
  endif
  return defx#do_action('multi',['drop'])
endfunction

function! s:setup_defx() abort
  silent! call defx#custom#option('_', {
      \ 'winwidth': 35,
      \ 'split': 'vertical',
      \ 'direction': 'topleft',
      \ 'show_ignored_files': 0,
      \ 'buffer_name': 'defxplorer',
      \ 'toggle': 1,
      \ 'columns': 'git:indent:icon:space:icons:space:filename',
      \ 'resume': 1,
      \ 'floating_preview': 1,
      \ })
 silent! call defx#custom#column('icon', {
      \ 'directory_icon': '▸',
      \ 'opened_icon': '▾',
      \ })

 silent! call defx#custom#column('indent', {
      \ 'indent': '  ',
      \ })

 silent! call defx#custom#column('space', {
      \ 'indent': ' ',
      \ })

 silent! call defx#custom#column('filename', {
      \ 'max_width': 60,
      \ 'min_width': 35,
      \ })
 silent! call defx#custom#column('git', 'indicators', {
      \ 'Modified'  : '✹',
      \ 'Staged'    : '✚',
      \ 'Untracked' : '✭',
      \ 'Renamed'   : '➜',
      \ 'Unmerged'  : '═',
      \ 'Ignored'   : '☒',
      \ 'Deleted'   : '✖',
      \ 'Unknown'   : '?',
      \ })


  silent! call s:defx_open({ 'dir': expand('<afile>') })
endfunction

function s:get_project_root() abort
  let l:git_root = ''
  let l:path = expand('%:p:h')
  let l:cmd = systemlist('cd '.l:path.' && git rev-parse --show-toplevel')
  if !v:shell_error && !empty(l:cmd)
    let l:git_root = fnamemodify(l:cmd[0], ':p:h')
  endif

  if !empty(l:git_root)
    return l:git_root
  endif

  return getcwd()
endfunction

function! s:defx_open(...) abort
  let l:opts = get(a:, 1, {})
  let l:is_file = has_key(l:opts, 'dir') && !isdirectory(l:opts.dir)

  if  &filetype ==? 'defx' || l:is_file
    return
  endif

  let l:path = s:get_project_root()

  if has_key(l:opts, 'dir') && isdirectory(l:opts.dir)
    let l:path = l:opts.dir
  endif

  let l:args = '-winwidth=70 -direction=topleft -split=vertical'

  if has_key(l:opts, 'find_current_file')
    call execute(printf('Defx %s -search=%s %s', l:args, expand('%:p'), l:path))
  else
    call execute(printf('Defx -toggle %s %s', l:args, l:path))
    call execute('wincmd p')
  endif

  return execute("norm!\<C-w>=")
endfunction

function! s:defx_mappings() abort
  " Define mappings
  nnoremap <silent><buffer><expr> <CR> defx_toggle_tree()
  nnoremap <silent><buffer><expr> o <sid>defx_toggle_tree()
  nnoremap <silent><buffer><expr> O defx#do_action('open_tree_recursive')
  nnoremap <silent><buffer><expr> <2-LeftMouse> <sid>defx_toggle_tree()
  "change directory
  nnoremap <silent><buffer><expr> C defx#is_directory() ? defx#do_action('multi', ['open', 'change_vim_cwd']) : 'C'
  nnoremap <silent><buffer><expr> u defx#do_action('multi', [['cd', '..'], 'change_vim_cwd'])
  nnoremap <silent><buffer><expr> *  defx#do_action('toggle_select_all')
  nnoremap <silent><buffer><expr><nowait> <Space> defx#do_action('toggle_select') . 'j'


  "File
  nnoremap <silent><buffer><expr> .  defx#do_action('toggle_ignored_files')
  nnoremap <nowait><silent><buffer><expr> c defx#do_action('copy')
  nnoremap <nowait><silent><buffer><expr> d defx#do_action('remove')
  nnoremap <nowait><silent><buffer><expr> y defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> q defx#do_action('quit')
  nnoremap <silent><buffer><expr> m defx#do_action('move')
  nnoremap <silent><buffer><expr> p defx#do_action('paste')
  nnoremap <silent><buffer><expr> s defx#do_action('multi',[['drop','vsplit']])
  nnoremap <silent><buffer><expr> i defx#do_action('multi',[['drop','split']])
  nnoremap <silent><buffer><expr> r defx#do_action('rename')
  nnoremap <silent><buffer><expr> R defx#do_action('redraw')
  nnoremap <silent><buffer><expr> n defx#do_action('new_multiple_files')
  nnoremap <silent><buffer><expr> x defx#do_action('execute_system')

  "nnoremap <silent><buffer><expr> E defx#do_action('open', 'vsplit')
  "nnoremap <silent><buffer><expr> P defx#do_action('open', 'pedit')
  "nnoremap <silent><buffer><expr> o defx#do_action('open_or_close_tree')
  "nnoremap <silent><buffer><expr> K defx#do_action('new_directory')
  "nnoremap <silent><buffer><expr> N defx#do_action('new_file')
  "nnoremap <silent><buffer><expr> M defx#do_action('new_multiple_files')
  "nnoremap <silent><buffer><expr> C defx#do_action('toggle_columns','mark:indent:icon:filename:type:size:time')
  "nnoremap <silent><buffer><expr> S
  "\ defx#do_action('toggle_sort', 'time')
  "nnoremap <silent><buffer><expr> d
  "\ defx#do_action('remove')
  "nnoremap <silent><buffer><expr> r
  "\ defx#do_action('rename')
  "nnoremap <silent><buffer><expr> !
  "\ defx#do_action('execute_command')
  "nnoremap <silent><buffer><expr> x
  "\ defx#do_action('execute_system')
  "nnoremap <silent><buffer><expr> yy
  "\ defx#do_action('yank_path')
  "nnoremap <silent><buffer><expr> .
  "\ defx#do_action('toggle_ignored_files')
  "nnoremap <silent><buffer><expr> ;
  "\ defx#do_action('repeat')
  "nnoremap <silent><buffer><expr> h
  "\ defx#do_action('cd', ['..'])
  "nnoremap <silent><buffer><expr> ~
  "\ defx#do_action('cd')
  "nnoremap <silent><buffer><expr> q
  "\ defx#do_action('quit')
  "nnoremap <silent><buffer><expr> <Space>
  "\ defx#do_action('toggle_select') . 'j'
  "nnoremap <silent><buffer><expr> *
  "\ defx#do_action('toggle_select_all')
  "nnoremap <silent><buffer><expr> j
  "\ line('.') == line('$') ? 'gg' : 'j'
  "nnoremap <silent><buffer><expr> k
  "\ line('.') == 1 ? 'G' : 'k'
  "nnoremap <silent><buffer><expr> <C-l>
  "\ defx#do_action('redraw')
  "nnoremap <silent><buffer><expr> <C-g>
  "\ defx#do_action('print')
  "nnoremap <silent><buffer><expr> cd
  "\ defx#do_action('change_vim_cwd')
endfunction

augroup vimrc_defx
  autocmd!
  autocmd FileType defx call s:defx_mappings()                                  "Defx mappings
  autocmd VimEnter * call s:setup_defx()
augroup END

nmap <silent><C-b> :Defx<CR>
nmap <silent><C-i> :Defx `expand('%:p:h')` -search=`expand('%:p')`<CR>

"nnoremap <silent><C-b>:Defx <cr>
"nnoremap <silent><C-i>:call <sid>defx_open({'find_current_file': v:true })<CR>
