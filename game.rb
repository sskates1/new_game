require 'gosu'
require 'pry'
require_relative 'lib/Player'
require_relative 'levels/Level'
require_relative 'lib/terain/Ground'
require_relative 'lib/support/bounding_box'

class Game <Gosu::Window
  attr_accessor :testing, :gravity, :level

  SCREEN_WIDTH = 1024
  SCREEN_HEIGHT = 768



  def initialize
    super(SCREEN_WIDTH, SCREEN_HEIGHT, false)

    @level = Level.new(self)
    @player = Player.new(self, 250,250)
    #@background = Gosu::Image.new(self, "tiles/bg2.png", true)

    @testing = true
    @gravity = 0.1
  end

  def update

    # if button_down?(Gosu::KbT) && @testing
    #   @testing = false
    # elsif button_down?(Gosu::KbT)&& !@testing
    #   @testing = true
    # end

    if button_down?(Gosu::KbEscape)
      close
    end
    @player.update(self)

  end

  def draw
    #draw_rect(0, 0, screen_width, screen_height, Gosu::Color::BLACK)
    @player.draw
    @level.draw
  end

  def button_down(id)
    if id == (Gosu::KbT)
      @testing == true ? @testing = false : @testing = true
    end
  end

  def draw_rect(x, y, width, height, color = 0xff0000ff, z = 10)
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
