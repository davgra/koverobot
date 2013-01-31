
require "components"
require 'helpers'

require 'pp'

class System
  def initialize(manager)
    @manager = manager
  end
  def process_one_game_tick
    raise RuntimeError, "systems must override process_one_game_tick()"
  end
end

require "SystemQuit"
require "SystemInput"
require "SystemRender"

class SystemDebug < System
  def process_one_game_tick(container,delta)
    @manager.get_all_entities_possessing_component(CDebug).each do |e|
      input = @manager.get_component(e,CDebug)
	    if container.get_input.is_key_down(input.key)
	      pp @manager
	      STDOUT.flush
	      sleep 0.5
	    end
	  end
  end
end

class SystemAddRobot < System
  def process_one_game_tick(container,delta)
    @manager.get_all_entities_possessing_component(CAddRobot).each do |e|
      input = @manager.get_component(e,CAddRobot)
      if container.get_input.is_key_down(input.key)
			 	e = @manager.create_entity
			 	sx,sy = rand(4)*3,rand(2)*4
				@manager.add_component(e, CSprite.new(sx,sy,"EBTsukuru2008_06robots.png", 32, 32, 16,16))
				x,y = tile2pix 0,0
				@manager.add_component(e, CPosition.new(x,y))
				x,y = tile2pix 0,1
				@manager.add_component(e, CTarget.new(x,y))
				@manager.add_component(e, CSpeed.new(0.04+rand/50.0,0))
				@manager.add_component(e, CSpriteAnimate.new([sx+0,sx+1,sx+2,sx+1]))
      end
    end
  end
end

class SystemTarget < System
  def process_one_game_tick(container,delta)
    map=@manager.get_all_components_of_type(CMap).first.map
    @manager.get_all_entities_possessing_component(CTarget).each do |e|
      target = @manager.get_component(e,CTarget)
      next if target.reached
      pos =  @manager.get_component(e,CPosition)
      s =    @manager.get_component(e,CSpeed)
      dist_traveled, angle_traveled = r2p(pos.x-target.start_x, pos.y-target.start_y) if target.distance
      if target.distance && dist_traveled > target.distance
        # if we have reaced destination
        target.reached = true
        #s.pause = true     #stop
        tilex, tiley = pix2tile(pos.x,pos.y) # what tile have we reached
        if map[tilex][tiley]  # if tile exists
          # we have reached existing tile
          # Setting new target (target.x target.y)
          dir_to_next_tile = map[tilex][tiley].direction
          if dir_to_next_tile.class == Array
            dir_to_next_tile = dir_to_next_tile[rand(dir_to_next_tile.size)]
          end
          tx,ty = p2r(1,dir_to_next_tile)     # where does resched tile point
          target.x, target.y= tile2pix(tilex+tx.to_i, tiley+ty.to_i)  # set new target
          target.reached=false
          target.distance=false
		      tx,ty = pix2tile(target.x, target.y)
		      if map[tx][ty] && map[tx][ty].occupied
		        #s.pause = true
		      end
        end
      end
			tx,ty = pix2tile(target.x, target.y)
      if map[tx][ty] && !map[tx][ty].occupied
        #s.pause = false
      end
	    next if target.distance
	    # We have a target but we are not moving
	    # Aimingfor new target using target.x target.y values
      dist_to_next_tile, dir_to_next_tile =  r2p(target.x-pos.x, target.y-pos.y)
      s.direction = dir_to_next_tile
      target.start_x = pos.x
      target.start_y = pos.y
      target.distance = dist_to_next_tile
    end
  end
end

class SystemSpeedMove < System
  def process_one_game_tick(container,delta)
		map=@manager.get_all_components_of_type(CMap).first.map
    @manager.get_all_entities_possessing_component(CSpeed).each do |e|
      s =    @manager.get_component(e,CSpeed)
      next if s.pause
      pos =  @manager.get_component(e,CPosition)
      from_tile = pix2tile(pos.x,pos.y)
      dx,dy = p2r(s.velocity*delta, s.direction)
      pos.x += dx
      pos.y += dy
      to_tile = pix2tile(pos.x,pos.y)
      next if from_tile == to_tile
			if map[to_tile[0]] && map[ to_tile[0] ][ to_tile[1] ]
				if map[ to_tile[0] ][ to_tile[1] ].occupied
		      pos.x -= dx
		      pos.y -= dy
		      next
				end
				map[ to_tile[0] ][ to_tile[1] ].occupied=e
			end
		  if map[from_tile[0]] && map[from_tile[0]][from_tile[1]]
  		  map[from_tile[0]][from_tile[1]].occupied=false if map[from_tile[0]][from_tile[1]].occupied==e
  		end
    end
  end
end

class SystemInputMove < System
  def process_one_game_tick(container,delta)
    input = container.get_input
    @manager.get_all_entities_possessing_component(CInput).each do |e|
      p =  @manager.get_component(e,CPosition)
      keys =  @manager.get_component(e,CInput).key
      image_width = @manager.get_component(e,CSprite).width
      speed = 0.06
		  if input.is_key_down(keys[:left]) and p.x > 0
		    p.x -= speed * delta
		  end
		  if input.is_key_down(keys[:right]) and p.x < container.width - image_width
		    p.x += speed * delta
		  end
  	  if input.is_key_down(keys[:up]) and p.y > 0
		    p.y -= speed * delta
		  end
		  if input.is_key_down(keys[:down]) and p.y < container.height - image_width
		    p.y += speed * delta
		  end
    end
  end
end

class SystemSpriteAnimate < System
  def process_one_game_tick(container,delta)
    @manager.get_all_entities_possessing_component(CSpriteAnimate).each do |e|
      sprites  = @manager.get_component(e,CSpriteAnimate).x_array
      sprite   = @manager.get_component(e,CSprite)
      pos      = @manager.get_component(e,CPosition)
      sprite.x = sprites[(((pos.x+pos.y)/10).to_i)%sprites.size]
    end
    @manager.get_all_entities_possessing_component(CSpeed).each do |e|
      direction= @manager.get_component(e,CSpeed).direction
      sprite   = @manager.get_component(e,CSprite)
      sprite.y = [3,2,0,1][((direction+45)%360)/90]
    end
  end
end

