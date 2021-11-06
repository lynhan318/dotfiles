let s:save_cpo = &cpo
set cpo&vim

if v:version < 700
  echoe "bufkill.vim requires vim version 7.00 or greater (mainly because it uses the new lists functionality)"
  finish
endif

if exists("loaded_bufkill")
  if !exists('g:Debug')
  finish
  endif " Debug
endif
let loaded_bufkill = 1

function! s:Debug(level, ...) "{{{1
  if !exists('g:Debug') || g:Debug < a:level                                       " (Debug)
    return " (Debug) "
  endif                                                                            " (Debug)
                                                                                   " (Debug)
  let s = ''                                                                       " (Debug)
  let i = 1                                                                        " (Debug)
  while i <= a:0                                                                   " (Debug)
    if exists('DebugArg')                                                          " (Debug)
      unlet DebugArg                                                               " (Debug)
    endif                                                                          " (Debug)
    exec "let DebugArg = a:" . i
    let argType = type(DebugArg)                                                   " (Debug)
    if argType == 1  " String                                                        (Debug)
      " String may be a variable name, in which case we print the name first         (Debug)
      if exists(DebugArg)                                                          " (Debug)
        " The string is indeed the name of a variable                                (Debug)
        " Get the name of the variable, then set DebugArg to the value of that variable
        let s = s . DebugArg . " = "                                               " (Debug)
        exec 'let arg2 = ' . DebugArg
        unlet DebugArg                                                             " (Debug)
        let DebugArg = arg2   " Necessary to change the type of DebugArg             (Debug)
      endif                                                                        " (Debug)
    endif                                                                          " (Debug)
    " Now print the value itself                                                     (Debug)
    let s = s . string(DebugArg)                                                   " (Debug)
    if i < a:0                                                                     " (Debug)
      let s = s . ', '                                                             " (Debug)
    endif                                                                          " (Debug)
    let i = i + 1                                                                  " (Debug)
  endwhile                                                                         " (Debug)
  autocmd! CursorHold * echom '--------- Debug ---------'
  let g:DebugEcho = 'echom'
  exec g:DebugEcho . ' s'
endfunction                                                                        " (Debug)

if !exists('g:BufKillActionWhenBufferDisplayedInAnotherWindow')
  let g:BufKillActionWhenBufferDisplayedInAnotherWindow = 'confirm'
endif
call s:Debug(2, 'g:BufKillActionWhenBufferDisplayedInAnotherWindow')

if !exists('g:BufKillFunctionSelectingValidBuffersToDisplay')
  let g:BufKillFunctionSelectingValidBuffersToDisplay = 'buflisted'
endif
call s:Debug(2, 'g:BufKillFunctionSelectingValidBuffersToDisplay')

if !exists('g:BufKillOverrideCtrlCaret')
  let g:BufKillOverrideCtrlCaret = 0
endif
call s:Debug(2, 'g:BufKillOverrideCtrlCaret')

" g:BufKillVerbose {{{2
" If set to 1, prints extra info about what's being done, why, and how to
" change it
if !exists('g:BufKillVerbose')
  let g:BufKillVerbose = 1
endif
call s:Debug(2, 'g:BufKillVerbose')

if !exists('g:BufKillCreateMappings')
  let g:BufKillCreateMappings = 1
endif
call s:Debug(2, 'g:BufKillCreateMappings')

if !exists('g:BufKillCommandPrefix')
  let g:BufKillCommandPrefix = 'B'
endif
call s:Debug(2, 'g:BufKillCommandPrefix')

" Commands {{{1
"
function! <SID>CreateUniqueCommand(lhs, rhs)
  let command = g:BufKillCommandPrefix.a:lhs
  if exists(':'.command) < 2
    exe 'command -bang '.command.' '.a:rhs
  endif
endfunction
call <SID>CreateUniqueCommand('A'   , ':call <SID>GotoBuffer(''#'',"<bang>")')
call <SID>CreateUniqueCommand('B'   , ':call <SID>GotoBuffer(''bufback'',"<bang>")')
call <SID>CreateUniqueCommand('F'   , ':call <SID>GotoBuffer(''bufforward'',"<bang>")')
call <SID>CreateUniqueCommand('D'   , ':call <SID>BufKill(''bd'',"<bang>")')
call <SID>CreateUniqueCommand('UN'  , ':call <SID>BufKill(''bun'',"<bang>")')
call <SID>CreateUniqueCommand('D'   , ':call <SID>BufKill(''bd'',"<bang>")')
call <SID>CreateUniqueCommand('W'   , ':call <SID>BufKill(''bw'',"<bang>")')
call <SID>CreateUniqueCommand('UNDO', ':call <SID>UndoKill()')

