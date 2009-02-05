
require "physical_circle"
class WhiteCell < PhysicalCircle
  attr_accessor :image
  attr_accessor :orig_image
  def initialize(space, img)
    @orig_image = img
    opts = {
      :radius => 45,
      :mass => 30,
      :friction => 2,
      :space => space,
      :location => vec2(rand(700)+40,rand(600)+40)
    }
    super(opts)


    @image = img.rotozoom(90,1)
  end

  def kill_self
    puts "AH #{self.object_id} died"
    @space.remove_body(@body)
    @space.remove_shape(@shape)
  end
end
