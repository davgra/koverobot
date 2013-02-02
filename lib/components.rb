

require "CMap"
require "CPosition"

CSprite   = Struct.new(:animation, :direction)
CSettings = Struct.new(:zoom)
CInput    = Struct.new(:keys)
CQuit     = Struct.new(:key)
CText     = Struct.new(:text)
CPath     = Struct.new(:directions)
CTarget   = Struct.new(:x,:y,:speed)
CLoad     = Struct.new(:cargo)
CYard     = Struct.new(:produce, :consume, :stock)
