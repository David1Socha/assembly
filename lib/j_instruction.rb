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
      return [const, opcode].join
    end
    
    def to_hex
      binary_groups = to_binary.scan(/..../)
      return binary_groups.map{ |binary| RInstruction.hex(binary)}.join
    end

    def self.hex(binary)
      return binary.to_i(2).to_s(16)
    end

  end
end

