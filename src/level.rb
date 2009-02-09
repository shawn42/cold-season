require 'chipmunk'
require 'enumerator'

class Level
  include CP
  attr_accessor :simulation, :background_image, :bacteria, :segments, 
    :terrain_verts, :time_remaining, :terrain, :bg_color


  def initialize
    @bg_color = GooColor.new(22,222,11,255)
  end

  def update(time)
    @time_remaining -= time
  end
end
