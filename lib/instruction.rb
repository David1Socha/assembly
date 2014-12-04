require_relative './codes'

module Assembly
  
  class Instruction

    def to_hex
      binary_groups = to_binary.scan(/..../)
      return binary_groups.map{ |binary| RInstruction.hex(binary)}.join
    end

    def self.hex(binary)
      return binary.to_i(2).to_s(16)
    end

  end
end

