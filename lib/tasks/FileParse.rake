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

