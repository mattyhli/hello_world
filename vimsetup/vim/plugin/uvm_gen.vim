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

" Return types name as arguments
function <SID>ReturnTypesList(A,L,P)
    return s:type_list
endf

function! UVMAgentPkg(name)
    let l:template_filename = "uvm_agent_pkg.sv"
    let l:template = s:default_template_dir . "/" . l:template_filename
    let l:uppername = toupper(a:name)

    call <SID>TLoadCmd(l:template)
    call <SID>TExpand("NAME", a:name)
    call <SID>TExpand("UPPERNAME", l:uppername)
endfunction

function! SVIntf(name)
    let l:template_filename = "sv_intf.sv"
    let l:template = s:default_template_dir . "/" . l:template_filename
    let l:uppername = toupper(a:name)

    call <SID>TLoadCmd(l:template)
    call <SID>TExpand("NAME", a:name)
    call <SID>TExpand("UPPERNAME", l:uppername)
endfunction

function! UVMItem(name)
    let l:template_filename = "uvm_seq_item.sv"
    let l:template = s:default_template_dir . "/" . l:template_filename
    let l:uppername = toupper(a:name)

    call <SID>TLoadCmd(l:template)
    call <SID>TExpand("NAME", a:name)
    call <SID>TExpand("UPPERNAME", l:uppername)
endfunction

function! UVMCfg(name)
    let l:template_filename = "uvm_config.sv"
    let l:template = s:default_template_dir . "/" . l:template_filename
    let l:uppername = toupper(a:name)

    call <SID>TLoadCmd(l:template)
    call <SID>TExpand("NAME", a:name)
    call <SID>TExpand("UPPERNAME", l:uppername)
endfunction

function! UVMSqr(name)
    let l:template_filename = "uvm_sequencer.sv"
    let l:template = s:default_template_dir . "/" . l:template_filename
    let l:uppername = toupper(a:name)

    call <SID>TLoadCmd(l:template)
    call <SID>TExpand("NAME", a:name)
    call <SID>TExpand("UPPERNAME", l:uppername)
endfunction

function! UVMDrv(name)
    let l:template_filename = "uvm_driver.sv"
    let l:template = s:default_template_dir . "/" . l:template_filename
    let l:uppername = toupper(a:name)

    call <SID>TLoadCmd(l:template)
    call <SID>TExpand("NAME", a:name)
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

function! UVMFCov(name)
    let l:template_filename = "uvm_fcov.sv"
    let l:template = s:default_template_dir . "/" . l:template_filename
    let l:uppername = toupper(a:name)

    call <SID>TLoadCmd(l:template)
    call <SID>TExpand("NAME", a:name)
    call <SID>TExpand("UPPERNAME", l:uppername)
endfunction

function! UVMAgent(name)
    let l:template_filename = "uvm_agent.sv"
    let l:template = s:default_template_dir . "/" . l:template_filename
    let l:uppername = toupper(a:name)

    call <SID>TLoadCmd(l:template)
    call <SID>TExpand("NAME", a:name)
    call <SID>TExpand("UPPERNAME", l:uppername)
endfunction

function! UVMSeq(name, req)
    let l:template_filename = "uvm_sequence.sv"
    let l:template = s:default_template_dir . "/" . l:template_filename
    let l:uppername = toupper(a:name)

    call <SID>TLoadCmd(l:template)
    call <SID>TExpand("NAME", a:name)
    call <SID>TExpand("REQ", a:req)
    call <SID>TExpand("UPPERNAME", l:uppername)
endfunction

function! UVMEnvPkg(name)
    let l:template_filename = "uvm_env_pkg.sv"
    let l:template = s:default_template_dir . "/" . l:template_filename
    let l:uppername = toupper(a:name)

    call <SID>TLoadCmd(l:template)
    call <SID>TExpand("NAME", a:name)
    call <SID>TExpand("UPPERNAME", l:uppername)
endfunction

function! UVMVSqr(name)
    let l:template_filename = "uvm_vsqr.sv"
    let l:template = s:default_template_dir . "/" . l:template_filename
    let l:uppername = toupper(a:name)

    call <SID>TLoadCmd(l:template)
    call <SID>TExpand("NAME", a:name)
    call <SID>TExpand("UPPERNAME", l:uppername)
endfunction

