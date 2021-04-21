" visincr.vim: assumes that a block of numbers selected by a ctrl-v
"              (visual block) has been selected for incrementing.
"              This function will transform that block of numbers
"              into an incrementing column starting from that topmost number
"              in the visual block.
"
"  Usage:       Use ctrl-v to visually select a column of numbers.  Then
"                   :I [#]
"                       will use the first line's number as a starting point
"                       default increment (#) is 1
"                       will justify left (pad right)
"
"                   :II [# [zfill]]
"                       will use the first line's number as a starting point
"                       default increment (#) is 1
"                       default zfill         is a blank
"                       will justify right (pad left)
"
"                                      I      II
"                                 -   +--+   +--+
"                                 8   |8 |   | 8|
"                                 8   |9 |   | 9|
"                                 8   |10|   |10|
"                                 8   |11|   |11|
"                                     +--+   +--+
"
"                   The following three commands need <calutil.vim> to do
"                   their work:
"
"                   :IYMD [#] Increment year/month/day dates (by optional # days)
"                   :IMDY [#] Increment month/day/year dates (by optional # days)
"                   :IDMY [#] Increment day/month/year dates (by optional # days)
"
"                   :ID  Increment days by name (Monday, Tuesday, etc).  If only
"                        three or fewer letters are highlighted, then only
"                        three-letter abbreviations will be used.
"
"  Fancy Stuff:
"               * If the visual block is ragged right (as can happen when "$"
"                 is used to select the right hand side), the block will have
"                 spaces appended to straighten it out
"               * If the strlen of the count exceeds the visual-block
"                 allotment of spaces, then additional spaces will be inserted
"               * Handles leading tabs by using virtual column calculations
"               *
"
"  Author:      Charles E. Campbell, Jr.  Ph.D.
"  Date:        Jun 10, 2003
"  Version:     7
"
"  History:
"    v7 : 06/09/03       : bug fix -- years now retain leading zero
"    v6 : 05/29/03       : bug fix -- pattern for IMDY IDMY IYMD didn't work
"                          with text on the sides of dates; it now does
"    v5 : II             : implements 0-filling automatically if
"                          the first number has the format  0000...0#
"         IYMD IMDY IDMY : date incrementing, uses <calutil.vim>
"         ID             : day-of-week incrementing
"    v4 : gdefault option bypassed (saved/set nogd/restored)

" Exit quickly when VisBlockIncr has already been loaded or when 'compatible' is set
if exists("loaded_visblockincr") || &cp
  finish
endif
let loaded_visblockincr= "v7"

" ------------------------------------------------------------------------------

com! -ra -na=? I    call <SID>VisBlockIncr(0,<f-args>)
com! -ra -na=* II   call <SID>VisBlockIncr(1,<f-args>)
com! -ra -na=? IMDY call <SID>VisBlockIncr(2,<f-args>)
com! -ra -na=? IYMD call <SID>VisBlockIncr(3,<f-args>)
com! -ra -na=? IDMY call <SID>VisBlockIncr(4,<f-args>)
com! -ra -na=? ID   call <SID>VisBlockIncr(5,<f-args>)

" ------------------------------------------------------------------------------

" VisBlockIncr:
fu! <SID>VisBlockIncr(pad,...)
  " save boundary line numbers
  let y1= line("'<")
  let y2= line("'>")

  " get increment (default=1)
  if a:0 > 0
   let incr= a:1
  else
   let incr= 1
  endif
