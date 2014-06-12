class Ground
  attr_accessor :x, :y, :width, :height, :hit_box
  def initialize(window, x,y, width, height)
    @window = window
    @x = x
    @y = y
    @width = width
    @height = height
    @hit_box = BoundingBox.new(x,y,width,height)
  end

  def draw(tiles)
    tiles.draw(@x, @y, 1)
  end

end
