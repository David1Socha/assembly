assembly
==============

A 2-pass assembler created for UNL CSCE 230's processor project.

##Usage:

Ruby must be installed to use this assembler. 
Navigate to \lib and enter "ruby assemble_code.rb". The program will prompt you for input file and output file names.
Alternatively, you may pass input and output file names as command line arguments. This is done with the format "ruby assemble_code.rb \<SOURCE_FILE\> \<OUTPUT_FILE\>"

See spec/assembler_spec.rb for examples on how each instruction is formatted. One primary difference of note is that S bit is turned on by appending '$' to a command.
This is in contrast to our provided sample format which turns on S bit by appending 'S'. (The change was made to resolve ambiguities with condition codes ending in 'S').