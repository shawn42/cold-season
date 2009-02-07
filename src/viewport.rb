class Viewport
  attr_accessor :x, :y, :width, :height

  constructor :config_manager do
    @x = 0.0
    @y = 0.0
    @width,@height = @config_manager[:screen_resolution]
  end

  def offset_x(x)
    x - @x
  end
  alias_method :ox, :offset_x

  def offset_y(y)
    y - @y
  end
  alias_method :oy, :offset_y

  def offset_point(pt)
    pt - vec2(@x,@y)
  end

end
