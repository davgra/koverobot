QUIT_FILENAME = 'tmp/savegame.yaml'

class SystemQuit < System
  def process_one_game_tick(container,delta)
    quit_entities =@manager.get_all_entities_possessing_component(CQuit)
    #setup_game(@manager) if quit_entities.size == 0
    quit_entities.each do |e|
      input = @manager.get_component(e,CQuit)
      if container.get_input.is_key_pressed(input.key[:quit])
        @manager.save(QUIT_FILENAME)
        container.exit
      end
      if container.get_input.is_key_pressed(input.key[:restart])
        puts "restarting."
        @manager.clear
        setup_game @manager
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
      end
    end
  end
end
