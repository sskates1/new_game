class Level
  attr_reader :ground, :tile, :bg
  def initialize(window, bg, tile, ground)
    @window = window
    @tile = tile
    @ground = ground
    @bg = bg
    @x = -100
  end

  def update(pan)
    if pan == 1
      @x = @x - 0.5
    elsif pan == 0
      @x = @x + 0.5
    end
  end

  def draw
    @bg.draw(@x, -35, 0)

    @ground.each do |peice|
      peice.draw(@tile )
      if @window.testing
        @window.draw_rect(peice.x, peice.y, peice.width, peice.height)
      end
    end
  end
end
