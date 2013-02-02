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
      next unless path.directions.empty?
      if @wait_list[e]
        if @wait_list[e] > 3000
          @wait_list.delete(e)
          pos =  @manager.get_component(e, CPosition)
          map = @manager.get_labled_component(:map, CMap)
          target = @manager.get_component(e, CTarget)
          start=[pos.x.to_i, pos.y.to_i]
          my_cargo = @manager.get_component(e, CLoad).cargo
          yards = []
          @manager.get_all_entities_possessing_component(CYard).each do |y|
            yard = @manager.get_component(y, CYard)
            yard_pos = @manager.get_component(y, CPosition)
            next if [yard_pos.x,yard_pos.y] == start
            if my_cargo
              yards.push [yard_pos.x,yard_pos.y] if yard[:consume] == my_cargo
            else
              yards.push [yard_pos.x,yard_pos.y] if yard[:produce]
            end
          end
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
