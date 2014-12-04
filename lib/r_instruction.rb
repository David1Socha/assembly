require_relative './codes'

module Assembly
  
  class RInstruction
    attr_accessor :cond, :opcode, :regT, :regD, :regS, :opx, :s, :command

    def initialize(command)
      @command = command
    end

    def self.type
      return :R
    end

    def to_binary
      return "000000000000000000000000"
    end

    def to_hex
      return "000000"
    end

    def ==(other)
      same_cond = @cond == other.cond
      same_opcode = @opcode == other.opcode
      same_regT = @regT == other.regT
      same_regD = @regD == other.regD
      same_regS = @regS == other.regS
      same_opx = @opx == other.opx
      same_s = @s == other.s
      same_command = @command == other.command
      return same_command && same_s && same_opx && same_opcode && same_cond && same_regS && same_regD && same_regT
    end

  end
end

