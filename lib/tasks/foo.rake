desc 'parses file'
namespace :sort do
  desc 'parse a csv file'
  task :csv do
    normalize_csv(parse('comma.txt', ','))
  end

  desc 'parse a pipe delimited file'
  task :psv do
    normalize_psv(parse('pipe.txt', '|'))
    # parse('pipe.txt', '|')
  end

  desc 'parse a space delimited file'
  task :ssv do
    normalize_ssv(parse('space.txt', ' '))
    # parse('space.txt', ' ')
  end

  desc 'parses all the files'
  task :all => [:csv, :psv, :ssv]

  desc 'combines of all files'
  task :combine do
    combine(normalize(parse('comma.txt', ','), "c"), normalize(parse('pipe.txt', '|'), "p"), normalize(parse('space.txt', ' '), "s"))
  end

  desc 'normalize data in the array to get it ready to output'
  task :normalize do
    normalize(array)
  end
end

def normalize(array, delimiter)
  array.each do |s|
    s.each do |t|
      t.gsub!("-", "/")
      t.gsub!("\n", "")
    end
    if delimiter == "p"
      s.push(s.slice!(4))
    end

    if delimiter == "p" || delimiter == "s"
     if s[3] == "F"
       s[3] = "Female"
      elsif s[3] == "M"
        s[3] = "Male"
      end
      s.delete_at(2)
    elsif delimiter == "c"
      s.push(s.slice!(3))
    end
  end
  return array
end

def combine(array1, array2, array3)
  array = Array.new
  array1.each do |s|
    array.push(s)
  end

  array2.each do |s|
    array.push(s)
  end

  array3.each do |s|
    array.push(s)
  end

  sort(array, 1)
  p 'Output 1'
  array.each do |s|
    p s
  end

  sort(array, 3)
  p 'Output 2'
  array.each do |s|
    p s
  end

  sort(array, 2)
  p 'Output 3'
  array.each do |s|
    p s
  end
end

def parse(file, type)
  regex = %r"[#{type} ]+"
  unsortedFile = File.new(file, 'r')
  _string = String.new(unsortedFile.read)
  array = Array.new
  _string.each_line() do |line|
    array.push(line.split(regex))
  end
  return array
end

def sort(array, type)
  if type == 1
    array.sort_by! do |x|
      [x[2],x[0]]
    end
  else
    array.sort! do |x, y|
      if type == 3
        Date::strptime(x[3], '%m/%d/%Y') <=> Date::strptime(y[3], '%m/%d/%Y')
      elsif type == 2
        y[0] <=> x[0]
      end
    end
  end
end

