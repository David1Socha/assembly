require_relative './codes'
require_relative './instruction'

module Assembly
  
  class BInstruction < Instruction
    attr_accessor :cond, :opcode, :label, :command

    def initialize(command)
      @command = command
    end

    def self.type
      return :R
    end

    def to_binary
      return "000000000000000000000000"
    end

  end
end

