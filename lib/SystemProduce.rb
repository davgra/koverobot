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
      str = "#{yard.produce}:#{stock[yard.produce]}"
      yard.consume.each do |c|
        str += "\n#{c}:#{stock[c]}"
      end
      text.text = str
    end
  end
end
