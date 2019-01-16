# Compile
echo "              >> Assembling..."
nasm -O0 -f bin "boot/main.asm" -o "bin/bootsect.exe"
nasm -O0 -f bin "loadkrnl/main.asm" -o "bin/loadkrnl.sys"
nasm -O0 -f bin "krnl/main.asm" -o "bin/kernelos.exe"

# Build
echo "              >> Building..."

imdisk -a -f "bin/unreal.img" -s 1440K -p "/fs:fat /q /y" -m B:
# Create directories
echo "          >>>> Creating directories..."

mkdir "b:/bin/"
mkdir "b:/bin/backup/"
mkdir "b:/etc/"
mkdir "b:/temp/"
mkdir "b:/lib/"

# Copy files
echo "          >>>> Copying system files..."

cp "bin/loadkrnl.sys" "b:/"
cp "bin/kernelos.exe" "b:/bin/"
cp "bin/bootsect.exe" "b:/bin/backup/"
cp "bin/loadkrnl.sys" "b:/bin/backup/"

cp "headers/" "b:/lib/" -r
cp "etc/home/" "b:/" -r
cp "b:/home/" "b:/etc/homeback/" -r

imdisk -D -m B:

dd conv=notrunc if="bin/bootsect.exe" of="bin/unreal.img" bs=2048 count=1

rm "bin/unreal.dmg" -rf
rm "bin/unreal.flp" -rf
cp "bin/unreal.img" "bin/unreal.dmg"
cp "bin/unreal.img" "bin/unreal.flp"

# Clean
echo "              >> Cleaning..."
cd "bin"
rm *.exe *.bin *.o *.sys -rf
cd ..

# Checksum
echo "              >> Calculating checksums..."
python etc/python/hash.py "bin/unreal.img"

# Test
echo "              >> Starting QEMU..."
qemu-system-i386 -fda "bin/unreal.img" -d guest_errors
# Don't even try --nographic, it messes everything up...
