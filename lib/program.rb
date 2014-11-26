require_relative './assembler.rb'

module Assembly
  class Program
    def get_source_file
      @source_file = ARGV.empty? ? prompt_source_file : ARGV.first 
    end

    def prompt_source_file
      print "Enter source file: "
      gets.chomp
    end

    def read_source_lines
      @source_lines = IO.readlines @source_file
    end

    def get_output_file
      @output_file = ARGV.size < 2 ? prompt_output_file : ARGV[1]
    end 

    def prompt_output_file
      print "Enter output file: "
      gets.chomp
    end

    def run
      get_source_file
      read_source_lines
      get_output_file
      puts @output_file
    rescue => e
      puts "Sorry, an error has occured."
      puts e.backtrace
    end
  end

end

