@echo off
call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvars64.bat"
set path=t:\env;"c:\Program Files\NASM";"c:\Program Files\qemu";%path%
set DIRCMD=/o
set HOME=t:\env\vimconf
