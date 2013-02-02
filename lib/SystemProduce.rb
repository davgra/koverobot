class SystemProduce < System
  def initialize(x)
    super(x)
    @wait_time={}
  end
  def game_tick(container, delta)
    @wait_time.each do |k,v|
      @wait_time[k] = v+delta
    end
    @manager.entities(CYard).each do |e|
      yard = @manager.component(e, CYard)
      stock = yard.stock
      text = @manager.component(e, CText)
      if stock[:diamonds] &&
            stock[:rocks] && stock[:rocks] >= 5 &&
            stock[:logs] && stock[:logs] >=7
        stock[:diamonds] += 1
        stock[:rocks] -= 5
        stock[:logs] -= 7
      end
      str = "#{yard.produce}:#{stock[yard.produce]}"
      yard.consume.each do |c|
        str += "\n#{c}:#{stock[c]}"
      end
      text.text = str

      next unless yard.produce
      if @wait_time[e]
        if yard.produce==:diamonds && stock[:rocks]<5 && stock[:logs]<7
          @wait_time[e]=0
        end
        if @wait_time[e] > yard.prod_time
          @wait_time[e] -= yard.prod_time
          stock[yard.produce]+=1
        end
      else
        @wait_time[e]=0
      end
    end
  end
end
