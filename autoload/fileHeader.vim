"
" fileHeader.vim
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
if (exists("g:fileHeader_loaded") || &cp)
  finish
endif
let g:fileHeader_loaded = 1

if exists("g:fileHeader_source") && g:fileHeader_source != ""
  let g:fileHeader#source_path = g:fileHeader_source
else
  let g:fileHeader#source_path = expand("<sfile>:p:h") . '\' . 'fileHeader' . '\' . 'source'
endif

let g:fileHeader#c_style_begin = "/*"
let g:fileHeader#c_style_end = "*/"
let g:fileHeader#c_end = "right"

let g:fileHeader#sh_style_begin = "#"
let g:fileHeader#sh_style_end = "#"
let g:fileHeader#sh_end = "left"

let g:fileHeader#py_style_begin = "'''"
let g:fileHeader#py_style_end = "'''"
let g:fileHeader#py_end = "right"

let g:fileHeader#lisp_style_begin = '"'
let g:fileHeader#lisp_style_end = '"'
let g:fileHeader#lisp_end = "left"


"insert file header main api
fun fileHeader#insert(filetype) abort
  let l:conf = fileHeader#helper#search_file('conf')
  if l:conf != ''
    call fileHeader#helper#read_conf(l:conf)
  endif
  let b:comment_style = fileHeader#helper#filetype_to_style(a:filetype)
  let b:start_insert_line = 0
  call fileHeader#helper#comment_insert_before(a:filetype)
  call fileHeader#helper#insert_comment_line(b:comment_style, 'top')
  call fileHeader#helper#insert_comment_body(b:comment_style)
  let backup = @z
  let @z = "\n"
  exe b:start_insert_line.'put z'
  let b:start_insert_line += 1
  call fileHeader#helper#insert_comment_line(b:comment_style, 'bottle')
"  fileHeader#comment_insert_after(b:comment_style)
  unlet b:comment_style
  unlet b:start_insert_line
endfun


let g:confable = {'AUTHOR': "g:author", 'EMAIL': 'g:email', 
      \ 'LICENSE': 'g:license', 'COPYRIGHT': 'g:fileHeader_copyright',  
      \ 'THEME': 'g:fileHeader_theme', 'SOURCE': 'g:fileHeader_source'}

