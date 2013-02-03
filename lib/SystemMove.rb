
class SystemMove < System
  def game_tick(container,delta)
    @manager.entities(CTarget).each do |e|
      target = @manager.component(e, CTarget)
      pos = @manager.component(e, CPosition)
      map = @manager.labled_component(:map, CMap)
      groundtype = map[pos.x.to_i,pos.y.to_i][:bg]
      resistance = Hash[:grass, 0.3, :gravel, 1.5]
      dx = target.x-pos.x
      dy = target.y-pos.y
      r,t = r2p(dx,dy)
      move = target.speed*delta*resistance[groundtype]
      move *= 5 if container.get_input.is_key_down(Input::KEY_SPACE)
      if r < move
        dirs = @manager.component(e, CPath).directions
        sprite = @manager.component(e, CSprite)
        if dirs.empty?
          target.speed = 0
          sprite.direction = ("stop_"+sprite.direction.to_s).to_sym
        else
          dir = dirs.shift
          sprite.direction = dir
          target.x += 1 if dir == :right
          target.x -= 1 if dir == :left
          target.y += 1 if dir == :down
          target.y -= 1 if dir == :up
        end
      else
        dx,dy = p2r(move,t)
      end
      pos.x+=dx
      pos.y+=dy
    end
  end
end
