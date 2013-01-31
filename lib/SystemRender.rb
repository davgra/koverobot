class SystemRender < System
  def initialize(x)
    super(x)
    @@sprite_sheets={}
    @@images={}
  end
  def render(container, graphics)
    zoom = @manager.get_labled_component(:settings, CSettings).zoom
    graphics.scale(zoom,zoom)
    @manager.get_all_entities_possessing_component(CImage).each do |e|
      image_fn =@manager.get_component(e,CImage).filename
      pos =   @manager.get_component(e,CPosition)
      @@images[image_fn] ||= Image.new('resources/bg.png')
      image = @@images[image_fn]
      image.drawCentered(pos.x,pos.y)
    end
    @manager.get_all_entities_possessing_component(CSprite).each do |e|
      sprite= @manager.get_component(e,CSprite)
      pos =   @manager.get_component(e,CPosition)

      sprite.animation[sprite.direction].draw(pos.x, pos.y)
    end
    @manager.get_all_entities_possessing_component(CText).each do |e|
      text = @manager.get_component(e,CText).text
      pos =  @manager.get_component(e,CPosition)
      graphics.draw_string(text,pos.x,pos.y)
    end
  end
end

