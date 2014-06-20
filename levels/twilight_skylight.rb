class Level
  attr_reader :scroll_x, :ground, :tile, :bg
  def initialize(window)
    @window = window
    @tile = Gosu::Image.new(@window,"media/ground_tile.png", true)
    @ground = make_ground(20)
    @bg = Gosu::Image.new(@window, "media/city_background.png", true)
    @x = 0
    @scroll_x = 0
  end

  def make_ground(length, scroll)
    ground = []
    #x = start location for each item
    x = 0
    y = 672
    10.times do #64 64
      ground << Ground.new(@window, x, y, @tile.width, @tile.height )
      x += @tile.width + @scroll_x
    end
    x += @tile.width*3 + @scroll_x
    ground << Ground.new(@window, x, y, @tile.width, @tile.height )

    return ground
  end

  def update(pan)
    if pan == 1
      @x = @x - 0.5
      @scroll_x = @scroll_x - 5
    elsif pan == 0
      @x = @x + 0.5
      @scroll_x = @scroll_x + 5
    end
  end

  def draw
    @bg.draw(@x, -35, 0)
    @ground.each do |peice|
      peice.draw(@tile)
      if @window.testing
        @window.draw_rect(peice.x, peice.y, peice.width, peice.height)
      end
    end
  end


end
