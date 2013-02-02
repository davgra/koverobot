class SystemLoader < System
  def process_one_game_tick(container, delta)
    @manager.get_all_entities_possessing_component(CLoad).each do |e|
      target = @manager.get_component(e, CTarget)
      map = @manager.get_labled_component(:map, CMap)
      load = @manager.get_component(e, CLoad)
      sprite = @manager.get_component(e, CSprite)
      yard = [target.x, target.y]
      if target.speed == 0 && map.yards[yard]
        if load.cargo
          if load.cargo == map.yards[yard][:consume]
            load.cargo=nil
            sprite.animation = :empty
          end
        else
          if map.yards[yard][:produce]
            load.cargo = map.yards[yard][:produce]
            sprite.animation = map.yards[yard][:produce]
          end
        end
      end
    end
  end
end
