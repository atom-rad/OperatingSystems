org 7c00h
; nasm -f bin lab1a.asm -o  lab1a.bin
section .text
  global _start

_start:
  mov ax, 0xB800; address of the Video memory
  mov es, ax;        
  xor di, di; offset to write characters to video memory pointer
    
  mov ax, 'B';
  stosb; write the character to the memory
  mov    ax, 0x04; text color
  stosb; write the attribute to the memory