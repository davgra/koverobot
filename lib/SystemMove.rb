
class SystemMove < System
  def process_one_game_tick(container,delta)
    @manager.get_all_entities_possessing_component(CTarget).each do |e|
      target = @manager.get_component(e, CTarget)
      pos = @manager.get_component(e, CPosition)
      dx = target.x-pos.x
      dy = target.y-pos.y
      r,t = r2p(dx,dy)
      move = target.speed*delta
      if r < move
        dirs = @manager.get_component(e, CPath).directions
        sprite = @manager.get_component(e, CSprite)
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
