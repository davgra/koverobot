class SystemProduce < System
  def process_one_game_tick(container, delta)
    @manager.get_all_entities_possessing_component(CYard).each do |e|
      yard = @manager.get_component(e, CYard)
      stock = yard.stock
      text = @manager.get_component(e, CText)
      if stock[:diamonds] && stock[:rocks] && stock[:rocks] >= 5
        stock[:diamonds] += 1
        stock[:rocks] -= 5
      end
      prod = "#{yard.produce}:#{stock[yard.produce]}"
      cons = "#{yard.consume}:#{stock[yard.consume]}"
      text.text = "#{prod}\n#{cons}"
    end
  end
end
