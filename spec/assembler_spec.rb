require_relative '../lib/assembler'
require_relative './assembler_spec_helper'

describe "Assembler" do
  
  before(:each) do
    @assembler = Assembly::Assembler.new get_sample_lines
  end

  describe "#tokenize" do

    it "correctly tokenizes a comma-separated instruction" do
      comma_separated_instr = "ADDI,R2,R0,123"
      tokens = Assembly::Assembler.tokenize comma_separated_instr
      expect(tokens).to eq ["ADDI", "R2", "R0", "123"]
    end

    it "correctly tokenizes a tab-separated instruction" do
      tab_separated_instr = "ADDI\tR5\tR7\t99"
      tokens = Assembly::Assembler.tokenize tab_separated_instr
      expect(tokens).to eq ["ADDI", "R5", "R7", "99"]
    end

    it "correctly tokenizes a space-separated instruction" do
      space_separated_instr = "SUB R5 R7 R9"
      tokens = Assembly::Assembler.tokenize space_separated_instr
      expect(tokens).to eq ["SUB", "R5", "R7", "R9"]
    end

    it "ignores redundant delimeters" do
      instr = "  SUB           R3 R2   R3  "
      tokens = Assembly::Assembler.tokenize instr
      expect(tokens).to eq ["SUB", "R3", "R2", "R3"]
    end

    it "correctly tokenizes an instruction separated by a combination of spaces, commas, and tabs" do
      instr = "SUB R3,R2\tR3"
      tokens = Assembly::Assembler.tokenize instr
      expect(tokens).to eq ["SUB", "R3", "R2", "R3"]
    end

    it "capitalizes all letters in each token" do
      lowercase_instr = "sub,r2,r3,r4"
      tokens = Assembly::Assembler.tokenize lowercase_instr
      expect(tokens).to eq ["SUB", "R2", "R3", "R4"]
    end

  end

  describe "#convert_binary" do

    describe "(R type)" do

      it "correctly converts add tokens into binary" do
        test_convert_binary(@assembler, get_add_tokens, "001000000100011000001100")
      end

      it "correctly converts sub tokens into binary" do
        test_convert_binary(@assembler, get_sub_tokens, "001000100010100000001100")
      end

      it "correctly converts and tokens into binary" do
        test_convert_binary(@assembler, get_and_tokens, "010101111001000000001100")
      end

      it "correctly converts xor tokens into binary" do
        test_convert_binary(@assembler, get_xor_tokens, "010101111001010000001100")
      end

      it "correctly converts or tokens into binary" do
        test_convert_binary(@assembler, get_or_tokens, "010101111001001000001100")
      end

      it "correctly converts sll tokens into binary" do
        test_convert_binary(@assembler, get_sll_tokens, "010000110010000000001111")
      end

      it "correctly converts cmp tokens into binary" do
        test_convert_binary(@assembler, get_cmp_tokens, "011100000000000000001110")
      end

    end

    describe "(J type)" do

      it "correctly converts jump tokens into binary" do
        test_convert_binary(@assembler, get_jump_tokens, "000000000000001110000000")
      end

      it "correctly converts jump and link tokens into binary" do
        test_convert_binary(@assembler, get_jal_tokens, "000000000000001110000001")
      end

      it "correctly converts load immediate tokens into binary" do
        test_convert_binary(@assembler, get_loadi_tokens, "010000000000000001010010")
      end

    end

  end

  describe "#convert_hex" do

    describe "(R type)" do

      it "correctly converts add tokens into hex" do
        test_convert_hex(@assembler, get_add_tokens, "20460c")
      end

      it "correctly converts sub tokens into hex" do
        test_convert_hex(@assembler, get_sub_tokens, "22280c")
      end

      it "correctly converts add tokens into hex" do
        test_convert_hex(@assembler, get_and_tokens, "57900c")
      end

      it "correctly converts xor tokens into hex" do
        test_convert_hex(@assembler, get_xor_tokens, "57940c")
      end

      it "correctly converts or tokens into hex" do
        test_convert_hex(@assembler, get_or_tokens, "57920c")
      end

      it "correctly converts sll tokens into hex" do
        test_convert_hex(@assembler, get_sll_tokens, "43200f")
      end

      it "correctly converts cmp tokens into hex" do
        test_convert_hex(@assembler, get_cmp_tokens, "70000e")
      end

    end

    describe "(J type)" do

      it "correctly converts jump tokens into hex" do
        test_convert_hex(@assembler, get_jump_tokens, "000380")
      end

      it "correctly converts jump and link tokens into hex" do
        test_convert_hex(@assembler, get_jal_tokens, "000381")
      end

      it "correctly converts load immediate tokens into hex" do
        test_convert_hex(@assembler, get_loadi_tokens, "400052")
      end

    end

  end
end