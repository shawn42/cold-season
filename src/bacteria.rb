require "physical_circle"
class Bacteria < PhysicalCircle
  attr_accessor :image
  attr_accessor :orig_image
  def initialize(space, img)
    @orig_image = img
    opts = {
      :radius => 45,
      :mass => 45,
      :friction => 0.1,
      :space => space,
      :location => vec2(200,200)
    }
    super(opts)


    @image = img.rotozoom(90,1)
  end
end
