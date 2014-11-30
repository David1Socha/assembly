require_relative './codes'

module Assembly
  
  class Instruction
    attr_accessor :cond, :opcode, :type, :regT, :regD, :regS, :opx, :S, :immediate, :label, :const, :command

    def initialize(command)
      @command = command
      strip_cond
      @opcode = OPCODES[@command]
      @type = TYPES[@opcode]scan(/pattern/) { |match|  }
    end

    def strip_cond
      command_prefix = @command[-2..-1]
      if CONDS.has_key? command_prefix
        @cond = @command_prefix
        @command = @command[0..-3]
      else
        @cond = DEFAULT_COND
      end
    end

    def to_binary
      return "000000000000000000000000"
    end

    def to_hex
      return "000000"
    end

  end
end

