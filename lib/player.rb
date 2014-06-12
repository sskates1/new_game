class Player
  attr_accessor :hit_box, :x, :y
  attr_reader :width, :height
	def initialize(window, x, y)
    @window = window
	  @face_right = Gosu::Image.new(@window, "media/tifa_stand_right.png", true)
    @face_left = Gosu::Image.new(@window, "media/tifa_stand.png", true)
    @stand = Gosu::Image.new(@window, "media/tifa_stand.png", true)
    @walk = []
    8.times do |i|
      @walkleft << Gosu::Image.new(@window, "media/tifa_walk/tifa_#{i+1}.png", true)
    end
    @x = x
    @y = y
    @width = 29
    @height = 62
    @hit_box = BoundingBox.new(@x,@y, @width,@height)
    @direction = :stand
  end

  def move_left
    direction = -1
  end

  def move_right
    direction = 1
  end

  def jump

  end

  def on_ground()

  end

  def draw
  	if @direction == :stand
  		@stand.draw(@x, @y,1)
  	elsif @direction == :left
  		num = ((movement - 1) / 3)
      @walkleft[num].draw(@x, @y,1)
    elsif @direction == :face_right
    	num = ((movement - 1) / 3)
    	@walkleft[num].draw_rot(@x, @y, center_x = 0.5, center_y = 0.5, factor_x = 1)
    end
    @window.draw_rect(@x,@y,@width, @height)
  end
end



#draw(x, y, z, factor_x = 1, factor_y = 1, color = 0xffffffff, mode = :default)
#draw_rot(x, y, z, angle, center_x = 0.5, center_y = 0.5, factor_x = 1, factor_y = 1, color = 0xffffffff, mode = :default)
