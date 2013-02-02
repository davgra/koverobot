class SystemLoader < System
  def process_one_game_tick(container, delta)
    @manager.get_all_entities_possessing_component(CLoad).each do |e|
      target = @manager.get_component(e, CTarget)
      map = @manager.get_labled_component(:map, CMap)
      next unless target.speed == 0 && map.yards.include?([target.x, target.y])
      load = @manager.get_component(e, CLoad)
      sprite = @manager.get_component(e, CSprite)
      yard = @manager.get_labled_component([target.x, target.y],CYard)
      if load.cargo
        if load.cargo == yard[:consume]
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
