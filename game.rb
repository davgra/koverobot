#!/usr/bin/env ruby
$:.push File.expand_path('../lib/java', __FILE__)
$:.push File.expand_path('../lib', __FILE__)

require 'java'
require 'lwjgl.jar'
require 'slick.jar'
require 'systems.rb'
require 'entity_manager.rb'
require "setup_game"

RESOURCES = 'res'
TILESIZE = 128

java_import org.newdawn.slick.BasicGame
java_import org.newdawn.slick.AppGameContainer
java_import org.newdawn.slick.SpriteSheet
java_import org.newdawn.slick.Animation
java_import org.newdawn.slick.Input
java_import org.newdawn.slick.Image
java_import org.newdawn.slick.Color


class RobotGame < BasicGame
  def init(container)
    @manager = EntityManager.new
    setup_game @manager
    @systems=[
      #SystemDebug.new(@manager),
      SystemQuit.new(@manager),
      SystemPath.new(@manager),
      SystemMove.new(@manager),
      SystemLoader.new(@manager),
      SystemProduce.new(@manager),
      SystemInput.new(@manager),
    ]
    @render_system =SystemRender.new(@manager)
  end

  def update(container, delta)
    @systems.each { |s| s.game_tick(container,delta) }
  end

  def render(container, graphics)
    @render_system.render(container, graphics)
  end

  def mouseWheelMoved(change)
    settings = @manager.labled_component(:settings, CSettings)
    settings.zoom += 0.1*change/120
  end
end

app = AppGameContainer.new(RobotGame.new('KoveRobot'))
x,y=(ARGV.shift || "").split("x")
x=800 unless x.to_i > 10
y=600 unless y.to_i > 10
app.set_display_mode(x.to_i, y.to_i, false)
app.start
