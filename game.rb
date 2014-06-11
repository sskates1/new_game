require 'gosu'
require_relative 'lib/Player'
require_relative 'levels/Level'
require_relative 'lib/terain/Ground'
require_relative 'lib/support/bounding_box'

class Game <Gosu::Window
  SCREEN_WIDTH = 1088
  SCREEN_HEIGHT = 1024

  def initialize
    super(SCREEN_WIDTH, SCREEN_HEIGHT, false)

    @ground = Level.new(self)

  end

end

Game.new.show
