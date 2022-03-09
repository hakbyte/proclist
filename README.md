# Proclist

Small program to list Windows processes and their PIDs. Written in x64 Assembly.

## Build

Assembly it using [fasm](https://flatassembler.net):

```txt
C:\>cd proclist\src
C:\proclist\src>fasm proclist.asm
flat assembler  version 1.73.30  (1048576 kilobytes memory)
3 passes, 2048 bytes.
```

## Example Output

```txt
C:>.\proclist.exe
==================================
PID      EXE FILE
==================================
0        [System Process]
4        System
56       Secure System
428      smss.exe
676      csrss.exe
776      wininit.exe
784      csrss.exe
848      services.exe
856      LsaIso.exe
876      lsass.exe
960      winlogon.exe

[ ... ]
```
