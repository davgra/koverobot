
class SystemInput < System
  def process_one_game_tick(container,delta)
    input = container.get_input
    @manager.get_all_entities_possessing_component(CInput).each do |e|
      keys =  @manager.get_component(e,CInput).keys
      settings = @manager.get_labled_component(:settings, CSettings)
      if input.is_key_down(Input::KEY_LCONTROL)
        settings.zoom += 0.1 if input.is_key_pressed(keys[:up])
        settings.zoom -= 0.1 if input.is_key_pressed(keys[:down])
      else
        camera = @manager.get_labled_component(:camera, CPosition)
        camera.x -=0.03/settings.zoom if input.is_key_down(keys[:left])
        camera.x +=0.03/settings.zoom if input.is_key_down(keys[:right])
        camera.y -=0.03/settings.zoom if input.is_key_down(keys[:up])
        camera.y +=0.03/settings.zoom if input.is_key_down(keys[:down])
      end
    end
  end
end
