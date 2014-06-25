require 'gosu'
require_relative 'lib/Player'
require_relative 'lib/level'
require_relative 'lib/terrain/Ground'
require_relative 'lib/support/bounding_box'

require_relative 'levels/level1'

class Game <Gosu::Window
  attr_accessor :testing, :gravity, :level

  def initialize
    super(1024, 768, false)


    @level = level1(self)
    @player = Player.new(self, 250,250)
    #@background = Gosu::Image.new(self, "tiles/bg2.png", true)
    @testing = true
    @gravity = 0.2
  end

  def update
    if button_down?(Gosu::KbEscape)
      close
    end

    @player.update(self)

    if button_down?(Gosu::KbRight)
      level.update(1)
    elsif button_down?(Gosu::KbLeft)
      level.update(0)
    end
  end

  def draw
    @player.draw
    @level.draw
  end

  def button_down(id)
    if id == (Gosu::KbT)
      @testing == true ? @testing = false : @testing = true
    end
  end

  def draw_rect(x, y, width, height, color = 0xff0000ff, z = 10)
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