" Keyboard mappings {{{1
"

noremap <Plug>BufKillAlt         :call <SID>GotoBuffer('#', '')<CR>
noremap <Plug>BufKillBangAlt     :call <SID>GotoBuffer('#', '!')<CR>
noremap <Plug>BufKillBack        :call <SID>GotoBuffer('bufback', '')<CR>
noremap <Plug>BufKillBangBack    :call <SID>GotoBuffer('bufback', '!')<CR>
noremap <Plug>BufKillForward     :call <SID>GotoBuffer('bufforward', '')<CR>
noremap <Plug>BufKillBangForward :call <SID>GotoBuffer('bufforward', '!')<CR>
noremap <Plug>BufKillBun         :call <SID>BufKill('bun', '')<CR>
noremap <Plug>BufKillBangBun     :call <SID>BufKill('bun', '!')<CR>
noremap <Plug>BufKillBd          :call <SID>BufKill('bd', '')<CR>
noremap <Plug>BufKillBangBd      :call <SID>BufKill('bd', '!')<CR>
noremap <Plug>BufKillBw          :call <SID>BufKill('bw', '')<CR>
noremap <Plug>BufKillBangBw      :call <SID>BufKill('bw', '!')<CR>
noremap <Plug>BufKillUndo        :call <SID>UndoKill()<CR>
  
if g:BufKillCreateMappings == 1

  function! <SID>CreateUniqueMapping(lhs, rhs, ...)
    if hasmapto(a:rhs) && !(a:0 == 1 && a:1 == 'AllowDuplicate')
      " The user appears to have defined an alternate mapping for this command
      return
    elseif maparg(a:lhs, 'n') != ""
      " The user appears to have defined a mapping for a:lhs already
      return
    endif
    exec 'nmap <silent> <unique> '.a:lhs.' '.a:rhs
  endfunction

  " call <SID>CreateUniqueMapping('<Leader>bb',   '<Plug>BufKillBack')
  " call <SID>CreateUniqueMapping('<Leader>bf',   '<Plug>BufKillForward')
  " call <SID>CreateUniqueMapping('<Leader>bun',  '<Plug>BufKillBun')
  " call <SID>CreateUniqueMapping('<Leader>!bun', '<Plug>BufKillBangBun')
  " call <SID>CreateUniqueMapping('<Leader>bd',   '<Plug>BufKillBd')
  " call <SID>CreateUniqueMapping('<Leader>!bd',  '<Plug>BufKillBangBd')
  call <SID>CreateUniqueMapping('<Leader>bw',   '<Plug>BufKillBw')
  " call <SID>CreateUniqueMapping('<Leader>!bw',  '<Plug>BufKillBangBw')
  " call <SID>CreateUniqueMapping('<Leader>bundo','<Plug>BufKillUndo')
  " call <SID>CreateUniqueMapping('<Leader>ba',   '<Plug>BufKillAlt')
  if g:BufKillOverrideCtrlCaret == 1
    call <SID>CreateUniqueMapping('<C-^>', '<Plug>BufKillAlt', 'AllowDuplicate')
  endif
endif

