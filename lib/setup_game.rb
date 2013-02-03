
def setup_game(manager)
  e= manager.create_entity # quit
  manager.add_component(e, CQuit.new({:quit=>Input::KEY_ESCAPE,
    :restart=>Input::KEY_R,
    :save=>Input::KEY_S,
    :load=>Input::KEY_L,
    :print=>Input::KEY_P }))

  yards = {
    [1,2]=>{
      :produce=>:diamonds,
      :prod_time=>1000*60/1/2,
      :consume=>[:rocks, :logs],
      :stock=>{:diamonds=>0,:rocks=>0, :logs=>0}
    },
    [7,6]=>{:consume=>[:diamonds], :stock=>{:diamonds=>0}},
    [2,5]=>{:produce=>:rocks,:prod_time=>1000*60/5/2, :consume=>[], :stock=>{:rocks=>1}},
    [6,0]=>{:produce=>:logs,:prod_time=>1000*60/7/2, :consume=>[], :stock=>{:logs=>1}},
  }

  e= manager.create_entity :map
  map = CMap.new([11,8], yards.keys)
  map[1,1][:fg]=:factory
  map[8,6][:fg]=:home
  map[1,5][:fg]=:mine
  map[5,0][:fg]=:tree
  map[3,4][:fg]=:tree
  manager.add_component(e, map)

  yards.each do |yard, v|
    e= manager.create_entity yard
    manager.add_component(e, CYard.new(v[:produce],v[:prod_time],v[:consume],v[:stock]))
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

  [[2,3],[9,3],[4,7]].each do |x,y|
    e= manager.create_entity #:robot
    manager.add_component(e, CSprite.new(:empty, :right))
    manager.add_component(e, CPosition.new(x,y))
    manager.add_component(e, CPath.new([]))
    manager.add_component(e, CTarget.new(x,y,0))
    manager.add_component(e, CLoad.new)
  end

end

