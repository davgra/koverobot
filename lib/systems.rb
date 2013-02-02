
require "components"
require 'helpers'

require 'pp'

class System
  def initialize(manager)
    @manager = manager
  end
  def game_tick
    raise RuntimeError, "systems must override game_tick()"
  end
end

require "SystemQuit"
require "SystemInput"
require "SystemRender"
require "SystemDebug"
require "SystemMove"
require "SystemPath"
require "SystemLoader"
require "SystemProduce"
