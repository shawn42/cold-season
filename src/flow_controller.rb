require 'flow_bit'
class FlowController
  attr_accessor :bits
  constructor :resource_manager

  def setup
    @bits = []
  end

  def setup_bits(sim)
    @img = @resource_manager.load_image("air_bubble.png")
    35.times do
      @bits << FlowBit.new(sim.space, @img)
    end

  end

  def update(time)
    # TODO: flow the bits
    for bit in @bits
      # check bounds
      loc = bit.body.p
      if loc.x < 30
        bit.body.p = vec2(780,loc.y)
      end

      # apply force
      bit.body.apply_impulse vec2(-30*rand(4)+1*time,rand(2)-1), ZeroVec2
    end
  end

end
