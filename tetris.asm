;╔══════════════════════════ Tetris - Assembly Implementation ══════════════════════════╗
;║                                                                                      ║
;║  Description:                                                                        ║
;║  This is an open-source implementation of the classic game Tetris in x86-64          ║
;║  assembly language.                                                                  ║
;║                                                                                      ║
;╠════════════════════════════════════ License ═════════════════════════════════════════╣
;║                                                                                      ║
;║  This software is released under the GNU General Public License (GPL).               ║
;║  See the LICENSE file for details.                                                   ║
;║                                                                                      ║
;╠═════════════════════════════════════ Author ═════════════════════════════════════════╣
;║                                                                                      ║
;║  bonsall2004 (GitHub: https://github.com/bonsall2004)                                ║
;║                                                                                      ║
;╚══════════════════════════════════════════════════════════════════════════════════════╝
section .data
    empty_space db ' ', 0
    filled_space db '#', 0
    border_character db '*', 0
    newline_character db 10, 0
    game_title db "Tetris", 0
    clear_screen db 27, "[2J"
    move_cursor db 27, "[", 0, ";", 0, "H"

    second_in_ns dq 1000000000

    sys_write equ 1
    stdout equ 1

section .text

global _start
_start:
    mov rdi, filled_space
    call print_char
    mov rdi, empty_space
    call print_char
    mov rsi, game_title
    call print_string
    mov rdi, empty_space
    call print_char
    mov rdi, filled_space
    call print_char

    mov rdi, 19
    jmp exit_game
    
;|----------------------------|
;| Function Name: print_char  |
;|----------------------------|
;| Description:               |
;| Prints a character to the  |
;| command line               |
;|----------------------------|
;| Inputs:                    |
;| - rdi | character to print |
;|----------------------------|
;| Optional:                  |
;| - r8  | x coordinate       |
;| - r10 | y coordinate       |
;|----------------------------|
print_char:
    ; push the previous value of rax, rsi and rdx to the stack
    push rax 
    push rsi
    push rdx

    ; load the character into the second parameter register
    mov rsi, rdi           
    mov rax, sys_write
    mov rdi, stdout
    mov rdx, 1 
    syscall 
    
    ; return all the values of rax, rsi and rdx back to before the function
    pop rdx 
    pop rsi
    pop rax
    ret

;|----------------------------|
;| Function Name: print_char  |
;|----------------------------|
;| Description:               |
;| Prints a character to the  |
;| command line               |
;|----------------------------|
;| Inputs:                    |
;| - rsi | message to print   |
;|----------------------------|

print_string:
    ; push the previous value of rax, rsi and rdx to the stack
    push rax 
    push rdi

    mov rax, sys_write 
    mov rdi, stdout  
    call get_str_len
    syscall 
    
    ; return all the values of rax, rsi and rdx back to before the function
    pop rdi
    pop rax
    ret

;|----------------------------|
;| Function Name: get_str_len |
;|----------------------------|
;| Description:               |
;| Returns the length of a    |
;| string                     |
;|----------------------------|
;| Inputs:                    |
;| - rsi | string             |
;|----------------------------|
;| Outputs:                   |
;| - rdx | length of string   |
;|----------------------------|
get_str_len:
    xor rdx, rdx

str_len_count_loop:
    cmp byte [rsi + rdx], 0
    je  str_len_done
    inc rdx
    jmp str_len_count_loop

str_len_done:
    ret

;|---------------------------------------|
;| Function Name: print_char_at_location | Broken atm
;|---------------------------------------|
;| Description:                          |
;| Prints a character at a specific      |
;| location on the console screen        |
;|---------------------------------------|
;| Input:                                |
;| - rdi | Row index                     |
;| - rsi | Column index                  |
;| - rdx | Character to be printed       |
;|---------------------------------------|  
print_char_at_location:
    mov rax, rdi
    imul rax, 187 
    add rax, rsi
    
    mov rax, sys_write
    mov rdi, stdout
    mov rsi, move_cursor
    mov rdx, 6
    syscall
    
    mov rdi, newline_character
    call print_char
    ret

;|----------------------------|
;| Function Name: clear_board |
;|----------------------------|
;| Description:               |
;| Clears the console screen  |
;|----------------------------|
clear_board:
    mov rax, sys_write 
    mov rdi, stdout
    mov rsi, clear_screen
    mov rdx, 4
    syscall
    ret

;|----------------------------|
;| Function Name: exit_game   |
;|----------------------------|
;| Description:               |
;| Exits the game             |
;|----------------------------|
;| Inputs:                    |
;| - rdi | exit code          |
;|----------------------------|
exit_game:
    push rdi
    mov rdi, newline_character
    call print_char
    mov rax, 60
    pop rdi
    syscall
