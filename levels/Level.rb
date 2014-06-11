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
    y = 0
    17.times do
      ground << Ground.new(@window, x, y, 75, 50 )
      x += @tile.width
    end
    return ground
  end

end
