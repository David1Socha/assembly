module Assembly

  class Assembler

    def initialize(source_lines)
      @source_lines = source_lines
    end

    def tokenize_lines
      @tokenized_lines = @source_lines.map do |line| 
        tokenize(line) #TODO get label first?
      end
    end

    def tokenize(line)
      line.tr_s("\\\t ",',').split(',').delete_if(&:empty?)
    end

  end
  
end