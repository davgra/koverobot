require "find_path"

class SystemPath < System
  def initialize(x)
    super(x)
    @time=0
    @sec = 0
    @wait_list={}
  end
  def process_one_game_tick(container, delta)
    @time+=delta
    @wait_list.each do |k,v|
      @wait_list[k] = v+delta
    end
    if @time>1000
      @time-=1000
      @sec+=1
      #puts "list: #{@wait_list.inspect}"
    end
    @manager.get_all_entities_possessing_component(CPath).each do |e|
      path = @manager.get_component(e, CPath)
      if path.directions.empty?
        if @wait_list[e]
          if @wait_list[e] > 3000
            @wait_list.delete(e)
            pos =  @manager.get_component(e, CPosition)
            map = @manager.get_labled_component(:map, CMap)
            target = @manager.get_component(e, CTarget)
            start=[pos.x.to_i, pos.y.to_i]
            yards = map.yards.keys-[start]
            stop = yards[rand yards.size]
            path.directions = find_path(start,stop)
            target.speed = 0.0009+0.0001*rand(2)
          end
        else
          @wait_list[e] = 0
        end
      end
    end
  end
end