function! UVMEnv(name, cpuif)
    let l:template_filename = "uvm_env.sv"
    let l:template = s:default_template_dir . "/" . l:template_filename
    let l:uppername = toupper(a:name)

    call <SID>TLoadCmd(l:template)
    call <SID>TExpand("NAME", a:name)
    call <SID>TExpand("CPUIF", a:cpuif)
    call <SID>TExpand("UPPERNAME", l:uppername)
endfunction

function! UVMVBS(name)
    let l:template_filename = "uvm_base_vseq.sv"
    let l:template = s:default_template_dir . "/" . l:template_filename
    let l:uppername = toupper(a:name)

    call <SID>TLoadCmd(l:template)
    call <SID>TExpand("NAME", a:name)
    call <SID>TExpand("UPPERNAME", l:uppername)
endfunction

function! UVMVSeq(name, parent)
    let l:template_filename = "uvm_vseq.sv"
    let l:template = s:default_template_dir . "/" . l:template_filename
    let l:uppername = toupper(a:name)

    call <SID>TLoadCmd(l:template)
    call <SID>TExpand("NAME", a:name)
    call <SID>TExpand("PNAME", a:parent)
    call <SID>TExpand("UPPERNAME", l:uppername)
endfunction

function! UVMTestPkg(name)
    let l:template_filename = "uvm_test_pkg.sv"
    let l:template = s:default_template_dir . "/" . l:template_filename
    let l:uppername = toupper(a:name)

    call <SID>TLoadCmd(l:template)
    call <SID>TExpand("NAME", a:name)
    call <SID>TExpand("UPPERNAME", l:uppername)
endfunction

function! UVMBTest(name)
    let l:template_filename = "uvm_base_test.sv"
    let l:template = s:default_template_dir . "/" . l:template_filename
    let l:uppername = toupper(a:name)

    call <SID>TLoadCmd(l:template)
    call <SID>TExpand("NAME", a:name)
    call <SID>TExpand("UPPERNAME", l:uppername)
endfunction

function! UVMTest(name, parent)
    let l:template_filename = "uvm_test.sv"
    let l:template = s:default_template_dir . "/" . l:template_filename
    let l:uppername = toupper(a:name)

    call <SID>TLoadCmd(l:template)
    call <SID>TExpand("NAME", a:name)
    call <SID>TExpand("PNAME", a:parent)
    call <SID>TExpand("UPPERNAME", l:uppername)
endfunction

function! UVMR2B(name)
    let l:template_filename = "uvm_reg2x_adapter.sv"
    let l:template = s:default_template_dir . "/" . l:template_filename
    let l:uppername = toupper(a:name)

    call <SID>TLoadCmd(l:template)
    call <SID>TExpand("NAME", a:name)
    call <SID>TExpand("UPPERNAME", l:uppername)
endfunction




" === plugin commands === {{{
command -nargs=1 UVMAgentPkg call UVMAgentPkg("<args>")
command -nargs=1 SVIntf call SVIntf("<args>")
command -nargs=1 UVMItem call UVMItem("<args>")
command -nargs=1 UVMCfg call UVMCfg("<args>")
command -nargs=1 UVMSqr call UVMSqr("<args>")
command -nargs=1 UVMDrv call UVMDrv("<args>")
command -nargs=1 UVMMon call UVMMon("<args>")
command -nargs=1 UVMFCov call UVMFCov("<args>")
command -nargs=1 UVMAgent call UVMAgent("<args>")
command -nargs=+ -complete=customlist,<SID>ReturnTypesList UVMSeq call UVMSeq(<f-args>)
command -nargs=1 UVMEnvPkg call UVMEnvPkg("<args>")
command -nargs=1 UVMVSqr call UVMVSqr("<args>")
command -nargs=+ -complete=customlist,<SID>ReturnTypesList UVMEnv call UVMEnv(<f-args>)
command -nargs=1 UVMVBS call UVMVBS("<args>")
command -nargs=+ -complete=customlist,<SID>ReturnTypesList UVMVSeq call UVMVSeq(<f-args>)
command -nargs=1 UVMTestPkg call UVMTestPkg("<args>")
command -nargs=1 UVMBTest call UVMBTest("<args>")
command -nargs=+ -complete=customlist,<SID>ReturnTypesList UVMTest call UVMTest(<f-args>)
command -nargs=1 UVMR2B call UVMR2B("<args>")


"command -nargs=1 UVMSeqItem call UVMSeqItem("<args>")
"command -nargs=+ -complete=customlist,<SID>ReturnTypesList UVMVSeq call UVMVSeq(<f-args>)


" }}}

let &cpo = s:save_cpo
unlet s:save_cpo
