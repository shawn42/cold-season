require 'actor'

class RedBloodcell < Actor
  has_behaviors :graphical, :updatable, :layered => {:layer => 2},
    :physical => {
    :shape => :circle,
    :mass => 10,
    :radius => 45,
    :friction => 1.7,
    :moment => 150 
  }

  def setup
    @bacteria = @opts[:bacteria]
  end

  # TODO change these to :avoid behavior vs :wander behavior
  def update(time)
    power = 0.08*time
    dist = (cell.body.p - @bacteria.body.p).length if @bacteria
    if dist and dist < 300
      # TODO: this is overly simple and not correct
      body.apply_impulse @bacteria.body.v.perp+vec2(rand(50),rand(50))*power, ZERO_VEC_2
    else
      #turn
      turn_ran = rand 3
      case turn_ran
      when 0
        @move_right = false
        @move_left = true
      when 1
        @move_left = false
        @move_right = true
      end

      #move
      move_ran = rand 3
      case move_ran
      when 0
        @move_back = false
        @move_forward = true
      when 1
        @move_forward = false
        @move_back = true
      end

      if @move_left
        body.w -= power
      end

      if @move_right
        body.w += power
      end

      if @move_back
        body.apply_impulse(-body.rot*power*300, ZERO_VEC_2)
      end

      if @move_forward
        body.apply_impulse body.rot*power*700, ZERO_VEC_2
      end
    end
  end
end
