require 'gosu'
require 'pry'
require_relative 'lib/Player'
require_relative 'levels/Level'
require_relative 'lib/terain/Ground'
require_relative 'lib/support/bounding_box'

class Game <Gosu::Window
  SCREEN_WIDTH = 1088
  SCREEN_HEIGHT = 1024

  def initialize
    super(SCREEN_WIDTH, SCREEN_HEIGHT, false)

    @level = Level.new(self)
    #@background = Gosu::Image.new(self, "tiles/bg2.png", true)

  end

  def update

  end

  def draw
    #draw_rect(0, 0, screen_width, screen_height, Gosu::Color::BLACK)
    @level.ground.each do |tile|
      tile.draw(@level.tile )
    end
  end

end

Game.new.show
