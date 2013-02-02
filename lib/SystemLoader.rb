class SystemLoader < System
  def game_tick(container, delta)
    @manager.entities(CLoad).each do |e|
      target = @manager.component(e, CTarget)
      map = @manager.labled_component(:map, CMap)
      next unless target.speed == 0 && map.yards.include?([target.x, target.y])
      load = @manager.component(e, CLoad)
      sprite = @manager.component(e, CSprite)
      yard = @manager.labled_component([target.x, target.y],CYard)
      if load.cargo
        if yard[:consume].include?(load.cargo)
          yard[:stock][load.cargo] += 1
          load.cargo=nil
          sprite.animation = :empty
        end
      else
        prod = yard[:produce]
        if prod
          if yard[:stock][prod] && yard[:stock][prod] > 0
            load.cargo = prod
            yard[:stock][prod] -= 1
            sprite.animation = prod
          end
        end
      end
    end
  end
end
