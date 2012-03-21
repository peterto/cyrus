require 'spec_helper'
require 'rake'

describe 'stuff' do
  before do
    load File.expand_path("../../../Rakefile", __FILE__)
    Rake::Task.define_task(:environment)
  end

  it 'should test rake' do
    pending "write  test for this"
  end
end
