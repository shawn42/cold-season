require 'chipmunk'
ZeroVec2 = vec2(0,0)
class Float
  Infinity = 1.0/0.0
end

class Simulation
  include CP
  attr_reader :space
  
  GRAVITY = 9
  DAMPING = 0.7

  def initialize
    @space = Space.new
    @space.iterations = 5
    @space.damping = DAMPING
    @space.gravity = vec2(0,GRAVITY)
  end

end