
class CMap
  attr_accessor :map,:yards
  def initialize(map=nil, yards=[])
    @yards = yards
    case map
    when Array
      @map = create_rect_map(map[0],map[1])
    when Hash
      @map = map
    else
      @map ={}
    end
  end
  def [](x,y)
    @map[x][y]
  end
  def keys
    keys=[]
    @map.keys.each do |x|
      @map[x].keys.each do |y|
        keys.push [x,y]
      end
    end
    keys
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
