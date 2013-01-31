
def pix2tile(x,y)
  [x,y].map{|x| x.to_i/48}
end

def tile2pix(x,y)
  [x,y].map{|x| x*48+24}
end

def r2p(x,y)
	theta = Math.atan2(-y,x)   # Compute the angle
	r = Math.hypot(x,-y)       # Compute the distance
	[r, -theta/Math::PI*180+90]
end
 
def p2r(r,t)
  x=r*Math.sin((t*Math::PI)/180)
  y=r*Math.cos((t*Math::PI)/180)
  [x, -y]
end
