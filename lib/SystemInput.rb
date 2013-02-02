
class SystemInput < System
  def process_one_game_tick(container,delta)
    input = container.get_input
    settings = @manager.get_labled_component(:settings, CSettings)
    camera = @manager.get_labled_component(:camera, CPosition)
    @manager.get_all_entities_possessing_component(CInput).each do |e|
      keys =  @manager.get_component(e,CInput).keys
      if input.is_key_down(Input::KEY_LCONTROL)
        settings.zoom += 0.1 if input.is_key_pressed(keys[:up])
        settings.zoom -= 0.1 if input.is_key_pressed(keys[:down])
      else
        camera.x -=0.03/settings.zoom if input.is_key_down(keys[:left])
        camera.x +=0.03/settings.zoom if input.is_key_down(keys[:right])
        camera.y -=0.03/settings.zoom if input.is_key_down(keys[:up])
        camera.y +=0.03/settings.zoom if input.is_key_down(keys[:down])
      end
    end
    map = @manager.get_labled_component(:map, CMap)
    cx,cy=tile2pix(camera.x,camera.y)
    mx = input.get_mouse_x/settings.zoom+cx
    my = input.get_mouse_y/settings.zoom+cy
    tx,ty = pix2tile(mx,my)
    tx-=4;ty-=3
    if input.is_mouse_pressed(0)
      map[tx,ty][:bg] = :gravel if map[tx,ty]
    end
    if input.is_mouse_pressed(1)
      map[tx,ty][:bg] = :grass if map[tx,ty]
    end
  end
end
