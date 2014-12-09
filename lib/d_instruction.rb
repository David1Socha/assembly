require_relative './codes'
require_relative './instruction'

module Assembly
  
  class DInstruction < Instruction
    attr_accessor :cond, :opcode, :regT, :regS, :s, :immediate, :command

    def initialize(cond, opcode, regT, regS, s, immediate, command)
      @cond = cond
      @opcode = opcode
      @regT = regT
      @regS = regS
      @s = s
      @immediate = immediate
      @command = command
    end

    def self.type
      return :D
    end

    def to_binary
      return [regT, regS, immediate, s, cond, opcode].join
    end

  end
end

