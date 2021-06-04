@echo off

IF NOT EXIST ..\build mkdir ..\build
REM pushd ..\build
nasm -fbin ..\code\boot.asm -o ..\build\boot.bin

cl 

REM popd
