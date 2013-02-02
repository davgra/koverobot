# encoding: utf-8
require File.dirname(__FILE__) + "/../lib/#{File.basename __FILE__, '_spec.rb'}.rb"
FILENAME = File.dirname(__FILE__) + "/load_sprite.txt"


describe "sprite_layout(filename)" do
    it "should give the layout of the sprite" do
      sprite_layout(FILENAME).should == {"Down"=>[[0, 0, 150, 150], [150, 0, 150, 150], [300, 0, 150, 150], [0, 150, 150, 150]]}
    end
end
