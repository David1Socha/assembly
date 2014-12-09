require_relative './codes'
require_relative './instruction'

module Assembly
  
  class BInstruction < Instruction
    attr_accessor :cond, :opcode, :label, :command

    def initialize(cond, opcode, label, command)
      @cond = cond
      @opcode = opcode
      @label = label
      @command = command
    end

    def self.type
      return :B
    end

    def to_binary
      return [label, cond, opcode].join
    end

  end
end

