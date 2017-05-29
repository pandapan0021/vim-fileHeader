"
" default.vim
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
" global style
let g:fileHeader#theme#default#author_prefix = "@author: "
let g:fileHeader#theme#default#email_prefix = "@email: "
let g:fileHeader#theme#default#copyright_prefix = "@copyright: (c) "
let g:fileHeader#theme#default#license_prefix = "@license: "

" c style comment
let g:fileHeader#theme#default#c_sep = '='
let g:fileHeader#theme#default#c_sepWidth = 79
let g:fileHeader#theme#default#c_top_sep = '*'
let g:fileHeader#theme#default#c_bottle_sep = '*'
let g:fileHeader#theme#default#c_prefix = ' *'

" py style comment
let g:fileHeader#theme#default#py_sep = '-'
let g:fileHeader#theme#default#py_sepWidth = 79
let g:fileHeader#theme#default#py_top_sep = ''
let g:fileHeader#theme#default#py_bottle_sep = ''
let g:fileHeader#theme#default#py_prefix = '   '

" lisp style comment
let g:fileHeader#theme#default#lisp_sep = '-'
let g:fileHeader#theme#default#lisp_sepWidth = 79
let g:fileHeader#theme#default#lisp_top_sep = ''
let g:fileHeader#theme#default#lisp_bottle_sep = ''
let g:fileHeader#theme#default#lisp_prefix = '" '

" sh style comment
let g:fileHeader#theme#default#sh_sep = '-'
let g:fileHeader#theme#default#sh_sepWidth = 79
let g:fileHeader#theme#default#sh_top_sep = '~'
let g:fileHeader#theme#default#sh_bottle_sep = '~'
let g:fileHeader#theme#default#sh_prefix = '# '
