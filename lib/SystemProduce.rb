class SystemProduce < System
  def process_one_game_tick(container, delta)
    @manager.get_all_entities_possessing_component(CYard).each do |e|
      stock = @manager.get_component(e, CYard).stock
      if stock[:diamonds] && stock[:rocks] && stock[:rocks] > 5
        stock[:diamonds] += 1
        stock[:rocks] -= 5
      end
    end
  end
end