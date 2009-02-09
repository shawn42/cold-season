
require "physical_circle"
class FlowBit < PhysicalCircle
  attr_accessor :image
  attr_accessor :orig_image
  def initialize(space, img)
    @orig_image = img
    opts = {
      :radius => 10,
      :mass => 8,
      :friction => 1,
      :space => space,
      :location => vec2(rand_x,rand_y)
    }
    super(opts)

    @visible = (rand(6) == 0)
    @image = img.rotozoom(90,1)
  end

  def rand_x
    rand(6800)-2000
  end

  def rand_y
    rand(800)+30
  end

  def kill_self
    @space.remove_body(@body)
    @space.remove_shape(@shape)
  end

  def draw?
    @visible == true
  end
end
