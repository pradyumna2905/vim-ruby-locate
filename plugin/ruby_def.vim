function! SearchAllOccurrences()
  let searchTerm = expand("<cword>")
  cexpr system('ag -w ' . shellescape(searchTerm))
endfunction

function! SearchForCallSitesCursor()
  let searchTerm = expand("<cword>")
  call SearchForCallSites(searchTerm)
endfunction

function! SearchForRubyMethodDeclarationCursor()
  let searchTerm = expand("<cword>")
  call SearchForDeclaration(searchTerm)
endfunction

function! SearchForRubyClassCursor()
  let searchTerm = expand("<cword>")
  call SearchForRubyClass(searchTerm)
endfunction

" Search for call sites for term (excluding its definition) and
" load into the quickfix list.
function! SearchForCallSites(term)
  cexpr system('ag -w ' . shellescape(a:term) . '\| grep -v def')
endfunction

function! SearchForDeclaration(term)
  let definition = 'def ' . a:term
  let class_definition = 'def self.' . a:term
  let scope_declaration = 'scope :' . a:term
  let search = definition . '|' . class_definition . '|' . scope_declaration
  cexpr system('ag -w ' . shellescape(search))
endfunction

function! SearchForRubyClass(term)
  let class = 'class ' . a:term
  let module = 'module ' . a:term
  let search = class . '|' . module
  cexpr system('ag -w ' . shellescape(search))
endfunction
