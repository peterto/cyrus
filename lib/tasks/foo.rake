desc 'parses csv file'
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
    combine(normalize_csv(parse('comma.txt', ',')), normalize_psv(parse('pipe.txt', '|')), normalize_ssv(parse('space.txt', ' ')))
  end
  
  desc 'normalize data in the array to get it ready to output'
  task :normalize do
    normalize(array)
  end
end

def normalize_csv(array)
  array.each do |s|
    s.each do |t|
      t.gsub!("-", "/")
      t.gsub!("\n", "")
    end
    s.push(s.slice!(3))
  end
  # p array
  return array
end

def normalize_psv(array)
  array.each do |s|
    s.each do |t|
      t.gsub!("-", "/")
      t.gsub!("\n", "")
    end
    s.push(s.slice!(4))
    s[3]
    if s[3] == "F"
      s[3] = "Female"
    elsif s[3] == "M"
      s[3] = "Male"
    end
    s.delete_at(2)
  end
  # p array
  return array
end

def normalize_ssv(array)
  array.each do |s|
    s.each do |t|
      t.gsub!("-", "/")
      t.gsub!("\n", "")
    end
    s[3]
    if s[3] == "F"
      s[3] = "Female"
    elsif s[3] == "M"
      s[3] = "Male"
    end
    s.delete_at(2)
  end
  # p array
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
  
  array = sort(array)
  # p array
  p 'sort one '
  array.each do |s|
    p s
  end

  array = sortTaskTwo(array)
  # p array
  p 'sort two '
  array.each do |s|
    p s
  end

  array = sortTaskThree(array)
  p 'sort three '
  array.each do |s|
    p s
  end
end

def parse(file, type)
  regex = "[#{type} ]+"
  unsortedFile = File.new(file, 'r')
  _string = String.new(unsortedFile.read)
  regex = Regexp.new(regex)
  array = Array.new
  _string.each_line() do |line|
    # puts "#{line}"
    array.push(line.split(regex))
  end  
  # p array
  array = sort(array)
  return array
end

def sort(array)
  array.sort_by! do |x|
    [x[2],x[0]]
  end
  # p array
end

def sortTaskTwo(array)
  array.sort! do |x, y|
    y[0] <=> x[0]
  end
end

def sortTaskThree(array)
  array.sort! do |x, y|
    Date::strptime(x[3], '%m/%d/%Y') <=> Date::strptime(y[3], '%m/%d/%Y')
  end
end
