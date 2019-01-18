# :)

rm -rf happy.asm

echo use16 >> happy.asm
echo cmp ch,[bx+di] >> happy.asm

nasm -f bin happy.asm -o happy.txt
echo ":)"

notepad happy.txt

#     _______
#    /       \
#   |  o   o  | 
#   |         |
#   |  \___/  |
#    \_______/
#
#
#

