require_relative './opcodes'

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
      instruction = tokens.first.upcase
      opcode = OPCODES[instruction]
      
    end

  end
  
end