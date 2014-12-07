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
        binary_form = @assembler.convert_binary get_add_tokens
        expect(binary_form).to eq("001000000100011000001100")
      end

    end

    describe "(J type)" do

      it "correctly converts jump tokens into binary" do
        binary_form = @assembler.convert_binary get_jump_tokens
        expect(binary_form).to eq("000000000000001110000000")
      end

    end

  end

  describe "#convert_hex" do

    describe "(R type)" do

      it "correctly converts add tokens into hex" do
        hex_form = @assembler.convert_hex get_add_tokens
        expect(hex_form).to eq("20460c")
      end

    end

    describe "(J type)" do

      it "correctly converts jump tokens into binary" do
        hex_form = @assembler.convert_hex get_jump_tokens
        expect(hex_form).to eq("000380")
      end
      
    end

  end
end