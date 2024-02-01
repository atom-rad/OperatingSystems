run:
	-rm $(a).flp
	nasm -f bin -o $(a).flp $(a).asm
	truncate -s 1474560 $(a).flp

clean:
	rm $(a).flp
