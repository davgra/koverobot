
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
require "SystemDebug"
require "SystemMove"
require "SystemPath"
require "SystemLoader"
