# Compile
nasm -f bin boot/main.asm -o bin/bootsect.exe
nasm -f bin krnl/main.asm -o bin/dnkrnlos.exe

# Build
cat bin/bootsect.exe bin/dnkrnlos.exe > unreal.bin

# Clean
cd bin
rm * -rf
cd ..

# Test
qemu-system-i386 -fda unreal.bin -d guest_errors
