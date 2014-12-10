require_relative './assembler.rb'

module Assembly
  class Program

    OUTPUT_DIR = "output"

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
      assembler = Assembly::Assembler.new @source_lines
      mif = assembler.return_mif
      Dir.mkdir(OUTPUT_DIR) unless File.exists? OUTPUT_DIR
      File.open("#{OUTPUT_DIR}/#{@output_file}", "w") do |file|
        file.print mif
      end
      puts "File successfully assembled! Can be found in #{OUTPUT_DIR}/#{@output_file}"
    rescue => e
      puts "Sorry, an error has occured."
      puts e.backtrace
    end
  end

end

