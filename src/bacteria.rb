require 'actor'

class Bacteria < Actor
  has_behaviors :graphical, :updatable, :physical => {
    :shape => :circle,
    :mass => 45,
    :radius => 45,
    :friction => 1.7,
    :moment => 410 
  }

  attr_accessor :move_left, :move_right, :move_forward, :move_back
  def setup
    super
    @speed = 900
    @turn_speed = 550

    i = input_manager
    i.while_key_pressed(:left,self,:move_left)
    i.while_key_pressed(:right,self,:move_right)
    i.while_key_pressed(:up,self,:move_forward)
    i.while_key_pressed(:down,self,:move_back)

  end

  def update(time)
    physical.body.reset_forces

    if move_left
      physical.body.t -= @turn_speed * time
    end

    if move_right
      physical.body.t += @turn_speed * time
    end

    if move_back
      val = physical.body.a
      move_vec = CP::Vec2.new(Math::cos(val), Math::sin(val)) * time * @speed * 0.5

      physical.body.apply_force(-move_vec, ZERO_VEC_2) 
    end

    if move_forward
      val = physical.body.a
      move_vec = CP::Vec2.new(Math::cos(val), Math::sin(val)) * time * @speed

      physical.body.apply_force(move_vec, ZERO_VEC_2) 
    end
  end
end

  
