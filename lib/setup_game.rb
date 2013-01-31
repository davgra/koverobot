
def setup_game(manager)
  e= manager.create_entity
  manager.add_component(e, CQuit.new({:quit=>Input::KEY_ESCAPE,
    :restart=>Input::KEY_R,
    :save=>Input::KEY_S }))

  e= manager.create_entity :map
  manager.add_component(e, CMap.new([10,8]))

  e= manager.create_entity :settings
  manager.add_component(e, CSettings.new(0.5))

  wagon = sprite_layout(File.join(RESOURCES,"truckSprite.txt"))
  sprite_size = {:x=>wagon["Left"][0][2],:y=>wagon["Left"][0][3] }
  direction = %w{Left Up Right Down}
  sheet = SpriteSheet.new(File.join(RESOURCES,"truckSprite.png"), sprite_size[:x], sprite_size[:y])
  anim={}
  direction.each do |dir|
    anim[dir] = Animation.new
    list = wagon[dir].map { |e| [e[0]/e[2], e[1]/e[3]] }
    (0..58).each do |i|
      pos=list[i]
      image = sheet.getSubImage(pos[0],pos[1])
      anim[dir].addFrame(image,67)
    end
  end
  e= manager.create_entity #:robot
  manager.add_component(e, CSprite.new(anim, "Right"))
  manager.add_component(e, CPosition.new(3,3))
  manager.add_component(e, CInput.new({:left=>Input::KEY_LEFT,
    :right => Input::KEY_RIGHT,
    :up => Input::KEY_UP,
    :down => Input::KEY_DOWN }))
  pp manager
end
