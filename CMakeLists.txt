cmake_minimum_required(VERSION 3.16)
enable_language(ASM_NASM)
set(CMAKE_ASM_NASM_OBJECT_FORMAT elf64)
set(CMAKE_ASM_NASM_LINK_EXECUTABLE "ld <CMAKE_ASM_NASM_LINK_FLAGS> <LINK_FLAGS> <OBJECTS>  -o <TARGET> <LINK_LIBRARIES>")
set(CMAKE_ASM_NASM_FLAGS_DEBUG "-g -Fdwarf")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/../bin)
set(NAME tetris)

set(SOURCE_FILES
  main.asm
  utils.asm
  graphics.asm
)
set_source_files_properties(${SOURCE_FILES} PROPERTIES LANGUAGE ASM_NASM)

add_executable(${NAME}
    ${SOURCE_FILES}
)

target_link_libraries(${NAME})
target_link_options(${NAME} PRIVATE --dynamic-linker /lib64/ld-linux-x86-64.so.2)
install(TARGETS ${NAME} DESTINATION ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})