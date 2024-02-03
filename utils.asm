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
  clear_screen db 27, "[2J"
  newline_character db 10, 0
  sys_write equ 1
  stdout equ 1

section .text

global print_char
global clear_board
global print_string
global exit

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

;|-----------------------------|
;| Function Name: print_string |
;|-----------------------------|
;| Description:                |
;| Prints a string to the      |
;| command line                |
;|-----------------------------|
;| Inputs:                     |
;| - rsi | message to print    |
;|-----------------------------|
print_string:
  ; push the previous value of rax and rdi to the stack
  push rax 
  push rdi

  mov rax, sys_write 
  mov rdi, stdout  
  call get_str_len
  syscall 
  
  ; return all the values of rax and rdi back to before the function
  pop rdi
  pop rax
  ret

;|----------------------------|
;| Function Name: get_str_len |
;|----------------------------|
;| Description:               |
;| Calculates the length of   | 
;| String                     |
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

;|----------------------------|
;| Function Name: exit        |
;|----------------------------|
;| Description:               |
;| Exits the program          |
;|----------------------------|
;| Inputs:                    |
;| - rdi | exit code          |
;|----------------------------|
exit:
  push rdi
  mov rdi, newline_character
  call print_char
  
  mov rax, 60
  pop rdi
  syscall