function! <SID>BufKill(cmd, bang) "{{{1
" The main function that sparks the buffer change/removal
  let DebugF = 'BufKill'
  call s:Debug(1, DebugF, a:cmd, a:bang)
  if !exists('w:BufKillList')
    echoe "BufKill Error: array w:BufKillList does not exist!"
    echoe "Restart vim and retry, and if problems persist, notify the author!"
    return
  endif
  call s:Debug(2, DebugF, 'w:BufKillList')

  call <SID>SaveWindowPos()

  " Get the buffer to delete - the current one obviously
  let s:BufKillBufferToKill = bufnr('%')
  let s:BufKillBufferToKillPath = expand('%:p')
  call s:Debug(2, DebugF, 's:BufKillBufferToKill')

  " Just to make sure, check that this matches the buffer currently pointer to
  " by w:BufKillIndex - else I've stuffed up
  if s:BufKillBufferToKill != w:BufKillList[w:BufKillIndex]
    echom "BufKill Warning: bufferToKill = ".s:BufKillBufferToKill." != element ".w:BufKillIndex." in the list: (".string(w:BufKillList).")"
    echom "Please notify the author of the circumstances of this message!"
  endif

  " If the buffer is modified, and a:bang is not set, give the same kind of
  " error (or confirmation) as normal bun/bw/bd
  if &modified && strlen(a:bang) == 0
    if exists('g:BufKillActionWhenModifiedFileToBeKilled')
      let s:BufKillActionWhenModifiedFileToBeKilled = g:BufKillActionWhenModifiedFileToBeKilled
    else
      if &confirm
        let s:BufKillActionWhenModifiedFileToBeKilled = 'confirm'
      else
        let s:BufKillActionWhenModifiedFileToBeKilled = 'fail'
      endif
    endif
    if s:BufKillActionWhenModifiedFileToBeKilled =~ '[Ff][Aa][Ii][Ll]'
      echohl ErrorMsg
      echo "No write since last change for buffer '" . bufname(s:BufKillBufferToKill) . "' (add ! to override)"
      echohl None
      return
    elseif s:BufKillActionWhenModifiedFileToBeKilled =~ '[Cc][Oo][Nn][Ff][Ii][Rr][Mm]'
      let options = "&Yes\n&No\n&Cancel"
      let actionAdjustment = 0
      let bufname = bufname(winbufnr(winnr()))
      if bufname == ''
        let bufname = '[No File]'
        let options = "&No\n&Cancel"
        let actionAdjustment = 1
      endif
      let action=confirm("Save Changes in " . bufname . " before removing it?", options)
      if action + actionAdjustment == 1
        " Yes - try to save - if there is an error, cancel
        let v:errmsg = ""
        silent w
        if v:errmsg != ""
          echoerr "Unable to write buffer!"
          return
        endif
      elseif action + actionAdjustment == 2
        " No, abandon changes
        set nomodified
      else
        " Cancel (or any other result), don't do the open
        return
      endif
    else
      echoe "Illegal value (' . s:BufKillActionWhenModifiedFileToBeKilled . ') stored in variable s:BufKillActionWhenModifiedFileToBeKilled, please notify the author"
    endif
  endif

  " Get a list of all windows which have this buffer loaded
  let s:BufKillWindowListWithBufferLoaded = []
  let i = 1
  let buf = winbufnr(i)
  while buf != -1
    if buf == s:BufKillBufferToKill
      let s:BufKillWindowListWithBufferLoaded += [i]
      call s:Debug(2, DebugF, 'Added window ' . i . ' to', 's:BufKillWindowListWithBufferLoaded')
    endif
    let i = i + 1
    let buf = winbufnr(i)
  endwhile
  call s:Debug(2, DebugF, 's:BufKillWindowListWithBufferLoaded')

  " Handle the case where the buffer is displayed in multiple windows
  if len(s:BufKillWindowListWithBufferLoaded) > 1 && strlen(a:bang) == 0
    if g:BufKillActionWhenBufferDisplayedInAnotherWindow =~ '[Cc][Aa][Nn][Cc][Ee][Ll]'
      if g:BufKillVerbose
        echom "Buffer '" . bufname(s:BufKillBufferToKill) . "' displayed in multiple windows - " . a:cmd . " cancelled (add ! to kill anywawy, or set g:BufKillActionWhenBufferDisplayedInAnotherWindow to 'confirm' or 'kill')"
      endif
      return
    elseif g:BufKillActionWhenBufferDisplayedInAnotherWindow =~ '[Cc][Oo][Nn][Ff][Ii][Rr][Mm]'
      let choice = confirm("Buffer '" . bufname(s:BufKillBufferToKill) . "' displayed in multiple windows - " . a:cmd . " it anyway?", "&Yes\n&No", 1)
      if choice != 1
        return
      endif
    elseif g:BufKillActionWhenBufferDisplayedInAnotherWindow =~ '[Rr][Ee][Mm][Oo][Vv][Ee]'
      if g:BufKillVerbose
        echom "Buffer '" . bufname(s:BufKillBufferToKill) . "' displayed in multiple windows - executing " . a:cmd . " anyway."
      endif
      " Fall through and continue
    endif
  endif

  " For each window that the file is loaded in, go to the previous buffer from its list
  let i = 0
  while i < len(s:BufKillWindowListWithBufferLoaded)
    let win = s:BufKillWindowListWithBufferLoaded[i]
    call s:Debug(2, DebugF, 'Got window ' . win . ' from', 's:BufKillWindowListWithBufferLoaded', 'position ' . i)

    " Go to the right window in which to perform the action
    if win > 0
      call s:Debug(2, DebugF, 'Goto window ' . win)
      exec 'normal! ' . win . 'w'
      call s:Debug(2, DebugF, 'Current window ' . winnr())
    endif

    " Go to the previous buffer for this window
    call <SID>GotoBuffer(a:cmd, a:bang)

    let i = i + 1
  endwhile

  call <SID>RestoreWindowPos()

  " Kill the old buffer, but save info about it for undo purposes
  let s:BufKillLastWindowListWithBufferLoaded = s:BufKillWindowListWithBufferLoaded
  let s:BufKillLastBufferKilledPath = s:BufKillBufferToKillPath
  let s:BufKillLastBufferKilledNum = s:BufKillBufferToKill
  if bufexists(s:BufKillBufferToKill)
    let killCmd = a:cmd . a:bang . s:BufKillBufferToKill
    call s:Debug(2, DebugF, 'killCmd = ' . killCmd)
    exec killCmd
  else " Debug
    call s:Debug(2, DebugF, 'buffer #'.s:BufKillBufferToKill.' removed during GotoBuffer step')
  endif

  " Restore position if saved.  Needed on console vim, at least, to restore correct column
  call <SID>RestoreView()

  call s:Debug(2, DebugF, 'Exiting')
