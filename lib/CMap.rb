
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
    puts "error map[#{x},#{y}]" && return unless @map[x] && @map[x][y]
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
  def generate_random
    k = keys
    nr = k.size/100+1
    nr.times do
      x,y = k[rand(k.size)]
      @map[x][y][:fg] = :factory
      x,y = k[rand(k.size)]
      @map[x][y][:fg] = :home
      x,y = k[rand(k.size)]
      @map[x][y][:fg] = :mine
      x,y = k[rand(k.size)]
      @map[x][y][:fg] = :tree
    end
  end

  def to_s2
    str = ""
    keys.sort.each_with_index do |a,i|
      y,x=a
      bg=Hash[:grass, ".", :gravel, "-"]
      fg=Hash[:factory, "F", :mine, "M", :tree, "T", :home, "H"]
      c = bg[@map[y][x][:bg]]
      c = fg[@map[y][x][:fg]] if @map[y][x][:fg]
      str += c
      str += "\n" if ((i+1) % @map.size) == 0
    end
    str
  end
end
