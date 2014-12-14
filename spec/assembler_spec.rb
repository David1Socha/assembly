require_relative '../lib/assembler'
require_relative './assembler_spec_helper'

describe "Assembler" do

  describe "#tokenize" do

    it "correctly tokenizes a comma-separated instruction" do
      comma_separated_instr = "ADDI,R2,R0,123"
      tokens = Assembly::Assembler.tokenize comma_separated_instr
      expect(tokens).to eq ["ADDI", "R2", "R0", "123"]
    end

    it "correctly tokenizes a right paren-separated instruction" do
      rp_instr = "ADDI)R2)R0)123"
      tokens = Assembly::Assembler.tokenize rp_instr
      expect(tokens).to eq ["ADDI", "R2", "R0", "123"]
    end

    it "correctly tokenizes a left paren-separated instruction" do
      lp_instr = "ADDI(R2(R0(123"
      tokens = Assembly::Assembler.tokenize lp_instr
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

    it "correctly tokenizes an instruction separated by a combination of spaces, commas, parens, and tabs" do
      instr = "SUB R3,R2\t(R3)"
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

    before(:each) do
      @assembler = Assembly::Assembler.new get_sample_lines
    end

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
        test_convert_binary(@assembler, get_cmp_tokens, "011100000000000100001110")
      end

      it "correctly converts jr tokens into binary" do
        test_convert_binary(@assembler, get_jr_tokens, "000000110000000000001101")
      end
      
    end

    describe "(J type)" do

      it "correctly converts jump tokens into binary" do
        test_convert_binary(@assembler, get_jump_tokens, "000000000000001110000000")
      end

      it "correctly converts jump tokens with label into binary" do
        expect(@assembler).to receive(:get_label_absolute).and_return "12"
        test_convert_binary(@assembler, get_jlabel_tokens, "000000000000000011000000")
      end

      it "correctly converts jump and link tokens into binary" do
        test_convert_binary(@assembler, get_jal_tokens, "000000000000001110000001")
      end

      it "correctly converts load immediate tokens into binary" do
        test_convert_binary(@assembler, get_loadi_tokens, "010000000000000001010010")
      end

    end


    describe "(D type)" do

      it "correctly converts addi tokens into binary" do
        test_convert_binary(@assembler, get_addi_tokens, "001101001110010000001010")
      end

      it "correctly converts load word tokens into binary" do
        test_convert_binary(@assembler, get_lw_tokens, "001001101111100000001000")
      end

      it "correctly converts store word tokens into binary" do
        test_convert_binary(@assembler, get_sw_tokens, "001001101111100000001001")
      end

    end

    describe "(B type)" do

      it "correctly converts branch tokens into binary" do
        test_convert_binary(@assembler, get_b_tokens, "000000000000111100000100")
      end

      it "correctly converts branch tokens with label into binary" do 
        expect(@assembler).to receive(:get_label_relative).and_return "2"
        test_convert_binary(@assembler, get_blabel_tokens, "000000000000001000000100", 2)
      end

      it "correctly converts branch and link tokens into binary" do
        test_convert_binary(@assembler, get_bal_tokens, "000000000000111100000101")
      end

    end

    describe "(Instruction Extensions)" do

      it "correctly adds S bit in binary" do
        test_convert_binary(@assembler, get_adds_tokens, "001000000100011100001100")
      end

      it "correctly adds AL cond in binary" do
        test_convert_binary(@assembler, get_addal_tokens, "001000000100011000001100")
      end

      it "correctly adds NV cond in binary" do
        test_convert_binary(@assembler, get_addnv_tokens, "001000000100011000011100")
      end

      it "correctly adds EQ cond in binary" do
        test_convert_binary(@assembler, get_addeq_tokens, "001000000100011000101100")
      end

      it "correctly adds NE cond in binary" do
        test_convert_binary(@assembler, get_addne_tokens, "001000000100011000111100")
      end

      it "correctly adds VS cond in binary" do
        test_convert_binary(@assembler, get_addvs_tokens, "001000000100011001001100")
      end

      it "correctly adds VC cond in binary" do
        test_convert_binary(@assembler, get_addvc_tokens, "001000000100011001011100")
      end

      it "correctly adds MI cond in binary" do
        test_convert_binary(@assembler, get_addmi_tokens, "001000000100011001101100")
      end

      it "correctly adds PL cond in binary" do
        test_convert_binary(@assembler, get_addpl_tokens, "001000000100011001111100")
      end

      it "correctly adds CS cond in binary" do
        test_convert_binary(@assembler, get_addcs_tokens, "001000000100011010001100")
      end

      it "correctly adds CC cond in binary" do
        test_convert_binary(@assembler, get_addcc_tokens, "001000000100011010011100")
      end

      it "correctly adds HI cond in binary" do
        test_convert_binary(@assembler, get_addhi_tokens, "001000000100011010101100")
      end

      it "correctly adds LS cond in binary" do
        test_convert_binary(@assembler, get_addls_tokens, "001000000100011010111100")
      end

      it "correctly adds GT cond in binary" do
        test_convert_binary(@assembler, get_addgt_tokens, "001000000100011011001100")
      end

      it "correctly adds LT cond in binary" do
        test_convert_binary(@assembler, get_addlt_tokens, "001000000100011011011100")
      end

      it "correctly adds GE cond in binary" do
        test_convert_binary(@assembler, get_addge_tokens, "001000000100011011101100")
      end

      it "correctly adds LE cond in binary" do
        test_convert_binary(@assembler, get_addle_tokens, "001000000100011011111100")
      end

    end

  end

  describe "#return_mif" do

    it "converts an array of tokenized lines into a mif-formatted string" do
      assembler = Assembly::Assembler.new ""
      expect(assembler).to receive(:tokenize_lines)
      expect(assembler).to receive(:tokenized_lines).twice.and_return([get_add_tokens,get_jump_tokens])
      expect(assembler.return_mif).to eq "WIDTH=24;\nDEPTH=1024;\n\nADDRESS_RADIX=UNS;\nDATA_RADIX=HEX;\n\nCONTENT BEGIN\n\t0 : 20460C;\n\t1 : 000380;\n\t[2..1023] : 000000;\nEND;\n"
    end

  end

  describe "#strip_comment" do

    it "does not change a line without comments" do
      original_line = "Addi r2, \tr0, -4 "
      expect(Assembly::Assembler.strip_comment original_line).to eq "Addi r2, \tr0, -4 "
    end

    it "removes comment from a line ending in '--'" do
      original_line = "Addi r2, \tr0, -4 --Sets r2 to -4"
      expect(Assembly::Assembler.strip_comment original_line).to eq "Addi r2, \tr0, -4 "
    end

  end

end