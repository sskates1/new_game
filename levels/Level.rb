class Level
  def initialize(window)
    @window = window
    @ground = make_ground(20)
    @tile = Gosu::Image.new(@window,"lib/tile.png", true)
  end

  def make_ground(length)
    ground = []
    #x = start location for each item
    x = 0
    y = 0
    17.times do
      ground << Ground.new(@window, x, y, 75, 50 )
      x += @tile.width
    end
  end

end
