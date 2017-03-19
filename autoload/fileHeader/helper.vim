"
" helper.vim
" -----------------------------------------------------------------------------
" 
" 
" -----------------------------------------------------------------------------
" @author: 00ggo00
" @author: pandapan0021@gmail.com
" @copyright: (c) 00ggo00 reserved
" -----------------------------------------------------------------------------
" MIT License
" 
" 
" Permission is hereby granted, free of charge, to any person obtaining a copy
" of this software and associated documentation files (the "Software"), to deal
" in the Software without restriction, including without limitation the rights
" to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
" copies of the Software, and to permit persons to whom the Software is
" furnished to do so, subject to the following conditions:
" 
" The above copyright notice and this permission notice shall be included in all
" copies or substantial portions of the Software.
" 
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
" IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
" FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
" AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
" LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
" OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
" SOFTWARE.

"

" top strip: delete white lines at top of file
fun! fileHeader#helper#top_strip(filename) abort
  if !fileHeader#helper#file_ex(g:fileHeader#source_path. '/' . a:filename)
    echom a:filename . ' not exist'
    return
  endif
  silent exe "$tabedit " g:fileHeader#source_path . '/' . a:filename
  let s:max_white_lnum = fileHeader#helper#max_w_lnum()
  silent exe "1," s:max_white_lnum . "d"
  silent exe "w"
  silent exe "close!"
endfun

" find lnum where next line is not white from top
fun! fileHeader#helper#max_w_lnum() abort
  let s:max_w = 1
  let s:scan_begin = 1
  if (getline(s:scan_begin) != "")
    return s:max_w
  endif
  let s:scan_begin += 1
  while(and((getline(s:scan_begin) == ""), (s:scan_begin <= line("$"))))
    let s:max_w += 1
    let s:scan_begin += 1
  endwhile
  return s:max_w
endfun

" bottle strip: delete white lines at bottle of file
fun! fileHeader#helper#bottle_strip(filename) abort
  if !fileHeader#helper#file_ex(g:fileHeader#source_path. '/' . a:filename)
    echom a:filename . ' not exist'
    return
  endif
  silent exe "$tabedit " g:fileHeader#source_path . '/' . a:filename
  let s:little_white_lnum = fileHeader#helper#little_w_lnum()
  silent exe s:little_white_lnum ",$" . "d"
  silent exe "w"
  silent exe "close!"
endfun

" find lnum where pre line is not white from bottle
fun! fileHeader#helper#little_w_lnum() abort
  let s:little_w = line("$")
  if(getline(s:last_line) != "")
    return s:little_w
  endif
  while(and((getline(s:little_w-1) == ""), (s:little_w > 1)))
    let s:little_w -= 1
  endwhile
  return s:little_w
endfun


" strip top bottle white lines
fun! fileHeader#helper#top_bottle_strip(filename) abort
  fileHeader#helper#top_strip(a:filename)
  fileHeader#helper#bottle_strip(a:filename)
endfun

" test file exists
fun! fileHeader#helper#file_ex(full_filepath) abort
  if !empty(glob(a:full_filepath))
    return 1
  endif
  return 0
endfun

fun! fileHeader#helper#filetype_to_style(filetype) abort
  let l:type_to_style = { 'c': 'c', 'cpp' : 'c', 'js' : 'c', 'sh': 'sh', 'python': 'py', 'vim': 'lisp',
        \ 'scm': 'lisp', 'guile': 'lisp', 'lisp': 'lisp'}
  return get(l:type_to_style, a:filetype, 'lisp')
endfun

"search conf file
fun! fileHeader#helper#search_file(source)
  if a:source == 'conf'
    let name = "fileHeader.conf"
  endif
  if a:source == 'license'
    let name = "LICENSE"
  endif
  let l:p = split(getcwd(), '/')
  let l:i = len(l:p)
  while l:i > 0
    if fileHeader#helper#file_ex(join(p[:l:i], '/') . '/' . name)
      return join(p[:l:i], '/') . '/' . name
    endif
    let l:i -= 1
  endwhile
  return ''
endfun

"read conf
fun! fileHeader#helper#read_conf(file) abort
  let l:lines = readfile(a:file)
  for line in l:lines
    if line =~ '^\s*"' || len(line) == 0
      continue
    endif
    let key = split(line)[0]
    let value = join(split(line)[1:], ' ')
    if count(keys(g:confable), toupper(key)) > 0
      exe 'let '.g:confable[toupper(key)].'='.string(value)
    endif
  endfor
endfun

