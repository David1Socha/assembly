require_relative './codes'

module Assembly
  
  class JInstruction
    attr_accessor :opcode, :const, :command

    def initialize(command)
      @command = command
    end

    def self.type
      return :J
    end

    def to_binary
      return "000000000000000000000000"
    end

    def to_hex
      return "000000"
    end

  end
end

