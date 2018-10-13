" Vim syntax file
" Language: 	YANG
" Remark:		RFC 6020 http://tools.ietf.org/html/rfc6020
" Version: 		1
" Last Change:	2011 Sep 28
" Maintainer: 	Matt Parker <mparker@computer.org>
"------------------------------------------------------------------

if v:version < 600
	syntax clear
elseif exists('b:current_syntax')
	finish
endif

" yang has keywords with a '-' in them
setlocal iskeyword+=-

" keywords are case-sensitive
syntax case match

" enable block folding
syntax region yangBlock start="{" end="}" fold transparent


" built-in types (section 4.2.4)
syntax keyword yangType decimal64 int8 int16 int32 int64 uint8 uint16 uint32 uint64
syntax keyword yangType string boolean enumeration bits binary leafref identityref empty instance-identifier

syntax match yangIdentifier /\c\<\h\+[A-Za-z0-9_-]*\>/

" identifiers must not begin with 'xml'. this rule must be defined after the previous yangIdentifier to work properly.
syntax match yangBadIdentifier /\c\<xml\(\h\+[A-Za-z0-9_-]\)*\>/

" statement keywords
syntax keyword yangStatement argument augment base belongs-to
syntax keyword yangStatement config contact default description error-app-tag error-message
syntax keyword yangStatement extension deviation deviate fraction-digits
syntax keyword yangStatement include input key length
syntax keyword yangStatement list mandatory max-elements min-elements module must namespace
syntax keyword yangStatement ordered-by organization output path pattern position
syntax keyword yangStatement presence range reference refine require-instance revision
syntax keyword yangStatement revision-date status submodule type
syntax keyword yangStatement units value when yang-version yin-element
syntax keyword yangStatement anyxml bit case choice container enum feature grouping identity import nextgroup=yangIdentifier skipwhite
syntax keyword yangStatement leaf leaf-list list notification prefix rpc typedef unique uses nextgroup=yangIdentifier skipwhite

" other keywords
syntax keyword yangOther add current delete deprecated max min not-supported
syntax keyword yangOther obsolete replace system unbounded user

" boolean constants (separated from the 'other keywords' for vim syntax purpose)
syntax keyword yangBoolean true false

" if-feature (separated from 'statement keywords' for vim syntax purposes)
syntax keyword yangConditional if-feature

" comments
syntax region yangComment start="/\*" end="\*/"
syntax region yangComment start="//" end="$"

" strings
syntax region yangString start=+"+ skip=+\\"+ end=+"+
syntax region yangString start=+'+ end=+'+

" dates
syntax match yangDateArg /"\=\<\d\{4}-\d\{2}-\d\{2}\>"\=/

" length-arg TODO: this needs to also include the pipe and individual numbers (i.e. fixed length)
syntax match yangLengthArg /"\(\d\+\|min\)\s*\.\.\s*\(\d\+\|max\)"/

" numbers
syntax match yangNumber /\<[+-]\=\d\+\>/
syntax match yangNumber	"\<0x\x\+\>"


"-------------------------------------
" and now for the highlighting

" things with one-to-one mapping
highlight def link yangBadIdentifier Error
highlight def link yangIdentifier Identifier
highlight def link yangString String
highlight def link yangComment Comment
highlight def link yangNumber Number
highlight def link yangBoolean Boolean
highlight def link yangConditional Conditional
highlight def link yangType Type

" arbitrary mappings
highlight def link yangKeyword Keyword
highlight def link yangStatement Statement
highlight def link yangModule Type
highlight def link yangDateArg Special
highlight def link yangLengthArg Special

" synchronize
syntax sync match yangSync grouphere NONE '}$'

let b:current_syntax = 'yang'
