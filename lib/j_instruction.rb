require_relative './codes'
require_relative './instruction'

module Assembly
  
  class JInstruction < Instruction
    attr_accessor :opcode, :const, :command

    def initialize(command, const, opcode)
      @command = command
      @const = const
      @opcode = opcode
    end

    def self.type
      return :J
    end

    def to_binary
      return [const, opcode].join
    end

  end
end

