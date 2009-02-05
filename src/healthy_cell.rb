
require "physical_circle"
class HealthyCell < PhysicalCircle
  attr_accessor :image
  attr_accessor :orig_image
  def initialize(space, img)
    @orig_image = img
    opts = {
      :radius => 30,
      :mass => 20,
      :friction => 2,
      :space => space,
      :location => vec2(700,rand(500)+100)
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
