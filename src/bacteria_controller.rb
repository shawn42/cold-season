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
  #  def radians_to_gosu(rad); rad * 180.0 / Math::PI + 90; end

  def update(time)
    power = 8*time
    if @move_left
      @bacteria.body.a -= power
      @bacteria.body.w -= power/2
      #        deg = radians_to_gosu(@bacteria.body.a)
      #        p "L:#{deg}"
      #        @bacteria.image = @bacteria.orig_image.rotozoom(-deg,1,true)
    end

    if @move_right
      @bacteria.body.a += power
      @bacteria.body.w += power/2
      #        deg = radians_to_gosu(@bacteria.body.a)
      #        p "R:#{deg}"
      #        @bacteria.image = @bacteria.orig_image.rotozoom(deg,1,true)
    end

    if @move_back
      @bacteria.body.apply_impulse(-@bacteria.body.rot*power*3000, ZeroVec2)
    end

    if @move_forward
      @bacteria.body.apply_impulse @bacteria.body.rot*power*10000, ZeroVec2
    end

    #@bacteria.body.w = @bacteria.body.w * 50*time
    

  end
end

  
