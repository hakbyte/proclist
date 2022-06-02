;
; File: proclist.asm
; Author: https://github.com/hakbyte
;

format PE64 console
entry start

include 'win64ax.inc'
include 'proclist.inc'

;-------------------------------------------------------------------------------
; Code
;-------------------------------------------------------------------------------
section '.text' code executable
start:
    cinvoke printf,szHeader
    stdcall ProcessesList
    invoke  ExitProcess,0

;
; ProcessesList uses the CreateToolhelp32Snapshot API to get a handle
; to the system process list and print all processes.
;
proc ProcessesList
        local hProccessSnap:DWORD
        local pe32:PROCESSENTRY32

        ; Get a snapshot of all processes
        invoke  CreateToolhelp32Snapshot,TH32CS_SNAPPROCESS,0
        mov     [hProccessSnap],eax
        cmp     eax,INVALID_HANDLE_VALUE
        je      .error
        mov     [pe32.dwSize],sizeof.PROCESSENTRY32
        invoke  Process32First,[hProccessSnap],addr pe32
        test    eax,eax
        jz      .cleanup

    .next:
        ; Print all processes in snapshot
        cinvoke printf,szFormat,[pe32.th32ProcessID],addr pe32.szExeFile,
        invoke  Process32Next,[hProccessSnap],addr pe32
        test    eax,eax
        jnz     .next

    .cleanup:
        invoke  CloseHandle,[hProccessSnap]

    .error:
        ret ; silently ignore all errors

endp

;-------------------------------------------------------------------------------
; Readonly Data
;-------------------------------------------------------------------------------

section '.rdata' data readable
    szHeader    db  "==================================",10,13,\
                    "PID      EXE FILE",10,13,\
                    "==================================",10,13,0
    szFormat    db  "%-8d %s",10,13,0

;-------------------------------------------------------------------------------
; Imports
;-------------------------------------------------------------------------------

section '.idata' data readable import
    library kernel32,'KERNEL32.DLL',\
            msvcrt,'MSVCRT.DLL'

    import  kernel32,\
            ExitProcess,"ExitProcess",\
            CreateToolhelp32Snapshot,"CreateToolhelp32Snapshot",\
            Process32First,"Process32First",\
            Process32Next,"Process32Next",\
            GetLastError,"GetLastError",\
            CloseHandle,"CloseHandle"

    import  msvcrt,\
            printf,"printf"

