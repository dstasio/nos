@echo off

IF NOT EXIST ..\build mkdir ..\build
pushd ..\build
nasm -fbin ..\code\boot.asm -o ..\build\boot.bin

gcc -ffreestanding -c ../code/kernel.c -o kernel.o
ld -o kernel.bin -Ttext 0x1000 kernel.o --oformat binary

popd