endfunction

function! <SID>IsBufferNew(buf) "{{{1
  return (bufname(a:buf) == '') && !getbufvar(a:buf, '&modified')
endfunction

function! <SID>SwitchToNewBuffer(bang) "{{1
  let old_bufnum = bufnr('%')

  " if we already have a "new" buffer, switch to it
  for bufnum in range(1, bufnr('$'))
    if bufexists(bufnum) && <SID>IsBufferNew(bufnum) && (bufnum != old_bufnum)
      exec 'b' . a:bang . bufnum
      return
    endif
  endfor

  " try to create a new buffer
  exec 'enew' . a:bang
  if bufnr('%') != old_bufnum
    return
  endif

  let &modifiable = 1
  normal! iforce enew to create a new buffer
  enew!
  let new_bufnum = bufnr('%')
  exec 'b' . old_bufnum
  silent normal! u
  exec 'b' . new_bufnum
endfunction

function! <SID>GotoBuffer(cmd, bang) "{{{1
  let DebugF = 'GotoBuffer'
  call s:Debug(1, DebugF, a:cmd)
  call s:Debug(2, DebugF, 'w:BufKillList')
  call s:Debug(2, DebugF, 'w:BufKillColumnList')
  call s:Debug(2, DebugF, 'w:BufKillIndex')

  if (a:cmd=='bun' || a:cmd=='bd' || a:cmd=='bw')
    let killing = 1
  else
    let killing = 0
  endif

  if killing
    " Handle the 'auto' setting for
    " g:BufKillFunctionSelectingValidBuffersToDisplay
    let validityFunction = g:BufKillFunctionSelectingValidBuffersToDisplay
    if validityFunction == 'auto'
      if a:cmd == 'bw'
        let validityFunction = 'bufexists'
      else
        let validityFunction = 'buflisted'
      endif
    endif
    let w:BufKillIndex -= 1
  else
    " Should only be used with undeleted (and unwiped) buffers
    let validityFunction = 'buflisted'

    if a:cmd == 'bufforward'
      let w:BufKillIndex += 1
    elseif a:cmd == 'bufback'
      let w:BufKillIndex -= 1
    elseif a:cmd == '#'
      let bufnum = bufnr('#')
      if bufnum == -1
        echom "E23: No alternate file (error simulated by bufkill.vim)"
        return
      endif
      if bufnum == bufnr('%')
        " If the alternate buffer is also the current buffer, do nothing
        return
      elseif !buflisted(bufnum)
        echom "bufkill: Alternate buffer is unlisted buffer ".bufnum." ("
          \ .bufname(bufnum).") - ignoring request"
        return
      endif
      " Find this buffer number in the w:BufKillList
      let w:BufKillIndex = index(w:BufKillList, bufnum)
    endif
  endif

  while 1
    if w:BufKillIndex < 0
      let w:BufKillIndex = 0
    elseif w:BufKillIndex > (len(w:BufKillList) - 1)
      let w:BufKillIndex = len(w:BufKillList) - 1
    endif

    if w:BufKillList[w:BufKillIndex] == bufnr('%')
      if !killing
        echom 'BufKill: already at the limit of the BufKill list'
        return
      endif

      " we're going to kill the current buffer -- we want to switch to a
      " different one...
      if w:BufKillIndex == 0
        if len(w:BufKillList) == 1
          " there are no other buffers in our list. switch to a "new" one
          call <SID>SwitchToNewBuffer(a:bang)
          call <SID>SaveView()
          return
        endif
        let w:BufKillIndex += 1
      else
        let w:BufKillIndex -= 1
      endif
    endif

    let newBuffer = w:BufKillList[w:BufKillIndex]
    let newColumn = w:BufKillColumnList[w:BufKillIndex]

    call s:Debug(2, DebugF, 'newBuffer = ' . newBuffer . ', newColumn = ' . newColumn)
    exec 'let validityResult = '.validityFunction.'(newBuffer)'
    if validityResult
      " buffer is valid: switch to it...
      exec 'b' . a:bang . newBuffer . "|call cursor(line('.')," . newColumn . ')'
      call <SID>SaveView()
      return
    endif

    " buffer isn't valid: remove it from the list
    call remove(w:BufKillList, w:BufKillIndex)
    call remove(w:BufKillColumnList, w:BufKillIndex)
    if a:cmd != 'bufforward'
      let w:BufKillIndex -= 1
    endif
  endwhile

  call s:Debug(2, DebugF, 'w:BufKillList')
  call s:Debug(2, DebugF, 'w:BufKillColumnList')
  call s:Debug(2, DebugF, 'w:BufKillIndex')
  call s:Debug(2, DebugF, 'Exiting')
  " redraw  " To hide call Debug messages for now!
