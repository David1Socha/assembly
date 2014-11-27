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
        asdf
      elsif instruction.type == :B
        asdf
      elsif instruction.type == :D
        asdf
      else
        asdf
      end
      return instruction.to_hex
    end

  end
  
end