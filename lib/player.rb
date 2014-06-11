class Player
	def initialize()
	  @face_right = Gosu::Image.new(@window, "media/tifa_stand_right.png", true)
    @face_left = Gosu::Image.new(@window, "media/tifa_stand.png", true)
    @stand = Gosu::Image.new(@window, "media/tifa_stand.png", true)
    @walkleft = []
    8.times do |i|
      @walk << Gosu::Image.new(@window, "media/tifa_walk/tifa_#{i+1}.png", true)
    end
    @direction = :stand
  end

  def move_left

  end

  def move_right

  end

  def jump

  end

  def on_ground()

  end

  def draw
  	if @direction == :stand
  		@stand.draw
  	elsif @direction == :left
  		num = ((movement - 1) / 3)
      @walk[num].draw(x, y)
    elsif @direction == :face_right
    	num = ((movement - 1) / 3)
    	@walk[num].draw_rot(x, y, center_x = 0.5, center_y = 0.5, factor_x = 1)
    end
  end
end



#draw(x, y, z, factor_x = 1, factor_y = 1, color = 0xffffffff, mode = :default)
#draw_rot(x, y, z, angle, center_x = 0.5, center_y = 0.5, factor_x = 1, factor_y = 1, color = 0xffffffff, mode = :default)