endfunction   " GotoBuffer

function! <SID>UpdateList(event) "{{{1
  " Function to update the window list with info about the current buffer
  let DebugF = 'UpdateList'
  call s:Debug(1, DebugF, 'Entering(' . a:event . '): win = ' . winnr() . ', buf = ' . bufnr('%') . ' (' . bufname('%') . ')')
  if !exists('w:BufKillList')
    let w:BufKillList = []
  endif
  if !exists('w:BufKillColumnList')
    let w:BufKillColumnList = []
  endif
  if !exists('w:BufKillIndex')
    let w:BufKillIndex = -1
  endif
  call s:Debug(2, DebugF, 'w:BufKillList')
  call s:Debug(2, DebugF, 'w:BufKillColumnList')
  call s:Debug(2, DebugF, 'w:BufKillIndex')
  let bufferNum = bufnr('%')

  if (w:BufKillIndex == -1) || (w:BufKillList[w:BufKillIndex] != bufferNum)
    " Increment index
    let w:BufKillIndex += 1
    if w:BufKillIndex < len(w:BufKillList)
      " The branch is diverging, remove the end of the list
      call remove(w:BufKillList, w:BufKillIndex, -1)
      " Same for column list
      if w:BufKillIndex < len(w:BufKillColumnList)
        call remove(w:BufKillColumnList, w:BufKillIndex, -1)
      endif
    endif
    " Now remove any pre-existing instances of the buffer in the list
    let existingIndex = index(w:BufKillList, bufferNum)
    if existingIndex != -1
      call remove(w:BufKillList, existingIndex)
      let w:BufKillIndex -= 1
      if existingIndex < len(w:BufKillColumnList)
        call remove(w:BufKillColumnList, existingIndex)
      endif
    endif
    " Now add the buffer to the list, at the end
    let w:BufKillList += [bufferNum]
  endif

  call s:Debug(2, DebugF, 'w:BufKillList')
  call s:Debug(2, DebugF, 'w:BufKillColumnList')
  call s:Debug(2, DebugF, 'w:BufKillIndex')
  call s:Debug(1, DebugF, 'Exiting (' . a:event . '): ', 'w:BufKillList')
  " redraw  " To hide call Debug messages for now!
endfunction   " UpdateList

function! <SID>UpdateLastColumn(event) "{{{1
  " Function to save the current column and buffer and window numbers,
  let DebugF = 'UpdateColumnList'
  call s:Debug(1, DebugF, 'Entering(' . a:event . '): win = ' . winnr() . ', buf = ' . bufnr('%') . ' (' . bufname('%') . ')')
  call s:Debug(2, DebugF, 'w:BufKillList')
  call s:Debug(2, DebugF, 'w:BufKillColumnList')
  call s:Debug(2, DebugF, 'w:BufKillIndex')
  if !exists('w:BufKillList')
    " Just give up for now.
    return
  endif
  let index = index(w:BufKillList, bufnr('%'))
  if index != -1
    " Extend list if required, then set the value
    let w:BufKillColumnList += repeat([0], index - len(w:BufKillColumnList) + 1)
    let w:BufKillColumnList[index] = col('.')
  else
    call s:Debug(2, DebugF, 'UpdateLastColumn failed to find bufnr ' . bufnr('%') . ' in w:BufKillList')
  endif
  call s:Debug(2, DebugF, 'w:BufKillList')
  call s:Debug(2, DebugF, 'w:BufKillColumnList')
  call s:Debug(2, DebugF, 'w:BufKillIndex')
  call s:Debug(1, DebugF, 'Exiting (' . a:event . ')')
  " redraw  " To hide call Debug messages for now!
