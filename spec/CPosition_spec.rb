require File.dirname(__FILE__) + "/../lib/#{File.basename __FILE__, '_spec.rb'}.rb"

TILESIZE = 128

describe CPosition do
  before(:each) do
    @pos = CPosition.new(3,4)
  end
  it "should return pix_x" do
    @pos.pix_x.should == 384
  end
  it "should return pix_y" do
    @pos.pix_y.should == 512
  end
end
