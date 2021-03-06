QUIT_FILENAME = 'savegame.yaml'

class SystemQuit < System
  def game_tick(container,delta)
    quit_entities =@manager.entities(CQuit)
    #setup_game(@manager) if quit_entities.size == 0
    quit_entities.each do |e|
      input = @manager.component(e,CQuit)
      if container.get_input.is_key_pressed(input.key[:quit])
        @manager.save(QUIT_FILENAME)
        container.exit
      end
      if container.get_input.is_key_pressed(input.key[:restart])
        puts "restarting."
        @manager.clear
        setup_game @manager
      end
      if container.get_input.is_key_pressed(input.key[:new])
        puts "random game."
        map = @manager.labled_component(:map, CMap)
        map.map = map.create_rect_map(11,8)
        map.generate_random
      end
      if container.get_input.is_key_pressed(input.key[:save])
        puts "saveing: ",QUIT_FILENAME
        @manager.save(QUIT_FILENAME)
      end
      if container.get_input.is_key_pressed(input.key[:load])
        puts "loading: ",QUIT_FILENAME
        @manager.load(QUIT_FILENAME)
      end
      if container.get_input.is_key_pressed(input.key[:print])
        pp @manager
        map = @manager.labled_component(:map, CMap)
        puts map.to_s2
      end
    end
  end
end
