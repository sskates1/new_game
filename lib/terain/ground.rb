class Ground
  attr_accessor :x, :y, :hit_box
  def initialize(window, x,y, width, hight)
    @window = window
    @x = x
    @y = y
    @hit_box = BoundingBox.new(x,y,width,hight)
  end

  def draw(tiles)
    tiles.draw(@x, @y, 1)
  end
end
