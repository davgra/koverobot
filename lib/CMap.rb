
class CMap
  attr_accessor :map
  def initialize(map=nil)

    case map
    when Array
      @map = create_rect_map(map[0],map[1])
    when Hash
      @map = map
    else
      @map ={}
    end
  end
  def create_rect_map(x,y)
    map={}
    (x*y).times do |i|
      a,b = i%(x), i/x
      map[a] ||={}
      map[a][b] = {:bg=>:grass}
    end
    map
  end
end
