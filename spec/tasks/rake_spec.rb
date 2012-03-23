require 'spec_helper'

describe 'sort' do
  
  before do
    @rake = Rake::Application.new
    Rake.application = @rake
    Rake.application.rake_require "tasks/foo"
    Rake::Task.define_task(:environment)
  end

  after do
    Rake.application = nil
  end

  describe 'output.txt' do
    before do
      @comma = FileParse.parse('comma.txt')
      @pipe = FileParse.parse('pipe.txt')
      @space = FileParse.parse('space.txt')

      # FileParse.stub(:normalize)
      # FileParse.stub(:combine)
      # FileParse.stub(:output)
      # FileParse.stub(:sort)
      # FileParse.stub(:parse)
    end

    let :run_task do
      Rake.application.invoke_task 'output.txt'
    end

    it "should normalize an array" do
      
      @comma = FileParse.normalize(@comma, 'c')
      @pipe = FileParse.normalize(@pipe, 'p')
      @space = FileParse.normalize(@space, 's')
      
      @comma.length.should == 3
      @pipe.length.should == 3
      @space.length.should == 3

      @comma.should be_an_instance_of Array
      @pipe.should be_an_instance_of Array
      @space.should be_an_instance_of Array
    end

    it "should combines 3 arrays" do
      # FileParse.should_receive(:combine).once
      # run_task
    end

    it "should output a file" do

    end

    it "should sort an array" do

    end

    it "should parses a file" do
      # FileParse.should_receive(:parse).exactly(3).times
      @comma.should be_an_instance_of Array
      @pipe.should be_an_instance_of Array
      @space.should be_an_instance_of Array
      # run_task
    end

  end
end
