" my filetype file
if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  au! BufRead,BufNewFile *.vr,*.vrh,*.vri       setfiletype vera
  au! BufNewFile,BufRead *.sv,*.svh,*.v,*.vh	setfiletype systemverilog
  au! BufNewFile,BufRead *.vpp                  setfiletype vpp
  au! BufNewFile,BufRead *.rdl                  setfiletype systemrdl
  " au! BufNewFile,BufRead *.v,*.vh,*.spec	setfiletype verilog
augroup END

