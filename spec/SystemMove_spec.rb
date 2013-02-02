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

      @sys=SystemMove.new(@manager)
    end
    it "should move entity" do
      @sys.process_one_game_tick(nil,1000/50.0)
      pos=@manager.get_component(1, CPosition)
      t = @manager.get_component(1, CTarget)
      pos.x.should == 1.2
      pos.y.should == 2.0
      t.x.should == 2
      t.y.should == 2
    end
    it "should stop on target" do
      5.times do
        @sys.process_one_game_tick(nil,20)
      end
      pos=@manager.get_component(1, CPosition)
      "x: #{pos.x} y: #{pos.y}".should == "x: 2.0 y: 2.0"
    end
    it "should continue after target" do
        @sys.process_one_game_tick(nil,20)
      pos=@manager.get_component(1, CPosition)
      "x: #{pos.x} y: #{pos.y}".should == "x: 2.2 y: 2.0"
      target = @manager.get_component(1, CTarget)
      target.x.should == 3
      target.y.should == 2
    end
    it "should target" do
      25.times do
        @sys.process_one_game_tick(nil,20)
      end
      pos=@manager.get_component(1, CPosition)
      "x: #{pos.x} y: #{pos.y}".should == "x: 2.0 y: 3.0"
      sprite = @manager.get_component(1,CSprite)
      sprite.direction.should == :stop_up
    end
  end
