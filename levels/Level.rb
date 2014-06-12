class Level
  attr_reader :ground, :tile
  def initialize(window)
    @window = window
    @tile = Gosu::Image.new(@window,"media/tile.png", true)
    @ground = make_ground(20)
  end

  def make_ground(length)
    ground = []
    #x = start location for each item
    x = 0
    y = 672
    15.times do #66 64
      ground << Ground.new(@window, x, y, @tile.width, @tile.height )
      x += @tile.width
    end
    return ground
  end

  def draw
    @ground.each do |peice|
      peice.draw(@tile )
      #binding.pry
      if @window.testing
        @window.draw_rect(peice.x, peice.y, peice.width, peice.height)
      end
    end
  end


end
