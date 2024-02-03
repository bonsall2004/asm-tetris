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
  move_cursor db 27, "[", 0, ";", 0, "H"
  board_width equ 10
  board_height equ 20
  board_size equ board_width * board_height
  tetris_board db board_size, 0

  second_in_ns dq 1000000000

  sys_write equ 1
  stdout equ 1

section .text

global _start

extern print_char
extern clear_board
extern print_string
extern exit
extern init_video_buffer
extern display_video_buffer
extern update_position
extern display_border

_start:
  call init_video_buffer
  
  mov rdi, '#'
  mov rsi, 5
  mov rdx, 2
  call update_position

  call draw_board

  mov rdi, 19
  call exit

game_loop:
  call draw_board
  ret

draw_board:
  call clear_board
  call display_border
  call display_video_buffer
  ret

