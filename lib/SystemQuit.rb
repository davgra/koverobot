

class SystemQuit < System
  def process_one_game_tick(container,delta)
    quit_entities =@manager.get_all_entities_possessing_component(CQuit)
    #setup_game(@manager) if quit_entities.size == 0
    quit_entities.each do |e|
      input = @manager.get_component(e,CQuit)
      if container.get_input.is_key_pressed(input.key[:quit])
        pp @manager
        @manager.save('tmp/savegame.yaml')
        container.exit
      end
      if container.get_input.is_key_pressed(input.key[:restart])
        filename = 'tmp/savegame.yaml'
        puts "loading: ",filename
        @manager.load(filename)
      end
      if container.get_input.is_key_pressed(input.key[:save])
        filename = 'tmp/savegame.yaml'
        puts "saveing: ",filename
        @manager.save(filename)
      end
    end
  end
end

