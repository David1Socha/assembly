require_relative './codes'

module Assembly
  
  class RInstruction
    attr_accessor :cond, :opcode, :regT, :regD, :regS, :opx, :s, :command

    def initialize(regT, regS, regD, opx, s, cond, opcode, command)
      @regT = regT
      @regS = regS
      @regD = regD
      @opx = opx
      @s = s
      @opcode = opcode
      @command = command
      @cond = cond
    end

    def self.type
      return :R
    end

    def to_binary
      return [regT, regS, regD, opx, s, cond, opcode].join
    end

    def to_hex
      binary_groups = to_binary.scan(/..../)
      return binary_groups.map{ |binary| RInstruction.hex(binary)}.join
    end

    def self.hex(binary)
      return binary.to_i(2).to_s(16)
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

