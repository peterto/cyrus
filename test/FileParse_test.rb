require_relative 'test_helper'

class FileParseTest < Test::Unit::TestCase

  def setup
    @comma = FileParse.parse('comma.txt')
    @pipe = FileParse.parse('pipe.txt')
    @space = FileParse.parse('space.txt')
    if File.exists?('output.txt')
      File.delete('output.txt')
    end
  end

  def test_parse_file
    setup
    assert_instance_of(Array, @comma, '@comma is not an array')
    assert_instance_of(Array, @pipe, '@pipe is not an array')
    assert_instance_of(Array, @space, '@space is not an array')
  end

  def test_normalize_array
    setup
    @comma = FileParse.normalize(@comma, 'c')
    @pipe = FileParse.normalize(@pipe, 'p')
    @space = FileParse.normalize(@space, 's')

    assert_equal(@comma.length, 3)
    assert_equal(@pipe.length, 3)
    assert_equal(@space.length, 3)
    assert_instance_of(Array, @comma, '@comma is not an array')
    assert_instance_of(Array, @pipe, '@pipe is not an array')
    assert_instance_of(Array, @space, '@space is not an array')
  end

  def test_combine_arrays
    test_normalize_array
    @array = Array.new
    @array.push(@comma).push(@pipe).push(@space)
    @array = FileParse.combine(@array)

    assert_instance_of(Array, @array, 'array is not an array')
    assert_equal(@array.length, 9)
  end

  def test_sort_array
    test_combine_arrays 
    array_temp = Array.new(@array)
    array_sorted = Array.new
    array_sorted = FileParse.sort(@array, 2)
    
    assert_not_equal(array_temp, array_sorted)
  end

  def test_output_file
    test_sort_array
    (1..3).each do |t|
      FileParse.output(@array, t)
    end

    assert(File.exists?('output.txt'), 'output.txt does not exists')
  end

  def teardown
    @comma = nil
    @pipe = nil
    @space = nil
    @array = nil
    if File.exists?('output.txt')
      File.delete('output.txt')
    end
  end
end