"  call Decho("VisBlockIncr: pad<".a:pad."> a:0=".a:0)

  if a:pad >= 2
   " IMDY  IYMD  IDMY  ID
   norm! `>
   let rght  = virtcol(".")
   norm! `<
   let lft   = virtcol(".")
   let rght  = rght + 1
   let curline= getline("'<")

   if a:pad == 5
    " ID
    let pat    = '^.*\%'.lft.'v\(\a\+\)\%'.rght.'v.*$'
    let dow    = substitute(substitute(curline,pat,'\1','e'),' ','','ge')
    let dowlen = strlen(dow)
	if dow =~ '\cmon'
	 let idow= 0
	elseif dow =~ '\ctue'
	 let idow= 1
	elseif dow =~ '\cwed'
	 let idow= 2
	elseif dow =~ '\cthu'
	 let idow= 3
	elseif dow =~ '\cfri'
	 let idow= 4
	elseif dow =~ '\csat'
	 let idow= 5
	elseif dow =~ '\csun'
	 let idow= 6
	else
	 echoerr "***error*** misspelled day-of-week <".dow.">"
	endif
	if strlen(dow) > 3
	 let dow_0= "Monday"
	 let dow_1= "Tuesday"
	 let dow_2= "Wednesday"
	 let dow_3= "Thursday"
	 let dow_4= "Friday"
	 let dow_5= "Saturday"
	 let dow_6= "Sunday"
	else
	 let dow_0= "Mon"
	 let dow_1= "Tue"
	 let dow_2= "Wed"
	 let dow_3= "Thu"
	 let dow_4= "Fri"
	 let dow_5= "Sat"
	 let dow_6= "Sun"
	endif
    norm! `<
    let l = y1
    while l < y2
   	 norm! j
	 let idow= (idow + incr)%7
	 exe 's/\%'.lft.'v.*\%'.rght.'v/'.dow_{idow}.'/'
	 let l= l + 1
	endw
	" return from ID
   	return
   endif

   let pat= '^.*\%'.lft.'v\( \=[0-9]\{1,4}\)/\( \=[0-9]\{1,2}\)/\( \=[0-9]\{1,4}\)\%'.rght.'v.*$'
   if a:pad == 2
   	" IMDY
    let m     = substitute(substitute(curline,pat,'\1',''),' ','','ge')+0
    let d     = substitute(substitute(curline,pat,'\2',''),' ','','ge')+0
    let y     = substitute(substitute(curline,pat,'\3',''),' ','','ge')+0
	let type  = 2
"    call Decho("IMDY: y=".y." m=".m." d=".d." lft=".lft." rght=".rght)
   elseif a:pad == 3
   	"  IYMD
    let y     = substitute(substitute(curline,pat,'\1',''),' ','','ge')+0
    let m     = substitute(substitute(curline,pat,'\2',''),' ','','ge')+0
    let d     = substitute(substitute(curline,pat,'\3',''),' ','','ge')+0
	let type  = 1
"    call Decho("IYMD: y=".y." m=".m." d=".d." lft=".lft." rght=".rght)
   elseif a:pad == 4
   	"  IDMY
    let d     = substitute(substitute(curline,pat,'\1',''),' ','','ge')+0
    let m     = substitute(substitute(curline,pat,'\2',''),' ','','ge')+0
    let y     = substitute(substitute(curline,pat,'\3',''),' ','','ge')+0
	let type  = 3
"    call Decho("IDMY: y=".y." m=".m." d=".d." lft=".lft." rght=".rght)
   else
   	echoerr "***error in <visincr.vim> script"
   endif
   let julday= Cal2Jul(y,m,d)
   norm! `<
   let l = y1
   while l <= y2
	let doy   = Jul2Cal(julday,type)
	if type == 1
	 " IYMD
     let doy   = substitute(doy,'^\d/','0&','e')
     let doy   = substitute(doy,'/\(\d/\)','/ \1','e')
     let doy   = substitute(doy,'/\(\d\)$','/ \1','e')
	else
	 " IMDY IDMY
     let doy   = substitute(doy,'^\d/',' &','e')
     let doy   = substitute(doy,'/\(\d/\)','/ \1','e')
     let doy   = substitute(doy,'/\(\d\)$','/0\1','e')
	endif
	let doy   = escape(doy,'/')
	exe 's/\%'.lft.'v.*\%'.rght.'v/'.doy.'/'
    let l     = l + 1
	let julday= julday + incr
	if l <= y2
   	 norm! j
	endif
   endw
   return
  endif

  if a:0 > 1 && a:pad
   let zfill= a:2
  else
   let zfill= ' '
  endif
