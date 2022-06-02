;
; Maximum number of characters in a file path.
; Ref: https://msdn.microsoft.com/en-us/library/cc249520.aspx
;

MAX_PATH                equ 0x00000104

TH32CS_SNAPPROCESS      equ 0x00000002

;
; PROCESSENTRY32 structure.
; Ref: https://docs.microsoft.com/en-us/windows/desktop/api/tlhelp32/ns-tlhelp32-tagprocessentry32
;

struct PROCESSENTRY32
    dwSize              dd ?
    cntUsage            dd ?
    th32ProcessID       dd ?
    th32DefaultHeapID   dq ?
    th32ModuleID        dd ?
    cntThreads          dd ?
    th32ParentProcessID dd ?
    pcPriClassBase      dq ?
    dwFlags             dd ?
    szExeFile           db MAX_PATH dup(?)
ends

