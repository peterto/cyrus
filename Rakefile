desc 'parses csv file'
namespace :sort do
  desc 'parse a csv file'
  task :csv do
    parse('comma.txt', ',')
  end

  desc 'parse a pipe delimited file'
  task :psv do
    parse('pipe.txt', '|')
  end
  
  desc 'parse a space delimited file'
  task :ssv do
    parse('space.txt', ' ')
  end
end

def parse(file, type)
  regex = "[#{type} ]+"
  unsortedFile = File.new(file, 'r')
  _string = String.new(unsortedFile.read)
  # regex = Regexp.new('(\w+[\d{1,4})\/[^,]]+)', Regexp::MULTILINE)
  regex = Regexp.new(regex)
  array = Array.new
  _string.each_line() do |line|
    puts "#{line}"
    array.push(line.split(regex))
    # p array
  end  
   p array
  # puts _string.split(type)
end

def sort(array)

end

