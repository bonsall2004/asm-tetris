section .data
  width equ 12
  height equ 21
  empty_space db 'f',0 
  newline_character db 10, 0

bits 64
section .bss
  video_buffer resb width * height

section .text

extern clear_board
extern print_string

global init_video_buffer
global update_position
global display_video_buffer
global display_border

;|-----------------------------------|
;| Function Name: init_video_buffer  |
;|-----------------------------------|
;| Description:                      |
;| Initialises the display buffer    |
;|-----------------------------------|
init_video_buffer:
  push rdi
  push rcx
  push rax 
  mov rdi, video_buffer
  mov rcx, width * height
  mov rax, ' '
  rep stosb
  pop rax
  pop rcx
  pop rdi
  ret
;|--------------------------------------|
;| Function Name: update_position       |
;|--------------------------------------|
;| Description:                         |
;| Updates the video buffer             |
;|--------------------------------------|
;| Inputs:                              |
;| - rdi | ASCII character              |
;| - rsi | column                       |
;| - rdx | row                          |
;|--------------------------------------|
update_position:
  push rax
  push rsi
  push rdx

  mov rax, width
  imul rax, rdx
  add rax, rsi
  mov byte [video_buffer + rax], dil

  pop rdx
  pop rsi
  pop rax
  ret

;|--------------------------------------|
;| Function Name: display_video_buffer  |
;|--------------------------------------|
;| Description:                         |
;| Displays the video buffer to the     | 
;| screen                               |
;|--------------------------------------|
display_video_buffer:
    push rax
    push rdi
    push r8
    push r10
    push rdx
    xor r8, r8

display_video_loop: 
    mov r10, r8
    imul r10, width 
    mov     rax, 1
    mov     rdi, 1
    lea rsi, [video_buffer + r10]
    mov     rdx, width
    syscall
    
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, newline_character
    mov     rdx, 1
    syscall

    cmp r8, height
    jz display_done
    inc     r8
    jmp     display_video_loop


display_done:
    pop rdx
    pop r10
    pop r8
    pop rdi
    pop rax
    ret

;|--------------------------------------|
;| Function Name: display_border        |
;|--------------------------------------|
;| Description:                         |
;| Displays the video buffer to the     | 
;| screen                               |
;|--------------------------------------|
display_border:
  mov rdi, '*'
  xor rsi, rsi
  xor rdx, rdx
  call display_horizontal_border_loop
  xor rsi, rsi
  mov rdx, height
  call display_horizontal_border_loop
  xor rsi, rsi
  xor rdx, rdx
  call display_vertical_border
  mov rsi, width
  dec rsi
  xor rdx, rdx
  call display_vertical_border

  display_horizontal_border_loop:
    call update_position
    cmp rsi, width
    je display_borders_done
    inc rsi
    jmp display_horizontal_border_loop
  
  display_vertical_border:
    call update_position
    cmp rdx, height
    je display_borders_done
    inc rdx
    jmp display_vertical_border


display_borders_done:
  ret