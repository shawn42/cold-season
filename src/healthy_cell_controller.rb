require 'healthy_cell'
class HealthyCellController
  attr_accessor :cells, :avoid
  constructor :resource_manager

  def setup
    @cells = []
  end

  def setup_cells(sim)
    18.times do
      @cells << HealthyCell.new(sim.space, @resource_manager.load_image("red_cell.png"))
    end

  end

  def update(time)
    power = 30*time


    for cell in @cells
      # only avoid sometimes

      dist = (cell.body.p - @avoid.body.p).length if @avoid
      if dist and dist < 300
        # TODO: this is overly simple and not correct
        cell.body.apply_impulse @avoid.body.v.perp+vec2(rand(50),rand(50))*power, ZeroVec2
        #cell.body.apply_impulse -@avoid.body.v+vec2(rand(50),rand(50))*power, ZeroVec2
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
          cell.body.w -= power
        end

        if @move_right
          cell.body.w += power
        end

        if @move_back
          cell.body.apply_impulse(-cell.body.rot*power*1000, ZeroVec2)
        end

        if @move_forward
          cell.body.apply_impulse cell.body.rot*power*1000, ZeroVec2
        end
      end
    end


  end

end