"  call Decho("pad=".a:pad."  y1=".y1."  y2=".y2."  incr=".incr."  zfill<".zfill.">")

  " construct a line from the first line that
  " only has the number in it
  norm! `>
  let rght  = virtcol(".")
  norm! `<
  let lft   = virtcol(".")
  let rml   = rght - lft
  let rmlp1 = rml  + 1
  let lm1   = lft  - 1
"  call Decho("rght=".rght." lft=".lft." rmlp1=".rmlp1." lm1=".lm1)
  if lm1 <= 0
   let lm1 = 1
   let pat = '^\([0-9 \t]\{1,'.rmlp1.'}\).*$'
   let cnt = substitute(getline("'<"),pat,'\1',"")
  else
   let pat = '^\(.\{-}\)\%'.lft.'v\([0-9 \t]\{1,'.rmlp1.'}\).*$'
   let cnt = substitute(getline("'<"),pat,'\2',"")
  endif
  let cntlen = strlen(cnt)
  let cnt    = substitute(cnt,'\s','',"ge")
  let ocnt   = cnt
  let cnt    = substitute(cnt,'^0*\([1-9]\|0$\)','\1',"ge")
"  call Decho("cnt=".cnt." pat<".pat.">")

  " left-pad with zeros
  " IF  top number is zero-padded
  " AND we're justified right
  " AND increment is positive
  " AND user didn't specify a padding character
  if a:0 < 2 && a:pad > 0 && cnt != ocnt && incr > 0
   let zfill= '0'
  endif

  " determine how much padding is needed
  let maxcnt   = cnt + incr*(y2 - y1)
  let maxcntlen= strlen(maxcnt)
  if cntlen > maxcntlen
   let maxcntlen= cntlen
  endif
"  call Decho("maxcntlen=".maxcntlen)

  " go through visual block incrementing numbers based
  " on first number (saved in cnt), taking care to
  " avoid issuing "0h" commands.
  norm! `<
  let l = y1
  while l <= y2
    let cntlen= strlen(cnt)

	" Straighten out ragged-right visual-block selection
	" by appending spaces as needed
	norm! $
	while virtcol("$") <= rght
	 exe "norm! A \<Esc>"
	endwhile
	norm! 0

	" convert visual block line to all spaces
	if virtcol(".") != lft
	 exe 'norm! /\%'.lft."v\<Esc>"
	endif
    exe "norm! " . rmlp1 . "r "

	" cnt has gotten bigger than the visually-selected
	" area allows.  Will insert spaces to accommodate it.
	if maxcntlen > 0
	 let ins= maxcntlen - rmlp1
	else
	 let ins= strlen(cnt) - rmlp1
	endif
    while ins > 0
     exe "norm! i \<Esc>"
     let ins= ins - 1
    endwhile

	" back up to left-of-block (plus optional left-hand-side padding)
	norm! 0
	if a:pad == 0
	 let bkup= lft
	elseif maxcntlen > 0
	 let bkup= lft + maxcntlen - cntlen
	else
	 let bkup= lft
	endif
"	call Decho("cnt=".cnt." bkup= [lft=".lft."]+[maxcntlen=".maxcntlen."]-[cntlen=".cntlen."]=".bkup)
	if virtcol(".") != bkup
	 exe 'norm! /\%'.bkup."v\<Esc>"
	endif

	" replace with count
	exe "norm! R" . cnt . "\<Esc>"
	if cntlen > 1
	 let cntlenm1= cntlen - 1
	 exe "norm! " . cntlenm1 . "h"
	endif
	if zfill != " "
	 let gdkeep= &gd
	 set nogd
	 silent! exe 's/\%'.lft.'v\( \+\)/\=substitute(submatch(1)," ","'.zfill.'","ge")/'
	 let &gd= gdkeep
	endif

	" set up for next line
	if l != y2
	 norm! j
	endif
    let cnt= cnt + incr
    let l  = l  + 1
  endw
endf

" ------------------------------------------------------------------------------
