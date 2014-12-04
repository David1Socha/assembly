require_relative './codes'

module Assembly
  
  class RInstruction
    attr_accessor :cond, :opcode, :regT, :regD, :regS, :opx, :S, :command

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

  end
end

