@echo off

IF NOT EXIST .\build mkdir .\build
pushd .\build
nasm -fbin ..\nos\source\boot.asm -o boot.bin

popd
