require "physical_circle"
class Bacteria < PhysicalCircle
  attr_accessor :image, :score
  attr_accessor :orig_image
  def initialize(space, img)
    @orig_image = img
    opts = {
      :radius => 45,
      :mass => 45,
      :friction => 0.01,
      :space => space,
      :location => vec2(100,300)
    }
    super(opts)

    @score = 0
    @image = img.rotozoom(90,1)
  end

end
