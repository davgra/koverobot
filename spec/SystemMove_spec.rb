require File.dirname(__FILE__) + "/../lib/systems.rb"
require File.dirname(__FILE__) + "/../lib/components.rb"
require File.dirname(__FILE__) + "/../lib/entity_manager.rb"

describe SystemMove do
  before(:all) do
    @manager = EntityManager.new

    e= @manager.create_entity
    @manager.add_component(e, CPosition.new(1,2))
    @manager.add_component(e, CPath.new([:right,:down,:down,:left,:up]))
    @manager.add_component(e, CTarget.new(2,2,0.01))
    @manager.add_component(e, CSprite.new(nil,:stop))

    e= @manager.create_entity :map
    map = CMap.new([11,8])
    @manager.add_component(e, map)

    @sys=SystemMove.new(@manager)
  end
  it "should move entity" do
    @sys.game_tick(nil,1000/50.0)
    pos=@manager.component(1, CPosition)
    t = @manager.component(1, CTarget)
    pos.x.should == 1.06
    pos.y.should == 2.0
    t.x.should == 2
    t.y.should == 2
  end
  it "should stop on target" do
    5.times do
      @sys.game_tick(nil,20)
    end
    pos=@manager.component(1, CPosition)
    "x: #{pos.x} y: #{pos.y}".should == "x: 1.3600000000000003 y: 2.0"
  end
  it "should continue after target" do
    @sys.game_tick(nil,20)
    pos=@manager.component(1, CPosition)
    "x: #{pos.x} y: #{pos.y}".should == "x: 1.4200000000000004 y: 2.0"
    target = @manager.component(1, CTarget)
    target.x.should == 2
    target.y.should == 2
  end
  it "should target" do
    50.times do
      @sys.game_tick(nil,20)
    end
    pos=@manager.component(1, CPosition)
    "x: #{pos.x} y: #{pos.y}".should == "x: 3.0 y: 3.3600000000000003"
    sprite = @manager.component(1,CSprite)
    sprite.direction.should == :down
  end
end
