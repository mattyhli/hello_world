" Vim Plugin for UVM Template Generation
" Language:     Vim
" Maintainer:   Matt Li <mattyhli@gmail.com>
" Version:      0.1
" Modified:     2021-4-15
" For version 7.x or above

if (exists("g:uvm_tg_plugin_loaded") && g:uvm_tg_plugin_loaded)
   finish
endif
let g:uvm_tg_plugin_loaded = 1

let s:save_cpo = &cpo
set cpo&vim

" normalize the path
" replace the windows path sep \ with /
function <SID>NormalizePath(path)
    return substitute(a:path, "\\", "/", "g")
endfunction

" Returns a string containing the path of the parent directory of the given
" path. Works like dirname(3). It also simplifies the given path.
function <SID>DirName(path)
    let l:tmp = <SID>NormalizePath(a:path)
    return substitute(l:tmp, "[^/][^/]*/*$", "", "")
endfunction

" Default templates directory
let s:default_template_dir = <SID>DirName(<SID>DirName(expand("<sfile>"))) . "templates/uvm"

" Makes a single [variable] expansion, using [value] as replacement.
"
function <SID>TExpand(variable, value)
    silent execute "%s/{:" . a:variable . ":}/" .  a:value . "/g"
endfunction

" Load the template, and read it
function <SID>TLoadCmd(template)
    if filereadable(a:template)
        " let l:tFile = a:template
        if a:template != ""
            execute "r " . a:template
            " call <SID>TExpandVars()
            " call <SID>TPutCursor()
            setlocal nomodified
        endif
    else
        echo "ERROR! Can not find" . a:template
    endif

endfunction

function! UVMSeqItem(name)
    let l:template_filename = "uvm_seq_item.sv"
    let l:template = s:default_template_dir . "/" . l:template_filename
    let l:uppername = toupper(a:name)

    call <SID>TLoadCmd(l:template)
    call <SID>TExpand("NAME", a:name)
    call <SID>TExpand("UPPERNAME", l:uppername)
endfunction

function! UVMConfig(name)
    let l:template_filename = "uvm_config.sv"
    let l:template = s:default_template_dir . "/" . l:template_filename
    let l:uppername = toupper(a:name)

    call <SID>TLoadCmd(l:template)
    call <SID>TExpand("NAME", a:name)
    call <SID>TExpand("UPPERNAME", l:uppername)
endfunction

function! UVMSeq(name)
    let l:template_filename = "uvm_sequence.sv"
    let l:template = s:default_template_dir . "/" . l:template_filename
    let l:uppername = toupper(a:name)

    call <SID>TLoadCmd(l:template)
    call <SID>TExpand("NAME", a:name)
    call <SID>TExpand("UPPERNAME", l:uppername)
endfunction

function! UVMVSeq(name, pname)
    let l:template_filename = "uvm_vseq.sv"
    let l:template = s:default_template_dir . "/" . l:template_filename
    let l:uppername = toupper(a:name)

    call <SID>TLoadCmd(l:template)
    call <SID>TExpand("NAME", a:name)
    call <SID>TExpand("PNAME", a:pname)
    call <SID>TExpand("UPPERNAME", l:uppername)
endfunction

function! UVMVBSeq(name)
    let l:template_filename = "uvm_base_vseq.sv"
    let l:template = s:default_template_dir . "/" . l:template_filename
    let l:uppername = toupper(a:name)

    call <SID>TLoadCmd(l:template)
    call <SID>TExpand("NAME", a:name)
    call <SID>TExpand("UPPERNAME", l:uppername)
endfunction

function! UVMDriver(name, req)
    let l:template_filename = "uvm_driver.sv"
    let l:template = s:default_template_dir . "/" . l:template_filename
    let l:uppername = toupper(a:name)

    call <SID>TLoadCmd(l:template)
    call <SID>TExpand("NAME", a:name)
    call <SID>TExpand("REQ", a:req)
    call <SID>TExpand("UPPERNAME", l:uppername)
endfunction

function! UVMSqr(name, req)
    let l:template_filename = "uvm_sequencer.sv"
    let l:template = s:default_template_dir . "/" . l:template_filename
    let l:uppername = toupper(a:name)

    call <SID>TLoadCmd(l:template)
    call <SID>TExpand("NAME", a:name)
    call <SID>TExpand("REQ", a:req)
    call <SID>TExpand("UPPERNAME", l:uppername)
endfunction

function! UVMMon(name)
    let l:template_filename = "uvm_monitor.sv"
    let l:template = s:default_template_dir . "/" . l:template_filename
    let l:uppername = toupper(a:name)

    call <SID>TLoadCmd(l:template)
    call <SID>TExpand("NAME", a:name)
    call <SID>TExpand("UPPERNAME", l:uppername)
endfunction

function! UVMCov(name, trans)
    let l:template_filename = "uvm_fcov.sv"
    let l:template = s:default_template_dir . "/" . l:template_filename
    let l:uppername = toupper(a:name)

    call <SID>TLoadCmd(l:template)
    call <SID>TExpand("NAME", a:name)
    call <SID>TExpand("TRANS", a:trans)
    call <SID>TExpand("UPPERNAME", l:uppername)
endfunction

function! UVMAgent(name, trans)
    let l:template_filename = "uvm_agent.sv"
    let l:template = s:default_template_dir . "/" . l:template_filename
    let l:uppername = toupper(a:name)

    call <SID>TLoadCmd(l:template)
    call <SID>TExpand("NAME", a:name)
    call <SID>TExpand("TRANS", a:trans)
    call <SID>TExpand("UPPERNAME", l:uppername)
