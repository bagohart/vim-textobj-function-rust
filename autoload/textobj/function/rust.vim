" todo: this could be 'improved' so that always the next function is selected,
" if it is between two functions. but not sure if this is desired anyway.
" alternatively, the selection could fail if it is not within or on a function definition.
" or the closer function could be selected.
function! textobj#function#rust#select(object_type)
    echom "rust select CALLED!"
    if a:object_type == "a"
        return s:select_a()
    else
        return s:select_i()
    end
endfunction

function! s:select_i()
    " assume that we are in a function or on the line that contains the 'fn'
    normal! $
    redraw
    let match = search('\v<fn>', 'cbeW')
    if 0 == match
        return 0
    endif
    execute 'normal! /\V{' . "\<CR>"
    let open_br = getpos('.')
    normal! %
    let closing_br = getpos('.')
    call setpos('.', open_br)
    normal! j0
    let start_pos = getpos('.')
    call setpos('.', closing_br)
    normal! k0
    let end_pos = getpos('.')
    if 0 <= end_pos[1] - start_pos[1]  " is there some code?
        return ['V', start_pos, end_pos]
    else
        return 0
    endif
endfunction

function! s:select_a()
    " assume that we are in a function or on the line that contains the 'fn'
    normal! $
    let match = search('\v<fn>', 'beWc')
    if 0 == match
        return 0
    endif
    let fn_pos = getpos('.')

    execute 'normal! /\V{' . "\<CR>"
    let open_br = getpos('.')
    normal! %
    let closing_br = getpos('.')
    call setpos('.', fn_pos)
    normal! ^
    let start_pos = getpos('.')
    call setpos('.', closing_br)
    normal! $
    let end_pos = getpos('.')
    return ['V', start_pos, end_pos]
endfunction
