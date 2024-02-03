mkdir -p build
mkdir -p bin

cd build

cmake ..

if [ $? -ne 0 ]; then
    echo "CMake Failed"
    exit 1
fi

make

if [ $? -ne 0 ]; then
    echo "Make Failed"
    exit 2
fi


../bin/tetris
exit_code=$?
echo ""
echo "Exited with code: $exit_code"
