# encoding: utf-8
require File.dirname(__FILE__) + "/../lib/#{File.basename __FILE__, '_spec.rb'}.rb"


describe "find_path(from, to)" do
    it "should find a path" do
      find_path([0,0],[1,0]).should == [:right]
      find_path([0,0],[1,1]).should == [:right,:down]
      find_path([0,0],[1,2]).should == [:right,:down,:down]
      find_path([1,0],[0,0]).should == [:left]
      find_path([1,1],[0,0]).should == [:left,:up]
    end
end
