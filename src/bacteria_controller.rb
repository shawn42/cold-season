class BacteriaController
  attr_accessor :bacteria
  constructor :input_manager
  def setup
    @input_manager.when :event_received do |event|
      case event
      when KeyDownEvent
        case event.key
        when K_LEFT
          @move_left = true
        when K_RIGHT
          @move_right = true
        when K_UP
          @move_forward = true
        when K_DOWN
          @move_back = true
        when K_R
          @reset = true
        end
      when KeyUpEvent
        case event.key
        when K_LEFT
          @move_left = false
        when K_RIGHT
          @move_right = false
        when K_UP
          @move_forward = false
        when K_DOWN
          @move_back = false
        end
      end
    end
  end

  def update(time)
    power = 6*time
    if @move_left
      @bacteria.body.a -= power
      @bacteria.body.w -= power/2 if @bacteria.body.w > 2
    end

    if @move_right
      @bacteria.body.a += power
      @bacteria.body.w += power/2 if @bacteria.body.w < 2
    end

    if @move_back
      @bacteria.body.apply_impulse(-@bacteria.body.rot*power*4000, ZeroVec2) if @bacteria.body.v.length > 400
    end

    if @move_forward
      @bacteria.body.apply_impulse @bacteria.body.rot*power*12000, ZeroVec2 if @bacteria.body.v.length < 600
    end
  end
end

  
