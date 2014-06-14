require 'gosu'
require 'pry'

class Player
  attr_accessor :hit_box, :x, :y, :direction, :x_vel, :y_vel
  attr_reader :width, :height
	def initialize(window, x, y)
    @window = window
	  #@face_right = Gosu::Image.new(@window, "media/tifa_stand_right.png", true)
    #@face_left = Gosu::Image.new(@window, "media/tifa_stand.png", true)
    @stand = Gosu::Image.new(@window, "media/tifa_stand.png", true)
    @walk = []
    8.times do |i|
      @walk << Gosu::Image.new(@window, "media/tifa_walk/tifa_#{i+1}.png", true)
    end
    @x = x
    @y = y
    @width = 29
    @height = 62
    @hit_box = BoundingBox.new(@x,@y, @width,@height)
    @direction = :stand
    @movement = 0
    @in_air = true
    @y_vel = 0
    @x_vel = 0
    @move = 0
  end

  def move_left
    @direction = :left
    if @x_vel <= -3
      @x_vel = -3
    else
      @x_vel += -1
    end
    @x = @x+@x_vel
    @hit_box.x = @x

    @move += 1
    if @move > 34 then @move = 1 end
  end

  def move_right
    @direction = :right
    if @x_vel <= +3
      @x_vel = +3
    else
      @x_vel += +1
    end
    @x = @x+@x_vel
    @hit_box.x = @x
    @move += 1
    if @move > 34 then @move = 1 end
  end

  def jump
    @y_vel += -4
    @y = @y+@y_vel
    @hit_box.y = @y
  end

  def on_ground()
    #check to see if you colide with ground
    #binding.pry
    @in_air = true
    @window.level.ground.each do |peice|
      if collide?(peice)
        @y_vel = 0
        @in_air = false
        @y = peice.hit_box.top - @height
        @hit_box.y = peice.hit_box.top - @height
      end
    end

    #falling down
    if @in_air
      #acceleration and terminal velocity
      if @y_vel >= 6
        @y_vel = 6
      else
        @y_vel = @y_vel+@window.gravity
      end

      #update position of character
      @y = @y+@y_vel
      @hit_box.y = @y
    else #when on ground
    end
  end

  def collide?(peice)
    #check to see if they are coliding in the y direction
    if (((@hit_box.bottom >= peice.hit_box.top && @hit_box.bottom <= peice.hit_box.bottom )||
        (@hit_box.top <= peice.hit_box.bottom && @hit_box.top >= peice.hit_box.top )
        ) &&
        #check to make sure they are over said block
        ((@hit_box.left < peice.hit_box.right && @hit_box.left > peice.hit_box.left) ||
        (@hit_box.right > peice.hit_box.left && @hit_box.right < peice.hit_box.right)
        ))
      return true
    else
      return false
    end
  end

  def update(window)

    if window.button_down?(Gosu::KbLeft)
      self.move_left()
    elsif window.button_down?(Gosu::KbRight)
      self.move_right()
    end

    self.on_ground()

    if window.button_down?(Gosu::KbSpace)
      if !@in_air
        self.jump()
        @in_air = true
      end
    end

    # if button_down?(Gosu::KbSpace)
    #   if state == :running
    #     @player.jump(@tower.speed)
    #   end
    # end
  end

  def draw(move)
    #binding.pry
  	if @direction == :stand
  		@stand.draw(@x, @y, 1)
  	elsif @direction == :left
      frame = ((move - 1) / 3)
      @walk[frame].draw(@x, @y, 1)
    elsif @direction == :right
      frame = ((move - 1) / 3)
      @walk[frame].draw(@x+@width, @y, 1, -1, 1)
    end

    if @window.testing
      @window.draw_rect(@hit_box.x,@hit_box.y,@width, @height)
    end
  end
end



#draw(x, y, z, factor_x = 1, factor_y = 1, color = 0xffffffff, mode = :default)
#draw_rot(x, y, z, angle, center_x = 0.5, center_y = 0.5, factor_x = 1, factor_y = 1, color = 0xffffffff, mode = :default)
