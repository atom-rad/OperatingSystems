org 7c00h
; nasm -f bin lab1.asm -o  lab1.bin
section .data
    mystr db "START!", 0
    let dd 'S'
section .text
    global _start

_start:
    ; printing letter 'H'
    ; TTY output \ update cursor position
    mov ah, 0eh
    mov al, 72 ; ascii code for the letter 'H'
    mov bl, 0x08 ; white foreground color attribute
    int 10h

      ; move cursor
  mov ah, 02h;
  mov dh, 0x10;
  mov dl, 0x23; column
  int 10h;

  mov ah, 0eh
  mov al, 65 ; ascii code for the letter 'A'
  mov bl, 0x04 ; white foreground color attribute
  int 10h
    
    ; printing letter 'I'
    mov ah, 0ah
    mov al, 73 ; ascii code for the letter 'I'
    mov bl, 0x09 
    int 10h

    ; move cursor
  mov ah, 02h;
  mov dh, 0x00;
  mov dl, 0x04; column
  int 10h;

    ; write char/attribute
  mov ah, 09h;
  mov al, 69; E - ascii number
  mov bl, 0x02; green color attribute
  mov cx, 1;
  int 10h;

  ; move cursor
  mov ah, 02h;
  mov dh, 0x05;
  mov dl, dh;
  int 10h;

    ; Use di register to point to the destination offset
    lea di, [let] ; lea instruction that performs memory addressing calculations but doesn't actually address memory.

    ; Load the character 'S' from the memory location pointed by di
    mov al, [di]
    ; Call interrupt 10h to perform video services
    mov ax, 1302h
    int 10h

  ; move cursor
  mov ah, 02h;
  mov dh, 0x07;
  mov dl, dh;
  int 10h;

    ; Use dj register to point to the destination offset
    lea di, [let]

    ; Load the character 'S' from the memory location pointed by di
    mov al, [di]
    ; Call interrupt 10h to perform video services
  mov ax, 1303h
  int 10h;

    ; printing the string "START!"
    mov ah, 13h
    mov al, 0 ; attribute
    mov bh, 0 ; page number
    mov cx, 6 ; number of characters
    mov dh, 0x03 ; row
    mov dl, dh; column
    mov dx, 14 ; column and row position
    mov bp, mystr ; pointer to the string
    int 10h

    ; display string + update cursor
  mov ax, 0h;
  mov es, ax;
  mov bl, 0x03; cyan color attribute
  mov cx, 0x06; length of string
  mov dh, 0x10; row to start writing
  mov dl, dh; column to start writing
  mov bp, mystr;
  mov ax, 1301h;
  int 10h;




