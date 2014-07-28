require 'gosu'
require 'pry'

class Player
  attr_accessor :hit_box, :x, :y, :direction, :x_vel, :y_vel
  attr_reader :width, :height
	def initialize(window, x, y)
    @window = window
    @stand = Gosu::Image.new(@window, "media/tifa_stand.png", true)
    @jump = Gosu::Image.new(@window, "media/tifa_walk/tifa_3.png", true)
    @jump_jump = Gosu::Image.new(@window, "media/tifa_walk/tifa_5.png", true)
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
    @move = 1
    @double_jump = false
    @second_jump = false
    @second_jump_animation = false
  end

  def move_left
    @direction = :left
    colide = false
    @window.level.ground.each do |peice|
      if horizontal_collide?(peice, @x_vel)
        @x_vel = 0
        @x = peice.hit_box.right+3.1
        @hit_box.x = peice.hit_box.right+3.1
        colide = true
      end
    end
    if !colide
      if @x_vel <= -3
        @x_vel = -3
      else
        @x_vel += -1
      end
      @x = @x+@x_vel
      @hit_box.x = @x
    end
    @move += 0.2
    if @move > 8 then @move = 1 end
  end

  def move_right
    @direction = :right
    colide = false
    @window.level.ground.each do |peice|
      if horizontal_collide?(peice, @x_vel)
        @x_vel = 0
        @x = peice.hit_box.left - @width-3.1
        @hit_box.x = peice.hit_box.left - @width-3.1
        colide = true
      end
    end
    if !colide
      if @x_vel <= +3
        @x_vel = +3
      else
        @x_vel += +1
      end
      @x = @x+@x_vel
      @hit_box.x = @x
    end
    @move += 0.2
    if @move > 8 then @move = 1 end
  end

  def jump
      @y_vel += -6
      @y = @y+@y_vel
      @hit_box.y = @y
      @double_jump = true
  end

  def double_jump
    @y_vel = 0
    @y_vel += -4
    @y = @y+@y_vel
    @hit_box.y = @y
    @double_jump = false
    @second_jump = false
    @second_jump_animation = true
  end

  def on_ground()
    @in_air = true
    @window.level.ground.each do |peice|
      if vertical_collide?(peice, @y_vel)
        @y_vel = 1
        @in_air = false
        @double_jump = false
        @second_jump = false
        @second_jump_animation = false
        @y = peice.hit_box.top - @height - 1
        @hit_box.y = peice.hit_box.top - @height - 1
      end
    end

    if @in_air
      if @y_vel >= 6
        @y_vel = 6
      else
        @y_vel = @y_vel+@window.gravity
      end

      @y = @y+@y_vel
      @hit_box.y = @y
    end
  end

  def vertical_collide?(peice, y_vel)
    if (((@hit_box.bottom + y_vel >= peice.hit_box.top && @hit_box.bottom + y_vel <= peice.hit_box.bottom ) ||
        (@hit_box.top + y_vel <= peice.hit_box.bottom && @hit_box.top + y_vel >= peice.hit_box.top )) &&
        ((@hit_box.left < peice.hit_box.right && @hit_box.left > peice.hit_box.left) ||
        (@hit_box.right-3 > peice.hit_box.left && @hit_box.right < peice.hit_box.right)))
      return true
    else
      return false
    end
  end

  def horizontal_collide?(peice, x_vel)
    if @direction ==  :right
      if (((@hit_box.bottom > peice.hit_box.top && @hit_box.bottom < peice.hit_box.bottom ) ||
          (@hit_box.top < peice.hit_box.bottom && @hit_box.top > peice.hit_box.top )) &&
          #((@hit_box.left - 1 + x_vel < peice.hit_box.right && @hit_box.left - 1 + x_vel > peice.hit_box.left) ||
          (@hit_box.right + x_vel > peice.hit_box.left && @hit_box.right+ x_vel < peice.hit_box.right))
        return true
      end
    elsif @direction ==  :left
      if (((@hit_box.bottom > peice.hit_box.top && @hit_box.bottom < peice.hit_box.bottom ) ||
          (@hit_box.top < peice.hit_box.bottom && @hit_box.top > peice.hit_box.top )) &&
          (@hit_box.left + x_vel < peice.hit_box.right && @hit_box.left + x_vel > peice.hit_box.left)) #||
          #(@hit_box.right + 1 + x_vel > peice.hit_box.left && @hit_box.right + 1 + x_vel < peice.hit_box.right)))
        return true
      end
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
        self.jump
        @in_air = true
      end
    end

    if window.button_down?(Gosu::KbSpace) == false && @double_jump == true
      if @in_air == true
        @second_jump = true
      end
    end

    if window.button_down?(Gosu::KbSpace)
      if @second_jump == true
        self.double_jump
      end
    end
  end

  def draw
    if @second_jump_animation == true && @direction == :left && @in_air == true
      @jump_jump.draw(@x, @y, 1)
    elsif @second_jump_animation == true && @direction == :right && @in_air == true
      @jump_jump.draw(@x + @width, @y, 1, -1, 1)
    else
      if @in_air == true && @direction == :left
        @jump.draw(@x, @y, 1)
      elsif @in_air == true && @direction == :right
        @jump.draw(@x + @width, @y, 1, -1, 1)
      else
      	if @direction == :stand
      		@stand.draw(@x, @y, 1)
      	elsif @direction == :left
          frame = ((@move - 1) / 1)
          @walk[frame].draw(@x, @y, 1)
        elsif @direction == :right
          frame = ((@move - 1) / 1)
          @walk[frame].draw(@x+@width, @y, 1, -1, 1)
        end
      end
    end

    if @window.testing
      @window.draw_rect(@hit_box.x,@hit_box.y,@width, @height)
    end
  end
end
