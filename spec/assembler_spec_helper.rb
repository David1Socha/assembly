def get_sample_lines
  "Add r2, r0, r4\nj 56\njal 56\nli r4, 5"
end

def get_add_tokens
  ["ADD", "R2", "R0", "R4"]
end

def get_jump_tokens
  ["J", "56"]
end

def get_jal_tokens
  ["JAL", "56"]
end

def get_loadi_tokens
  ["LI", "R4", "5"]
end

def get_sub_tokens
  ["SUB", "R2", "R2", "R2"]
end

def get_and_tokens
  ["AND", "R5", "R7", "R9"]
end

def get_xor_tokens
  ["XOR", "R5", "R7", "R9"]
end

def get_or_tokens
  ["OR", "R5", "R7", "R9"]
end

def get_sll_tokens
  ["SLL", "R4", "R3", "R2"]
end

def get_cmp_tokens
  ["CMP", "R7", "R0"]
end

def get_jr_tokens
  ["JR", "R3"]
end

def test_convert_hex(assembler, tokens, expected_hex_form)
  hex_form = assembler.convert_hex tokens
  expect(hex_form).to eq(expected_hex_form)
end

def test_convert_binary(asssembler, tokens, expected_binary_form)
  binary_form = assembler.convert_binary tokens
  expect(binary_form).to eq(expected_binary_form)
end