"insert first comment line
fun! fileHeader#helper#insert_comment_line(style, postion) abort
  let theme = get(g:, 'fileHeader_theme', 'default')
  let backup = @z
  let @z = ''
  exe 'let b:sepWidth = g:fileHeader#theme#'.theme.'#'.a:style.'_sepWidth'
  exe 'let b:c = g:fileHeader#theme#'.theme.'#'.a:style.'_top_sep'
  if a:postion == 'top'
    exe 'let b:comb = g:fileHeader#'.a:style.'_style_begin'
    let @z = b:comb.repeat(b:c, b:sepWidth-len(b:comb))
  else
    exe 'let b:comb = g:fileHeader#'.a:style.'_style_end'
    exe 'let l:k = g:fileHeader#'.a:style.'_end'
    if l:k == 'right'
      let @z = repeat(b:c, b:sepWidth-len(b:comb)).b:comb
    else
      let @z = b:comb.repeat(b:c, b:sepWidth-len(b:comb))
    endif
    unlet l:k
  endif
  exe b:start_insert_line.'put z'
  let b:start_insert_line += 1
  let @z = backup
  unlet b:comb
  unlet b:sepWidth
  unlet b:c
endfun


"insert code declare and so on
fun! fileHeader#helper#comment_insert_before(filetype) abort
  let l:ap = count(['sh', 'python', 'perl'], a:filetype)
  if !l:ap
    return
  endif
  let backup = @z
  let @z = ""
  let @z = '# -*- coding: utf-8 -*-'
  exe b:start_insert_line.'put z'
  let b:start_insert_line += 1
  let @z = '#! /usr/bin/env '. a:filetype
  exe b:start_insert_line.'put z'
  let b:start_insert_line += 1
  let @z = backup
endfun

" insert file header body
"          filename
"          (sep)
"          disc
"          (sep)
"          author
"          email
"          copyright
"          (sep)
"          lecense

fun! fileHeader#helper#insert_comment_body(style) abort 
  let theme = get(g:, 'fileHeader_theme', 'default')
  exe 'let prefix = g:fileHeader#theme#'.theme.'#'.a:style.'_prefix'
  let backup = @z
  let l:filename = expand("%:t")
  let @z = prefix.l:filename
  call fileHeader#helper#insert_one_line()
  exe 'let sep = g:fileHeader#theme#'.theme.'#'.a:style.'_sep'
  exe 'let width = g:fileHeader#theme#'.theme.'#'.a:style.'_sepWidth'
  let @z = prefix.repeat(sep, width-len(prefix))
  call fileHeader#helper#insert_one_line()

" preserve for desc
  let @z = prefix."\n"
  call fileHeader#helper#insert_one_line()
  call fileHeader#helper#insert_one_line()
  let @z = prefix.repeat(sep, width-len(prefix))
  call fileHeader#helper#insert_one_line()
  exe 'let author_prefix = g:fileHeader#theme#'.theme.'#author_prefix'
  let @z = prefix.author_prefix.get(g:, 'author', '')
  call fileHeader#helper#insert_one_line()
  exe 'let email_prefix = g:fileHeader#theme#'.theme.'#email_prefix'
  let @z = prefix.author_prefix.get(g:, 'email', '')
  call fileHeader#helper#insert_one_line()
  exe 'let copyright_prefix = g:fileHeader#theme#'.theme.'#copyright_prefix'
  let @z = prefix.copyright_prefix.get(g:, 'fileHeader_copyright', '')
  call fileHeader#helper#insert_one_line()
  let @z = prefix.repeat(sep, width-len(prefix))
  call fileHeader#helper#insert_one_line()

  call fileHeader#helper#license_insert(theme, prefix)


  let @z = backup
endfun

" insert to b:start_insert_line from z register
fun! fileHeader#helper#insert_one_line() abort
  exe b:start_insert_line.'put z'
  let b:start_insert_line+=1
endfun

fun! fileHeader#helper#license_insert(theme, prefix) abort
  let backup = @z
  let source_dir = get(g:, 'fileHeader_source', g:fileHeader#source_path)
  let license = get(g:, 'fileHeader_license', 'MIT')
  if fileHeader#helper#file_ex(source_dir.'/'.license)
    let l:filename = source_dir.'/'.license
  else
    let l:filename = ''
  endif
  let l:filename_pre = fileHeader#helper#search_file('license')
  if l:filename_pre != ''
    let l:filename = l:filename_pre
  endif
  if l:filename == ''
    exe 'let license_prefix = g:fileHeader#theme#'.a:theme.'#license_prefix'
    let @z = a:prefix.license_prefix.get(g:, 'fileHeader_license', '')
    call fileHeader#helper#insert_one_line()
    return
  endif
  let l:lines = readfile(l:filename)
  for line in l:lines
    if line =~# '^Copyright'
      continue
    endif
    let @z = a:prefix.line
    call fileHeader#helper#insert_one_line()
  endfor
  let @z = backup
endfun
