
class SystemInput < System
  def game_tick(container,delta)
    input = container.get_input
    settings = @manager.labled_component(:settings, CSettings)
    camera = @manager.labled_component(:camera, CPosition)
    @manager.entities(CInput).each do |e|
      keys =  @manager.component(e,CInput).keys
      if input.is_key_down(Input::KEY_LCONTROL)
        settings.zoom += 0.1 if input.is_key_pressed(keys[:up])
        settings.zoom -= 0.1 if input.is_key_pressed(keys[:down])
        settings.zoom = 0.1 if settings.zoom  < 0.1
        settings.zoom = 2 if settings.zoom  > 2
      else
        camera.x -=0.03/settings.zoom if input.is_key_down(keys[:left])
        camera.x +=0.03/settings.zoom if input.is_key_down(keys[:right])
        camera.y -=0.03/settings.zoom if input.is_key_down(keys[:up])
        camera.y +=0.03/settings.zoom if input.is_key_down(keys[:down])
      end
    end
    map = @manager.labled_component(:map, CMap)
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
