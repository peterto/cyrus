require 'rake/testtask'
require 'Date'
require_relative 'lib/tasks/FileParse'

Dir.glob('lib/tasks/*.rake').each { |r| import r }

desc 'unit tests for rake'
task :test do
  Rake::TestTask.new do |t|
    t.libs << "test"
    t.warning = false
    t.verbose = true
    t.test_files = FileList['test/*test.rb']
  end
end
