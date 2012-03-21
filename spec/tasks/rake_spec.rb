require 'spec_helper'
require 'rake'

describe 'stuff' do
  before do
    @rake = Rake::Application.new
    Rake.application = @rake
    Rake.application.rake_require "tasks/foo"
    Rake::Task.define_task(:environment)
  end

  it 'should test rake' do
    pending "write  test for this"
  end
end
