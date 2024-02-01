org 7c00h
; nasm -f bin lab2.asm -o  lab2.bin
section .data
    charCounter db 0

section .bss
    buffer resb 256

section .text
    global _start

_start:
    ; initialize the buffer and its counter
    mov si, buffer
    mov byte [charCounter], 0

    jmp ReadChar


ReadChar:
    ; read character
    mov ah, 00h
    int 16h

    ; check if the ENTER key was introduced
    cmp al, 0dh
    je HoldEnter

    ; check if the BACKSPACE key was introduced
    cmp al, 08h
    je HoldBackspace

    ; check if the buffer limit is reached
    cmp byte [charCounter], 255
    je ReadChar

    ; add character into the buffer and increment its pointer
    mov [si], al
    inc si
    inc byte [charCounter]

    ; display character
    mov ah, 0ah
    mov bh, 0x00
    mov cx, 1
    int 10h

    ; move cursor
    mov ah, 02h
    inc dl
    int 10h

    jmp ReadChar

; hold BACKSPACE key behavior
HoldBackspace:
    cmp dl, 0
    je PrevLine

    ; clear last buffer char 
    dec si
    dec byte [charCounter]

    ; move cursor to the left
    mov ah, 02h
    dec dl
    int 10h

    ; print space instead of the cleared char
    mov ah, 0ah
    mov al, ' '
    mov bh, 0x00
    mov cx, 1
    int 10h

    jmp ReadChar


; hold ENTER key behavior
HoldEnter:
    cmp dl, 0
    je Newline

    cmp byte [charCounter], 0
    je Newline

    ; clear the character buffer 
    mov byte [si], 0
    mov si, buffer

    ; move cursor to the second next line
    mov ah, 02h
    inc dh
    inc dh
    mov dl, 0
    int 10h

    jmp PrintBuffer


; print character buffer
PrintBuffer:
    lodsb; load character form edi into al

    test al, al; AND
    jz Newline

    ; display character
    mov ah, 0ah
    mov bh, 0x00
    mov cx, 1
    int 10h

    ; move cursor
    mov ah, 02h
    inc dl
    int 10h

    jmp PrintBuffer


; move cursor to the beginning of the new line
Newline:
    mov ah, 02h
    inc dh
    mov dl, 0
    int 10h

    jmp _start


; move cursor to the previous line
PrevLine:
    cmp dh, 0
    je _start

    mov ah, 02h
    dec dh
    mov dl, 79
    int 10h

    jmp _start
