nasm -f elf64 -o tetris.o tetris.asm

if [ $? -ne 0 ]; then
  echo "Assembling Failed"
  exit 1
fi
ld -o tetris tetris.o
if [ $? -ne 0 ]; then
  echo "Linking Failed"
  exit 1
fi
./tetris
exit_code=$?
echo ""
echo "Exited with code: $exit_code"
