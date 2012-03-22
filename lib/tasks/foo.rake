desc 'parses file'
namespace :sort do
  desc 'combines of all files'
  task :combine do
    combine(normalize(parse('comma.txt', ','), "c"), normalize(parse('pipe.txt', '|'), "p"), normalize(parse('space.txt', ' '), "s"))
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

def combine (*arrays)
  array = Array.new
  arrays.each do |x|
    array += x
  end
  f = File.new("outputs.txt", "w+")

  sort(array, 1)
  p 'Output 1:'
  f << "Output 1:\n"
  array.each do |s|
    p s * " "
    f << s * " " << "\n"
  end
  f << "\n"

  sort(array, 2)
  p 'Output 2:'
  f << "Output 2:\n"
  array.each do |s|
    p s * " "
    f << s * " " << "\n"
  end
  f << "\n"

  sort(array, 3)
  p 'Output 3:'
  f << "Output 3:\n"
  array.each do |s|
    p s * " "
    f << s * " " << "\n"
  end
  f << "\n"

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
  if type == 3
    array.sort! do |x, y|
      y[0] <=> x[0]
    end
  else
    array.sort_by! do |x|
      if type == 1
        [x[2], x[0]]
      elsif type == 2
        [Date::strptime(x[3], '%m/%d/%Y'), x[0]]
      end
    end
  end
end

