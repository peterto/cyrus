desc 'combines of all files and outputs a new one 3 different ways'
file 'output.txt' => ['comma.txt','pipe.txt','space.txt'] do |t|
  array = Array.new
  t.prerequisites.each do |file|
    array.push(FileParse.normalize(FileParse.parse(file), file.slice(0)))
  end
  (1..3).each do |t|
    FileParse.output(FileParse.combine(array), t)
  end
end

class FileParse

  # normalizes arrays to make them all have the same structure
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

  # combines 3 arrays
  def self.combine(*arrays)
    array = Array.new
    arrays.each do |x|
      x.each do |y|
        array += y
      end
    end
    return array 
  end

  # Creates an output of a given array and output type
  def self.output(array, type)
    f = File.new('output.txt', 'a+')
    sort(array, type)
    # p "Output #{type}:"
    f.puts "Output #{type}:\n"
    array.each do |s|
      # p s * " "
      f.puts s * " "
    end
    f.puts "\n"
    f.close
  end
  
  # turns a file into an array of arrays
  def self.parse(file)
    regex = %r"[\s|\||, ]+"
    unsortedFile = File.new(file, 'r')
    _string = String.new(unsortedFile.read)
    array = Array.new
    _string.each_line() do |line|
      array.push(line.split(regex))
    end
    return array
  end

  # sorts file given an output type
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

