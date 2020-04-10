@echo off
call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvars64.bat"
set path=t:\env;"c:\Program Files\NASM";"C:\Program Files\Bochs-2.6.11";%path%
set DIRCMD=/o
set HOME=t:\env\vimconf
