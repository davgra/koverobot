require 'load_sprite'

class SystemRender < System
  def initialize(x)
    super(x)
    @images={
      :grass => Image.new("res/grass128.jpg"),
      :gravel => Image.new("res/sand.jpg"),
      :factory => Image.new("res/osa_site-factory.png"),
      :home => Image.new("res/osa_site-neighbourhood.png"),
      :mine => Image.new("res/Mine128.png"),
      :tree => Image.new("res/tree_archigraphs.png"),
    }
    @bg_color = Color.new(0x8d,0xda,0x70)
    @animation = {
      :empty => anim("wagonEmpty"),
      :diamonds => anim("wagonDiamonds"),
      :rocks => anim("wagonRocks"),
      :logs => anim("wagonLogs"),
    }
  end
  def render(container, graphics)
    zoom = @manager.labled_component(:settings, CSettings).zoom
    cam =  @manager.labled_component(:camera, CPosition)
    dx = cam.x-4
    dy = cam.y-3
    graphics.scale(zoom,zoom)
    graphics.setBackground(@bg_color)
    map = @manager.labled_component(:map, CMap)
    # render images
    map.keys.each do |x,y|
      @images[map[x,y][:bg]].draw((x-dx)*TILESIZE, (y-dy)*TILESIZE) if map[x,y][:bg]
      @images[map[x,y][:fg]].draw((x-dx)*TILESIZE, (y-dy)*TILESIZE) if map[x,y][:fg]
    end
    # render sprites
    @manager.entities(CSprite).each do |e|
      sprite= @manager.component(e,CSprite)
      pos =   @manager.component(e,CPosition)
      if @animation[sprite.animation][sprite.direction]
        @animation[sprite.animation][sprite.direction].draw((pos.x-dx)*TILESIZE,
          (pos.y-dy)*TILESIZE)
      end
    end
    # render texts
    @manager.entities(CText).each do |e|
      text = @manager.component(e,CText).text
      pos =  @manager.component(e,CPosition)
      graphics.draw_string(text,(pos.x-dx)*TILESIZE,
        (pos.y-dy)*TILESIZE)
    end
  end
end

