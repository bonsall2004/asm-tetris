# Tetris in Assembly

This is a simple implementation of the classic game Tetris written in x86-64 assembly language. The project is part of my journey in learning assembly language programming.

## Features

- Basic Tetris gameplay mechanics. ( Coming Soon )
- Console-based user interface. (Coming Soon )
- Written in x86-64 assembly. 

## Getting Started

### Prerequisites

- A computer with an x86-64 architecture.
- An assembly language compiler (e.g., NASM).
- A system that supports x86-64 assembly (Linux is recommended).

### Building and Running

1. Clone the repository:

    ```bash
    git clone https://github.com/bonsall2004/asm-tetris.git
    cd asm-tetris
    ```

2. Assemble the source code:

    ```bash
    nasm -f elf64 tetris.asm -o tetris.o
    ```

3. Link the object file:

    ```bash
    ld tetris.o -o tetris
    ```

4. Run the executable:

    ```bash
    ./tetris
    ```

## Contributing

Contributions are welcome! Feel free to open issues or pull requests for any improvements or bug fixes.

## License

This project is licensed under the GPL License - see the [LICENSE](https://www.gnu.org/licenses/gpl-3.0.en.html) file for details.
