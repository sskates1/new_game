
def level1(window)
  twilight_tile = Gosu::Image.new(window,"media/ground_tile.png", true)
  twilight_background = Gosu::Image.new(window, "media/city_background.png", true)
  ground = []
  x = 0
  y = 672
  10.times do #64 64
    ground << Ground.new(window, x, y, twilight_tile.width, twilight_tile.height )
    x += twilight_tile.width
  end

  x += twilight_tile.width*3

  ground << Ground.new(window, x, y, twilight_tile.width, twilight_tile.height )

  ground << Ground.new(window, 0, 608, twilight_tile.width, twilight_tile.height)

  ground << Ground.new(window, 250, 608, twilight_tile.width, twilight_tile.height)

  level = Level.new(window, twilight_background, twilight_tile, ground)

  return level
end
