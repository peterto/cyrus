require 'spec_helper'

describe 'namespace sort' do
  
  before do
    @rake = Rake::Application.new
    Rake.application = @rake
    Rake.application.rake_require "tasks/foo"
    Rake::Task.define_task(:environment)
  end

  after do
    Rake.application = nil
  end

  describe 'sort:output' do
    before do
      FileParse.stub(:normalize)
      FileParse.stub(:combine)
      FileParse.stub(:output)
      FileParse.stub(:sort)
      FileParse.stub(:parse)
    end

    let :run_task do
      Rake.application.invoke_task "sort:output"
    end

    it "should normalize a file" do
      FileParse.should_receive(:normalize).exactly(3).times
      run_task
    end
    
    it "should combines 3 arrays" do
      FileParse.should_receive(:combine).once
      run_task
    end

    it "should parses a file" do
      FileParse.should_receive(:parse).exactly(3).times
      run_task
    end

  end
end
