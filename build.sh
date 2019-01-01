# Compile
echo ">> Compiling..."
nasm -f bin boot/main.asm -o bin/bootsect.exe
nasm -f bin krnl/main.asm -o bin/kernelos.exe

# Build
echo ">> Building..."
cat bin/bootsect.exe bin/kernelos.exe > bin/unreal.img

# Clean
echo ">> Cleaning..."
cd bin
rm *.exe *.bin *.o -rf
cd ..

# Test
echo ">> Starting QEMU..."
qemu-system-i386 -fda bin/unreal.img -d guest_errors
