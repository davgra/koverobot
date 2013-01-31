

require "CMap"
require "CPosition"

CSprite   = Struct.new(:animation, :direction)
CSettings = Struct.new(:zoom)
CInput    = Struct.new(:keys)
CQuit     = Struct.new(:key)

#__END__
CTarget   = Struct.new(:x,:y,:reached,:start_x,:start_y,:distance)
CSpeed    = Struct.new(:velocity,:direction,:pause)

CSpriteAnimate = Struct.new(:x_array)

CText     = Struct.new(:text)
CMapItem  = Struct.new(:direction, :occupied)
CDebug    = Struct.new(:key)
CImage    = Struct.new(:filename)
CAddRobot = Struct.new(:key)
