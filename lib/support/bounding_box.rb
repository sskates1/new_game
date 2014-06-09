class BoundingBox
  attr_reader :width, :height
  attr_accessor :x, :y

  def initialize(xstart,ystart,width,height)
    @x = xstart
    @y = ystart
    @width = width
    @height = height
  end

  def left
    @x
  end

  def right
    @x+@width
  end

  def bottom
    @y
  end

  def top
    @y+height
  end

  def contains_point?(x,y)
    if x >= left && x <= right && y >= bottom && y <= top
      true
    else
      false
    end
  end

end
