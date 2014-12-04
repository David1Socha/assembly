require_relative './codes'

module Assembly
  
  class DInstruction
    attr_accessor :cond, :opcode, :regT, :regS, :s, :immediate, :command

    def initialize(command)
      @command = command
    end

    def self.type
      return :D
    end

    def to_binary
      return "000000000000000000000000"
    end

    def to_hex
      return "000000"
    end

  end
end

