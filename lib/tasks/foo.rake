desc 'parses file'
namespace :sort do
  desc 'combines of all files and outputs a new one 3 different ways'
  file 'output.txt' => ['comma.txt','pipe.txt','space.txt'] do |t|
    array = Array.new
    t.prerequisites.each do |file|
      array.push(FileParse.parse(file))
    end
    FileParse.combine(array)
  end
end

class FileParse
  def self.normalize(array, delimiter)
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

  def self.combine(*arrays)
    array = Array.new
    arrays.each do |x|
      x.each do |y|
        array += y
      end
    end
    
    output(array, 1)
    output(array, 2)
    output(array, 3)

  end

  def self.output(array, type)
    f = File.new('output.txt', 'a+')
    sort(array, type)
    p "Output #{type}:"
    f.puts "Output #{type}:\n"
    array.each do |s|
      p s * " "
      f.puts s * " "
    end
    f.puts "\n"
    f.close
  end

  def self.parse(file)
    regex = %r"[\s|\||, ]+"
    unsortedFile = File.new(file, 'r')
    _string = String.new(unsortedFile.read)
    array = Array.new
    _string.each_line() do |line|
      array.push(line.split(regex))
    end
    normalize(array, file.slice(0))
    return array
  end

  def self.sort(array, type)
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

end

