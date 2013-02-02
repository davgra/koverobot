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
#java_import org.newdawn.slick.GameContainer
#java_import org.newdawn.slick.Graphics
java_import org.newdawn.slick.Image
#java_import org.newdawn.slick.SlickException
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
      SystemInput.new(@manager),
    ]
    @render_system =SystemRender.new(@manager)
  end

  def update(container, delta)
    @systems.each { |s| s.process_one_game_tick(container,delta) }
  end

  def render(container, graphics)
    @render_system.render(container, graphics)
  end
end

app = AppGameContainer.new(RobotGame.new('KoveRobot'))
app.set_display_mode(800, 600, false)
app.start
