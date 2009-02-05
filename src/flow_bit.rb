
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
      :location => vec2(780,rand(600)+30)
    }
    super(opts)

    @visible = (rand(6) == 0)
    @image = img.rotozoom(90,1)
  end

  def kill_self
    puts "AH #{self.object_id} died"
    @space.remove_body(@body)
    @space.remove_shape(@shape)
  end

  def draw?
    @visible == true
  end
end
