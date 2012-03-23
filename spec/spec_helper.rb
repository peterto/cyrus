require 'rake'

RSpec.configure do |config|

  config.mock_with :rspec
  config.expect_with :rspec
  config.after(:all) do
    puts "All tests have finished."
  end

end
