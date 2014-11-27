require_relative '../lib/assembler'
require_relative './assembler_spec_helper'

describe "Assembler" do
  
  before(:each) do
    @assembler = Assembly::Assembler.new get_sample_lines
  end

  describe "convert_hex" do

    it "correctly converts add instructions into hex" do
      hex_form = @assembler.convert_hex ["Add", "r2", "r0", "r4"]
      expect(hex_form).to eq("20460A")
    end

  end
end