endfunction

function! <SID>UndoKill() "{{{1
  let DebugF = 'UndoKill'
  call s:Debug(1, DebugF)

  if !exists('s:BufKillLastBufferKilledNum') || !exists('s:BufKillLastBufferKilledPath') || s:BufKillLastBufferKilledNum == -1 || s:BufKillLastBufferKilledPath == ''
    echoe 'BufKill: nothing to undo (only one level of undo is supported)'
  else
    if bufexists(s:BufKillLastBufferKilledNum)
      let cmd = 'b' . s:BufKillLastBufferKilledNum
    elseif filereadable(s:BufKillLastBufferKilledPath)
      let cmd = 'e ' . s:BufKillLastBufferKilledPath
    else
      unlet s:BufKillLastBufferKilledNum
      unlet s:BufKillLastBufferKilledPath
      unlet s:BufKillLastWindowListWithBufferLoaded
      echoe 'BufKill: unable to undo. Neither buffer (' . s:BufKillLastBufferKilledNum . ') nor file (' . s:BufKillLastBufferKilledPath . ') could be found.'
    endif

    " For each window the buffer was removed from, show it again
    call <SID>SaveWindowPos()
    let i = 0
    while i < len(s:BufKillLastWindowListWithBufferLoaded)
      let win = s:BufKillLastWindowListWithBufferLoaded[i]
      call s:Debug(2, DebugF, 'Got window ' . win . ' from', 's:BufKillLastWindowListWithBufferLoaded', 'position ' . i)
      call s:Debug(2, DebugF, 'Goto window ' . win)
      exec 'normal! ' . win . 'w'
      call s:Debug(2, DebugF, 'Current window ' . winnr())
      exec cmd
      let i = i + 1
    endwhile
    call <SID>RestoreWindowPos()

    unlet s:BufKillLastBufferKilledNum
    unlet s:BufKillLastBufferKilledPath
    unlet s:BufKillLastWindowListWithBufferLoaded
  endif
  call s:Debug(2, DebugF, 'Exiting')
endfunction

function! <SID>SaveWindowPos() "{{{1
  " Save the current window, to be able to come back to it after doing things
  " in other windows
  let DebugF = 'SaveWindowPos'
  let s:BufKillWindowPos = winnr()
  call s:Debug(2, DebugF, 'Saving with winnr = ', 's:BufKillWindowPos')
endfunction

function! <SID>RestoreWindowPos() "{{{1
  " Restore the window from it's saved config variable
  let DebugF = 'RestoreWindowPos'
  call s:Debug(2, DebugF, 'Restoring to = ', 's:BufKillWindowPos')
  exec 'normal! ' . s:BufKillWindowPos . 'w'
endfunction

function! <SID>SaveView() "{{{1
  let DebugF = 'SaveView'
  if exists("*winsaveview")
    let w:BufKillSavedView = winsaveview()
    call s:Debug(2, DebugF, 'SavedView = ', 'w:BufKillSavedView')
  else
    call s:Debug(1, DebugF, 'winsaveview not in this version of Vim, column not reliably saved.')
  endif
endfunction   " SaveView

function! <SID>RestoreView() "{{{1
  " Matching restore function to SaveView
  let DebugF = 'RestoreView'
  if exists("*winrestview") && exists('w:BufKillSavedView')
    call winrestview(w:BufKillSavedView)
    call s:Debug(2, DebugF, 'Restoring to = ', 'w:BufKillSavedView')
    unlet w:BufKillSavedView
  endif
endfunction   " RestoreView
augroup BufKill
autocmd!
autocmd BufKill WinEnter * call <SID>UpdateList('WinEnter')
autocmd BufKill BufEnter * call <SID>UpdateList('BufEnter')
autocmd BufKill BufAdd * call <SID>UpdateList('BufAdd')
autocmd BufKill WinLeave * call <SID>UpdateLastColumn('WinLeave')
autocmd BufKill BufLeave * call <SID>UpdateLastColumn('BufLeave')
augroup END
let &cpo = s:save_cpo

