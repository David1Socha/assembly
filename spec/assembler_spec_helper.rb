def get_sample_lines
  "Add r2, r0, r4\nj 56\njal 56\nli r4, 5\nAND r5, r7, r9\nXOR r5, r7, r9\nOR r5, r7, r9\nSLL R4, R3, R2\nCMP r7 r0\njr r3\nlw r2 (-4)r6\nsw r2 (-4)r6\naddi r3 r4 -14\nb 15\nbal 15\nAdd$ r2, r0, r4\naddal r2, r0, r4\naddnv r2, r0, r4\naddeq r2, r0, r4\naddne r2, r0, r4\naddvs r2, r0, r4\n"
end

def get_addvs_tokens
  ["ADDVS", "R2", "R0", "R4"]
end

def get_addne_tokens
  ["ADDNE", "R2", "R0", "R4"]
end

def get_addeq_tokens
  ["ADDEQ", "R2", "R0", "R4"]
end

def get_addnv_tokens
  ["ADDNV", "R2", "R0", "R4"]
end

def get_b_tokens
  ["B", "15"]
end

def get_bal_tokens
  ["BAL", "15"]
end

def get_add_tokens
  ["ADD", "R2", "R0", "R4"]
end

def get_addal_tokens
  ["ADDAL", "R2", "R0", "R4"]
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

def get_lw_tokens
  ["LW", "R2", "-4", "R6"]
end

def get_sw_tokens
  ["SW", "R2", "-4", "R6"]
end

def get_addi_tokens
  ["ADDI", "R3", "R4", "-14"]
end

def get_adds_tokens
  ["ADD$", "R2", "R0", "R4"]
end

def test_convert_binary(assembler, tokens, expected_binary_form)
  binary_form = assembler.convert_binary tokens
  expect(binary_form).to eq(expected_binary_form)
end