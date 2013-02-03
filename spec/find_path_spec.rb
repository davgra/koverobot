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

describe "find_path(from, to, map)" do
  before(:all) do
    @map =
        {0=>
          {0=>{:bg=>:grass},
           1=>{:bg=>:grass, :fg=>:factory},
           2=>{:bg=>:grass},
           3=>{:bg=>:grass},
           4=>{:bg=>:grass},
           5=>{:bg=>:grass}},
         1=>
          {0=>{:bg=>:grass},
           1=>{:bg=>:grass, :fg=>:factory},
           2=>{:bg=>:grass},
           3=>{:bg=>:grass, :fg=>:factory},
           4=>{:bg=>:grass},
           5=>{:bg=>:grass, :fg=>:mine}},
         2=>
          {0=>{:bg=>:grass},
           1=>{:bg=>:grass},
           2=>{:bg=>:grass},
           3=>{:bg=>:grass, :fg=>:factory},
           4=>{:bg=>:grass},
           5=>{:bg=>:grass}},
         3=>
          {0=>{:bg=>:grass},
           1=>{:bg=>:grass},
           2=>{:bg=>:grass},
           3=>{:bg=>:grass},
           4=>{:bg=>:grass},
           5=>{:bg=>:grass}},
         }

  end
  it "should find optimized path" do
    find_path([0,0,],[0,5],@map).should== [:right, :right, :down, :down,
      :left, :left, :down, :down, :down]
  end
end

describe "find_path(from, to, map)" do
  before(:all) do
    @map =
        {0=>
          {0=>{:bg=>:grass},
           1=>{:bg=>:grass, :fg=>:tree},
           2=>{:bg=>:grass},
           3=>{:bg=>:grass},
           4=>{:bg=>:grass},
           5=>{:bg=>:grass},
           6=>{:bg=>:grass},
           7=>{:bg=>:grass}},
         1=>
          {0=>{:bg=>:grass},
           1=>{:bg=>:grass, :fg=>:factory},
           2=>{:bg=>:grass},
           3=>{:bg=>:grass},
           4=>{:bg=>:grass},
           5=>{:bg=>:grass, :fg=>:mine},
           6=>{:bg=>:grass},
           7=>{:bg=>:grass}},
         2=>
          {0=>{:bg=>:grass},
           1=>{:bg=>:gravel},
           2=>{:bg=>:grass},
           3=>{:bg=>:grass},
           4=>{:bg=>:grass},
           5=>{:bg=>:grass},
           6=>{:bg=>:grass},
           7=>{:bg=>:grass}},
         3=>
          {0=>{:bg=>:grass},
           1=>{:bg=>:grass},
           2=>{:bg=>:grass},
           3=>{:bg=>:grass, :fg=>:tree},
           4=>{:bg=>:grass},
           5=>{:bg=>:grass},
           6=>{:bg=>:grass},
           7=>{:bg=>:grass}},
         4=>
          {0=>{:bg=>:grass},
           1=>{:bg=>:grass},
           2=>{:bg=>:grass},
           3=>{:bg=>:grass},
           4=>{:bg=>:grass},
           5=>{:bg=>:grass},
           6=>{:bg=>:grass},
           7=>{:bg=>:grass}},
         5=>
          {0=>{:bg=>:grass, :fg=>:tree},
           1=>{:bg=>:grass},
           2=>{:bg=>:grass},
           3=>{:bg=>:grass},
           4=>{:bg=>:grass},
           5=>{:bg=>:grass},
           6=>{:bg=>:grass},
           7=>{:bg=>:grass}},
         6=>
          {0=>{:bg=>:grass},
           1=>{:bg=>:grass},
           2=>{:bg=>:grass},
           3=>{:bg=>:grass},
           4=>{:bg=>:grass},
           5=>{:bg=>:grass},
           6=>{:bg=>:grass},
           7=>{:bg=>:grass}},
         7=>
          {0=>{:bg=>:grass},
           1=>{:bg=>:grass},
           2=>{:bg=>:grass},
           3=>{:bg=>:grass},
           4=>{:bg=>:grass},
           5=>{:bg=>:grass},
           6=>{:bg=>:grass},
           7=>{:bg=>:grass}},
         8=>
          {0=>{:bg=>:grass},
           1=>{:bg=>:grass},
           2=>{:bg=>:grass},
           3=>{:bg=>:grass},
           4=>{:bg=>:grass},
           5=>{:bg=>:grass},
           6=>{:bg=>:grass, :fg=>:home},
           7=>{:bg=>:grass}},
         9=>
          {0=>{:bg=>:grass},
           1=>{:bg=>:grass},
           2=>{:bg=>:grass},
           3=>{:bg=>:grass},
           4=>{:bg=>:grass},
           5=>{:bg=>:grass},
           6=>{:bg=>:grass},
           7=>{:bg=>:grass}},
         10=>
          {0=>{:bg=>:grass},
           1=>{:bg=>:grass},
           2=>{:bg=>:grass},
           3=>{:bg=>:grass},
           4=>{:bg=>:grass},
           5=>{:bg=>:grass},
           6=>{:bg=>:grass},
           7=>{:bg=>:grass}}}


  end
  it "should find optimized path" do
    find_path([0,0],[0,5],@map).should==
      [:right, :right, :down, :down, :left, :left, :down, :down, :down]
  end
  it "should find optimized path" do
    find_path([6,0],[1,2],@map).should== [:down, :left, :left, :left, :left, :down, :left]
  end
end
