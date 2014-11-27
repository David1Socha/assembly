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
      if CONDS.has_key? command[-2..-1]
        cond = command[-2..-1]
        command = command[0..-3]
      else
        cond = CONDS["AL"]
      end
      opcode = OPCODES[command]
      type = TYPES[opcode]
    end

  end
  
end