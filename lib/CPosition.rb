class CPosition
  attr_accessor :x, :y
  def initialize(x,y)
    @x=x
    @y=y
  end
  def pix_x
    @x*TILESIZE
  end
  def pix_y
    @y*TILESIZE
  end
end

