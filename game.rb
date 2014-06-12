require 'gosu'
require 'pry'
require_relative 'lib/Player'
require_relative 'levels/Level'
require_relative 'lib/terain/Ground'
require_relative 'lib/support/bounding_box'

class Game <Gosu::Window
  SCREEN_WIDTH = 1024
  SCREEN_HEIGHT = 768



  def initialize
    super(SCREEN_WIDTH, SCREEN_HEIGHT, false)

    @level = Level.new(self)
    #@background = Gosu::Image.new(self, "tiles/bg2.png", true)

    @testing = true
  end

  def update

  end

  def draw
    #draw_rect(0, 0, screen_width, screen_height, Gosu::Color::BLACK)
    @level.ground.each do |peice|
      peice.draw(@level.tile )
      #binding.pry
      if @testing
        draw_rect(peice.x, peice.y, peice.width, peice.height, 0xff0000ff)
      end
    end
  end

  def draw_rect(x, y, width, height, color, z = 10)
    #binding.pry
    #left side
    draw_line(x,y,color,x, y+height, color, z)
    #right side
    draw_line(x+width, y, color, x+width, y+height, color, z)
    #top
    draw_line(x,y,color,x+width, y, color, z)
    #bottom
    draw_line(x, y+height, color, x+width, y+height, color, z)
    # draw_quad(x, y, color,
    #   x + width, y, color,
    #   x + width, y + height, color,
    #   x, y + height, color, z)
  end

end

Game.new.show
