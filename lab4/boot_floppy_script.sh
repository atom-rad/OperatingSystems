#!/bin/bash

binary_file="colorflag.bin"
bootloader="bootloader.asm"
mini_boot="mini_boot.asm"

# Check if the binary file exists
if [ ! -f "$binary_file" ]; then
    echo "Error: Binary file '$binary_file' does not exist."
    exit 1
fi

nasm -f bin $mini_boot -o mini_boot.bin
nasm -f bin $bootloader -o bootloader.bin

# Create an empty floppy disk image (1.44MB size)
floppy_image="floppy.img"
truncate -s 1474560 mini_boot.bin
mv mini_boot.bin $floppy_image

dd if="bootloader.bin" of="$floppy_image" bs=512 seek=1 conv=notrunc
dd if="$binary_file" of="$floppy_image" bs=512 seek=1111 conv=notrunc

echo "Binary file '$binary_file' successfully added to floppy image '$floppy_image'."