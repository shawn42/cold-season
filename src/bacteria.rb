require "physical_circle"
class Bacteria < PhysicalCircle
  attr_accessor :image
  attr_accessor :orig_image
  def initialize(space, img)
    @orig_image = img
    opts = {
      :radius => 90,
      :mass => 90,
      :friction => 1,
      :space => space,
      :location => vec2(130,90)
    }
    super(opts)


    @image = img.rotozoom(-90,1)
  end
end
