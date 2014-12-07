require_relative './codes'
require_relative './r_instruction'
require_relative './j_instruction'
require_relative './d_instruction'
require_relative './b_instruction'

module Assembly

  DEFAULT_COND_NAME = "AL"
  REGISTER_BITS = 4
  CONST_BITS = 20

  class Assembler

    def initialize(source_lines)
      @source_lines = source_lines
    end

    def tokenize_lines
      @tokenized_lines = @source_lines.map do |line| 
        tokenize(line) #TODO get label first?
      end
    end

    def self.tokenize(line)
      line.upcase.tr_s("\\\t ",',').split(',').delete_if(&:empty?)
    end

    def self.determine_type_cond(command)
      type = TYPES[command]
      unless type.nil?
        cond = CONDS[DEFAULT_COND_NAME]
        return type, cond, command
      else
        cond_name = command[-2..-1]
        command = command[0...-2]
        type = TYPES[command]
        cond =CONDS[cond_name]
        return type, cond, command
      end
    end

    def self.to_binary_str(num_bits, decimal)
      formatter = "%0#{num_bits}b"
      binary_str = formatter % decimal
    end

    def convert_hex(tokens)
      instr = build_instruction tokens
      instr.to_hex
    end

    def convert_binary(tokens)
      instr = build_instruction tokens
      instr.to_binary
    end

    def build_r_instruction(command, cond, tokens)
      regT_dec = tokens[0][1..-1]
      regS_dec = tokens[1][1..-1]
      regD_dec = tokens[2][1..-1]
      regT = Assembler.to_binary_str(REGISTER_BITS, regT_dec)
      regS = Assembler.to_binary_str(REGISTER_BITS, regS_dec)
      regD = Assembler.to_binary_str(REGISTER_BITS, regD_dec)
      opx = OPX[command]
      s = S_SET_COMMANDS.include?(command) ? "1" : "0"
      opcode = OPCODES[command]
      r_instr = RInstruction.new(regT, regS, regD, opx, s, cond, opcode, command)
    end

    def build_j_instruction(command, tokens)
      const_dec = tokens.first
      const = Assembler.to_binary_str(CONST_BITS, const_dec)
      opcode = OPCODES[command]
      j_instr = JInstruction.new(const, opcode, command)
    end

    def build_instruction(tokens)
      command = tokens.shift
      type, cond, command = Assembler.determine_type_cond command
      puts "here", type
      case type
      when :R
        instruction = build_r_instruction(command, cond, tokens)
      when :D
        instruction = DInstruction.new(command, cond)
      when :B
        instruction = BInstruction.new(command, cond)
      when :J
        instruction = build_j_instruction(command, tokens)
      end
      return instruction
    end

  end
  
end