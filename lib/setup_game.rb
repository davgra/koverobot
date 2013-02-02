
def setup_game(manager)
  e= manager.create_entity # quit
  manager.add_component(e, CQuit.new({:quit=>Input::KEY_ESCAPE,
    :restart=>Input::KEY_R,
    :save=>Input::KEY_S,
    :load=>Input::KEY_L,
    :print=>Input::KEY_P }))

  yards = {
    [1,2]=>{:produce=>:diamonds,:consume=>:rocks, :stock=>{:diamonds=>20,:rocks=>0}},
    [7,6]=>{:consume=>:diamonds, :stock=>{:diamonds=>0}},
    [2,5]=>{:produce=>:rocks, :stock=>{:rocks=>50}}
  }

  e= manager.create_entity :map
  map = CMap.new([11,8], yards)
  map[1,1][:fg]=:factory
  map[8,6][:fg]=:home
  map[1,5][:fg]=:mine
  map[5,0][:fg]=:tree
  map[3,3][:fg]=:tree
  manager.add_component(e, map)

  yards.each do |yard, v|
    e= manager.create_entity yard
    manager.add_component(e, CPosition.new(yard[0],yard[1]))
    manager.add_component(e, CText.new("Yard +#{v[:produce]} -#{v[:consume]}"))
  end

  e= manager.create_entity :settings
  manager.add_component(e, CSettings.new(0.6))

  e= manager.create_entity :camera
  manager.add_component(e, CPosition.new(4,3))
  manager.add_component(e, CText.new("Camera"))
  manager.add_component(e, CInput.new({:left=>Input::KEY_LEFT,
    :right => Input::KEY_RIGHT,
    :up => Input::KEY_UP,
    :down => Input::KEY_DOWN }))

  e= manager.create_entity #:robot
  manager.add_component(e, CSprite.new(:empty, :right))
  manager.add_component(e, CPosition.new(2,3))
  manager.add_component(e, CPath.new([]))
  manager.add_component(e, CTarget.new(3,3,0.001))
  manager.add_component(e, CLoad.new)

  e= manager.create_entity #:wagon1
  manager.add_component(e, CSprite.new(:empty, :right))
  manager.add_component(e, CPosition.new(1,3))
  manager.add_component(e, CPath.new([]))
  manager.add_component(e, CTarget.new(2,3,0.001))
  manager.add_component(e, CLoad.new)

  e= manager.create_entity
  manager.add_component(e, CSprite.new(:empty, :right))
  manager.add_component(e, CPosition.new(0,3))
  manager.add_component(e, CPath.new([]))
  manager.add_component(e, CTarget.new(1,3,0.001))
  manager.add_component(e, CLoad.new)
end

