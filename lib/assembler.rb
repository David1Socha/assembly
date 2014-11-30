require_relative './codes'

module Assembly

  class Assembler

    def initialize(source_lines)
      @source_lines = source_lines
    end

    def tokenize_lines
      @tokenized_lines = @source_lines.map do |line| 
        tokenize(line) #TODO get label first?
      end
    end

    def tokenize(line)
      line.tr_s("\\\t ",',').split(',').delete_if(&:empty?)
    end

    def convert_hex(tokens)
      command = tokens.first.upcase
      instruction = Instruction.new command
      if instruction.type == :R
        build_r instruction
      elsif instruction.type == :B
        asdf
      elsif instruction.type == :D
        asdf
      else
        asdf
      end
      return instruction.to_hex
    end

    def build_r(instr, tokens)
      instr.regT = tokens[1].to_i(2).to_s
      instr.regS = tokens[2].to_i(2).to_s
      instr.regD = tokens[3].to_i(2).to_s
      instr.opx = OPX[instr.command]
    end

  end
  
end