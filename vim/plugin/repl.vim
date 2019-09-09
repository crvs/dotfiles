au BufEnter *.pmd,*py :let b:repl='ipython'
au BufEnter *.hs,*.lhs :let b:repl='stack ghci'

au FileType sh :let b:repl='sh'

function! SheBang()
	execute(':normal 0/#!\zs.*/<cr>"rygn')
	let b:repl=@r
endfunction

function! StartRepl()
	let l:cur_win = win_getid()
	if exists('b:repl')
		execute "vertical terminal " . b:repl
		let b:repl=term_list()[0]
		call win_gotoid(l:cur_win)
		call MapKeys()
	else
		echom "buffer has no defined repl"
	endif
endfunction

function! RunBlock(str)
	if b:repl ==? 'stack ghci'
		return ':{'.a:str.':}'
	elseif b:repl ==? 'ipython'
		return a:str.''
	elseif b:repl ==? 'sh'
		return a:str.''
	else
		echom "buffer has no defined repl"
	endif
endfunction

function! RunFile(str)
	if b:repl ==? 'stack ghci'
		return ':l ' .a:str.''
	elseif b:repl ==? 'ipython'
		return '%run '.a:str.''
	elseif b:repl ==? 'sh'
		return 'b:repl '.a:str.''
	else
		echom "buffer has no defined repl"
	endif
endfunction

function! MapKeys()
	vnoremap <buffer> <leader>r "ly:call term_sendkeys(b:repl,RunBlock(@l))<cr>

	nnoremap <buffer> <leader>rl "lyy:call term_sendkeys(b:repl,@l)<cr>
	nnoremap <buffer> <leader>rb ?^```<cr>+v/```<cr>-$"ly:call term_sendkeys(b:repl,RunBlock(@l))<cr>
	nnoremap <buffer> <leader>rf :call term_sendkeys(b:repl,RunFile(expand('%:p')))<cr>
endfunction

command! Repl :call StartRepl()<cr>