endfunction

function! UVMSb(name, trans)
    let l:template_filename = "uvm_scoreboard.sv"
    let l:template = s:default_template_dir . "/" . l:template_filename
    let l:uppername = toupper(a:name)

    call <SID>TLoadCmd(l:template)
    call <SID>TExpand("NAME", a:name)
    call <SID>TExpand("TRANS", a:trans)
    call <SID>TExpand("UPPERNAME", l:uppername)
endfunction

function! UVMSb2(name, trans1, trans2)
    let l:template_filename = "uvm_scoreboard2.sv"
    let l:template = s:default_template_dir . "/" . l:template_filename
    let l:uppername = toupper(a:name)

    call <SID>TLoadCmd(l:template)
    call <SID>TExpand("NAME", a:name)
    call <SID>TExpand("TRANS1", a:trans1)
    call <SID>TExpand("TRANS2", a:trans2)
    call <SID>TExpand("UPPERNAME", l:uppername)
endfunction

function! UVMEnv(name, cpuif)
    let l:template_filename = "uvm_env.sv"
    let l:template = s:default_template_dir . "/" . l:template_filename
    let l:uppername = toupper(a:name)
    let l:cpuifupper = toupper(a:cpuif)

    call <SID>TLoadCmd(l:template)
    call <SID>TExpand("NAME", a:name)
    call <SID>TExpand("CPUIF", a:cpuif)
    call <SID>TExpand("CPUIFUPPER", l:cpuifupper)
    call <SID>TExpand("UPPERNAME", l:uppername)
endfunction

function! UVMBTest(name, cpuif, aname)
    let l:template_filename = "uvm_base_test.sv"
    let l:template = s:default_template_dir . "/" . l:template_filename
    let l:uppername = toupper(a:name)
    let l:cpuifupper = toupper(a:cpuif)
    let l:anameupper = toupper(a:aname)

    call <SID>TLoadCmd(l:template)
    call <SID>TExpand("NAME", a:name)
    call <SID>TExpand("CPUIF", a:cpuif)
    call <SID>TExpand("ANAME", a:aname)
    call <SID>TExpand("CPUIFUP", l:cpuifupper)
    call <SID>TExpand("ANAMEUP", l:anameupper)
    call <SID>TExpand("UPPERNAME", l:uppername)
endfunction

function! UVMTest(name, pname)
    let l:template_filename = "uvm_test.sv"
    let l:template = s:default_template_dir . "/" . l:template_filename
    let l:uppername = toupper(a:name)

    call <SID>TLoadCmd(l:template)
    call <SID>TExpand("NAME", a:name)
    call <SID>TExpand("PNAME", a:pname)
    call <SID>TExpand("UPPERNAME", l:uppername)
endfunction

function! UVMAdapter(name)
    let l:template_filename = "uvm_reg2x_adapter.sv"
    let l:template = s:default_template_dir . "/" . l:template_filename
    let l:uppername = toupper(a:name)

    call <SID>TLoadCmd(l:template)
    call <SID>TExpand("NAME", a:name)
    call <SID>TExpand("UPPERNAME", l:uppername)
endfunction

" Return types name as arguments
function ReturnTypesList(A,L,P)
    return s:type_list
endf

" === plugin commands === {{{
command -nargs=1 UVMSeqItem call UVMSeqItem("<args>")
command -nargs=1 UVMItem call UVMSeqItem("<args>")
command -nargs=1 UVMConfig call UVMConfig("<args>")
command -nargs=1 UVMSeq call UVMSeq("<args>")
command -nargs=+ -complete=customlist,ReturnTypesList UVMVSeq call UVMVSeq(<f-args>)
command -nargs=1 UVMVBSeq call UVMVBSeq("<args>")
command -nargs=+ -complete=customlist,ReturnTypesList UVMDriver call UVMDriver(<f-args>)
command -nargs=+ -complete=customlist,ReturnTypesList UVMSqr call UVMSqr(<f-args>)
command -nargs=1 UVMMon call UVMMon("<args>")
command -nargs=+ -complete=customlist,ReturnTypesList UVMCov call UVMCov(<f-args>)
command -nargs=+ -complete=customlist,ReturnTypesList UVMAgent call UVMAgent(<f-args>)
command -nargs=+ -complete=customlist,ReturnTypesList UVMSb call UVMSb(<f-args>)
command -nargs=+ -complete=customlist,ReturnTypesList UVMSb2 call UVMSb2(<f-args>)
command -nargs=+ -complete=customlist,ReturnTypesList UVMEnv call UVMEnv(<f-args>)
command -nargs=+ -complete=customlist,ReturnTypesList UVMBTest call UVMBTest(<f-args>)
command -nargs=+ -complete=customlist,ReturnTypesList UVMTest call UVMTest(<f-args>)
command -nargs=1 UVMAdapter call UVMAdapter("<args>")

"command -nargs=1 UVMEnv call UVMEnv("<args>")
"command -nargs=1 UVMTest call UVMTest("<args>")
"command -nargs=1 UVMAgent call UVMAgent("<args>")
"command -nargs=1 UVMTop call UVMTop("<args>")
"command -nargs=1 UVMInterface call UVMInterface("<args>")

" }}}

let &cpo = s:save_cpo
unlet s:save_cpo
