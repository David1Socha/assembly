require_relative './codes'
require_relative './instruction'

module Assembly
  
  class JInstruction < Instruction
    attr_accessor :opcode, :const, :command

    def initialize(const, opcode, command)
      @const = const
      @opcode = opcode
      @command = command
    end

    def self.type
      return :J
    end

    def to_binary
      return [const, opcode].join
    end

  end
end

