# frozen_string_literal: true

class CommandParser
  attr_reader :all_directories

  def initialize(root, lines)
    @current_dir = root
    @root_directory = root
    @all_directories = [root]
    @commands = lines
  end

  def parse
    while @commands.length.positive?
      current_command = @commands.shift
      parse_command(current_command)
    end
  end

  private

  def parse_command(line)
    puts line
    case line
    when /\$ cd (?<dir>.*)/
      parse_directory(Regexp.last_match(1))
    when /\$ ls/
      parse_ls
    else
      puts "Tried matching #{line}"
    end
  end

  def parse_directory(dir)
    case dir
    when %r{/}
      @current_dir = @root_directory
    when /\.\./
      @current_dir = @current_dir.go_up_directory
    when /(.*)/
      @current_dir = @current_dir.go_down_directory(Regexp.last_match(1))
    end
  end

  def parse_ls
    directory_contents = []
    directory_contents << @commands.shift while !@commands.length.zero? && @commands[0][0] != '$'
    return unless @current_dir.files.count.zero? && @current_dir.subdirectories.count.zero?

    directory_contents.each do |dir_item|
      case dir_item
      when /(\d+) (.*)/
        @current_dir.add_file(FileRep.new(Regexp.last_match(2), Regexp.last_match(1).to_i))
      when /dir (.*)/
        new_dir = Directory.new(Regexp.last_match(1), @current_dir)
        @current_dir.add_directory(new_dir)
        @all_directories << new_dir
      end
    end
  end
end
