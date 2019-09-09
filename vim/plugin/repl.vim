" NOTE: this only works with ipython > 7.0 as ipython around version 6
" starts behaving weirdly when it comes to pasting in things due to
" autoindent being the default (and virtually impossible to disable from
" what I could find)
au BufEnter *.pmd,*py :let b:repllang='python'
au BufEnter *.pmd,*py :let b:replcmd='ipython --profile=vim'

au BufEnter *.hs,*.lhs :let b:repllang='haskell'
au BufEnter *.hs,*.lhs :let b:replcmd='stack ghci'

au FileType sh :let b:repllang='sh'
au FileType sh :let b:replcmd='sh'

au BufEnter * :let b:repl=0

function! SheBang()
	execute(':normal 0/#!\zs.*/<cr>"rygn')
	let b:replcmd=@r
endfunction

function! StartRepl()
	let l:cur_win = win_getid()
	if exists('b:replcmd')
		execute "vertical terminal " . b:replcmd
		call win_gotoid(l:cur_win)
		let b:repl=term_list()[0]
		call MapKeys()
	else
		echom "buffer has no defined repl"
	endif
endfunction

function! RunBlock(str)
	if b:repllang ==? 'haskell'
		return ':{'.a:str.':}'
	elseif b:repllang ==? 'python'
		return a:str.''
	elseif b:repllang ==? 'sh'
		return a:str.''
	else
		echom "buffer has no defined repl"
	endif
endfunction

function! RunFile(str)
	if b:repllang ==? 'haskell'
		return ':l ' .a:str.''
	elseif b:repllang ==? 'python'
		return '%run '.a:str.''
	elseif b:repllang ==? 'sh'
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

