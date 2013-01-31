
class SystemInput < System
  def process_one_game_tick(container,delta)
    input = container.get_input
    @manager.get_all_entities_possessing_component(CInput).each do |e|
      sprite = @manager.get_component(e, CSprite)
      keys =  @manager.get_component(e,CInput).keys
      settings = @manager.get_labled_component(:settings, CSettings)
      @directions ||= %w{Left Up Right Down}
      if input.is_key_pressed(keys[:left])
        sprite.direction = @directions[(@directions.index(sprite.direction)-1)%4]
      end
      if input.is_key_pressed(keys[:right])
        sprite.direction = @directions[(@directions.index(sprite.direction)+1)%4]
      end
      settings.zoom += 0.1 if input.is_key_pressed(keys[:up])
      settings.zoom -= 0.1 if input.is_key_pressed(keys[:down])
    end
  end
end
