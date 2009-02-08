
require "physical_circle"
class WhiteCell < PhysicalCircle
  attr_accessor :image
  attr_accessor :orig_image
  def initialize(space, img)
    @orig_image = img
    opts = {
      :radius => 20,
      :mass => 30,
      :friction => 2,
      :space => space,
      :location => vec2(rand(300)+400,rand(400)+40)
    }
    super(opts)


    @image = img.rotozoom(90,1)
  end

  def kill_self
    @space.remove_body(@body)
    @space.remove_shape(@shape)
  end
end
