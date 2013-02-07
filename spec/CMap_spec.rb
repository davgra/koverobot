require File.dirname(__FILE__) + "/../lib/#{File.basename __FILE__, '_spec.rb'}.rb"


describe CMap do
  it "should return index to all tiles" do
    @map = CMap.new([3,2])
    @map.keys.should == [[0, 0], [0, 1], [1, 0], [1, 1], [2, 0], [2, 1]]
  end
  it "should implement [x,y]" do
    @map = CMap.new([3,2])
    @map[1,1][:bg].should == :grass
  end
  it "should return keys" do
    @map = CMap.new([3,2])
  end
  it "should print map" do
    @map = CMap.new([3,2])
    pp @map
    @map.to_s2.should == "...\n...\n"
  end
end
