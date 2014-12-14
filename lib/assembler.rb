require_relative './codes'
require_relative './r_instruction'
require_relative './j_instruction'
require_relative './d_instruction'
require_relative './b_instruction'

module Assembly

  DEFAULT_COND_NAME = "AL"
  REGISTER_BITS = 4
  CONST_BITS = 20
  CONST_16_BITS = 16
  DTYPE_IMMED_BITS = 7
  DEFAULT_WIDTH = "24"
  DEFAULT_DEPTH = "1024"
  DEFAULT_ADDR_RADIX = "UNS"
  DEFAULT_DATA_RADIX = "HEX"
  LABEL_BITS = 16

  class Assembler

    attr_reader :tokenized_lines

    def initialize(source_lines)
      @source_lines = source_lines
      @labels = Hash.new
    end

    def get_mif_header(width, depth, address_radix, data_radix)
      "WIDTH=#{width};\nDEPTH=#{depth};\n\nADDRESS_RADIX=#{address_radix};\nDATA_RADIX=#{data_radix};\n\nCONTENT BEGIN\n"
    end

    def get_mif_footer
      "END;\n"
    end

    def get_label_absolute(label)
      label_abs = @labels[label]
    end

    def return_mif(width = DEFAULT_WIDTH, depth = DEFAULT_DEPTH, address_radix = DEFAULT_ADDR_RADIX, data_radix = DEFAULT_DATA_RADIX)
      tokenize_lines
      save_labels
      mif_lines = Array.new
      mif_lines << get_mif_header(width, depth, address_radix, data_radix)
      depth_i = depth.to_i
      counter = 0
      if (data_radix == "HEX")
        tokenized_lines.each_with_index do |tokens, i|
          hex = convert_hex(tokens, i).upcase
          line = "\t#{counter} : #{hex};\n"
          counter += 1
          raise "Too many lines" if counter >= depth_i
          mif_lines << line
        end
      elsif (data_radix == "BIN")
        tokenized_lines.each_with_index do |tokens, i|
          bin = convert_binary(tokens, i).upcase
          line = "\t#{counter} : #{bin};\n"
          counter += 1
          raise "Too many lines" if counter >= depth_i
          mif_lines << line
        end
      end
      if (counter < depth_i)
        padding_line = "\t[#{counter}..#{depth_i-1}] : 000000;\n"
        mif_lines << padding_line
      end
      mif_lines << get_mif_footer
      mif_formatted_text = mif_lines.join
    end

    def save_labels
      tokenized_lines.each_with_index do |tokens, i|
        first_token = tokens.first
        if first_token.include? ":" #if line has label
          first_token = first_token[0..-2]
          @labels[first_token] = i #save label in map
          tokens.shift #remove label from tokens
        end
      end
    end

    def tokenize_lines
      @tokenized_lines = @source_lines.map do |line| 
        uncommented_line = Assembler.strip_comment line
        Assembler.tokenize(uncommented_line)
      end
      @tokenized_lines.delete_if(&:empty?)
    end

    def self.strip_comment(line)
      comment_index = line.index('--')
      uncommented_line = comment_index.nil? ? line : line[0...comment_index]
    end

    def self.tokenize(line)
      line.upcase.tr_s("\\\t\\\n ()",',').split(',').delete_if(&:empty?)
    end

    def self.trim_extensions(command)
      if command[-1] == "$" #dollar sign is our shortcut for s bit being set
        command = command[0...-1]
        s = "1"
      else
        s = (S_ALWAYS_SET_COMMANDS.include?(command) || S_ALWAYS_SET_COMMANDS.include?(command[0...-2])) ? "1" : "0"
      end
      type = TYPES[command]
      unless type.nil?
        cond = CONDS[DEFAULT_COND_NAME]
        return type, cond, command, s
      else
        cond_name = command[-2..-1]
        command = command[0...-2]
        type = TYPES[command]
        cond =CONDS[cond_name]
        return type, cond, command, s
      end
    end

    def self.to_binary_str(num_bits, decimal)
      negative = decimal.to_i < 0
      num_bits = num_bits + 2 if negative
      formatter = "%0#{num_bits}b"
      binary_str = formatter % decimal
      if negative
        return binary_str[2..-1] #remove leading dots from a negative number
      else
        return binary_str
      end
    end

    def convert_hex(tokens, current_instruction = 0)
      instr = build_instruction(tokens, current_instruction)
      hex_instr = instr.to_hex
    end

    def convert_binary(tokens, current_instruction = 0)
      instr = build_instruction(tokens, current_instruction)
      binary_instr = instr.to_binary
    end

    def build_r_instruction(command, cond, s, tokens)
      if (command == "JR")
        regT_dec = "0"
        regS_dec = tokens[1][1..-1]
      else
        regT_dec = tokens[1][1..-1]
        regS_dec = tokens[2][1..-1]
      end
      if (command == "CMP" || command == "JR")
        regD_dec = "0"
      else
        regD_dec = tokens[3][1..-1]
      end
      regT = Assembler.to_binary_str(REGISTER_BITS, regT_dec)
      regS = Assembler.to_binary_str(REGISTER_BITS, regS_dec)
      regD = Assembler.to_binary_str(REGISTER_BITS, regD_dec)
      opx = OPX[command]
      opcode = OPCODES[command]
      r_instr = RInstruction.new(regT, regS, regD, opx, s, cond, opcode, command)
    end

    def build_j_instruction(command, tokens)
      if (command == "LI")
        target_reg_dec = tokens[1][1..-1]
        const_16_dec = tokens[2]
        target_reg = Assembler.to_binary_str(REGISTER_BITS, target_reg_dec)
        const_16 = Assembler.to_binary_str(CONST_16_BITS, const_16_dec)
        const = target_reg + const_16
      else
        jump_target = tokens[1]
        if jump_target.to_i.to_s != jump_target #token is a string
          const_dec = get_label_absolute(jump_target).to_s
        else #token is already a number
          const_dec = jump_target
        end
        const = Assembler.to_binary_str(CONST_BITS, const_dec)
      end
      
      opcode = OPCODES[command]
      j_instr = JInstruction.new(const, opcode, command)
    end

    def build_d_instruction(command, cond, s, tokens)
      regT_dec = tokens[1][1..-1]
      unless (command == "ADDI")
        immed_dec = tokens[2]
        regS_dec = tokens[3][1..-1]
      else
        regS_dec = tokens[2][1..-1]
        immed_dec = tokens[3]
      end
      regT = Assembler.to_binary_str(REGISTER_BITS, regT_dec)
      regS = Assembler.to_binary_str(REGISTER_BITS, regS_dec)
      immed = Assembler.to_binary_str(DTYPE_IMMED_BITS, immed_dec)
      opcode = OPCODES[command]
      d_instr = DInstruction.new(cond, opcode, regT, regS, s, immed, command)
    end

    def get_label_relative(current_index, label)
      label_index = @labels[label]
      relative_dist = label_index - current_index - 1
      return relative_dist.to_s
    end

    def build_b_instruction(command, cond, tokens, current_instruction)
      label_dec = tokens[1]
      if label_dec.to_i.to_s != label_dec #label is string
        label_dec = get_label_relative(current_instruction, label_dec)
      end
      label = Assembler.to_binary_str(LABEL_BITS, label_dec)
      opcode = OPCODES[command]
      b_instr = BInstruction.new(cond, opcode, label, command)
    end

    def build_instruction(tokens, current_instruction)
      command = tokens[0]
      type, cond, command, s = Assembler.trim_extensions command
      case type
      when :R
        instruction = build_r_instruction(command, cond, s, tokens)
      when :D
        instruction = build_d_instruction(command, cond, s, tokens)
      when :B
        instruction = build_b_instruction(command, cond, tokens, current_instruction)
      when :J
        instruction = build_j_instruction(command, tokens)
      end
      return instruction
    end

  end
  
end