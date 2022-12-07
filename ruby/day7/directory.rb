# frozen_string_literal: true

require_relative 'file'

class Directory
  attr_reader :parent, :subdirectories, :files, :name

  def initialize(name, parent)
    @name = name
    @parent = parent.nil? ? self : parent
    @subdirectories = {}
    @files = []
  end

  def go_up_directory
    @parent
  end

  def go_down_directory(name)
    @subdirectories[name]
  end

  def get_directory_size
    @directory_size ||= get_subdirectories_size + get_file_size
  end

  def get_file_size
    return 0 if @files.size.zero?

    files.inject(0) { |sum, file| sum + file.size }
  end

  def get_subdirectories_size
    return 0 if @subdirectories.length.zero?

    subdirectories.inject(0) { |sum, subdirectory| sum + subdirectory.last.get_directory_size }
  end

  def add_file(file)
    @files << file
  end

  def add_directory(dir)
    @subdirectories[dir.name] = dir
  end
end
