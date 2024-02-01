import os

# Input and output file names
input_file_name = 'lab1.bin'
output_file_name = 'labImg1.img'

# Get the size of the input file
input_file_size = os.path.getsize(input_file_name)

# Read the contents of the input file
with open(input_file_name, 'rb') as input_file:
    file_content = input_file.read()

# Create a new file and write the content of the input file
with open(output_file_name, 'wb') as output_file:
    output_file.write(file_content)

# Calculate the number of zero bytes to fill
remaining_size = 1474560 - input_file_size

# Fill the rest of the file with zero bytes
with open(output_file_name, 'ab') as output_file:
    output_file.write(b'\x00' * remaining_size)

print(f"File '{output_file_name}' created with size 1474560 bytes.")