require 'white_cell'
class WhiteCellController
  attr_accessor :cells
  constructor :resource_manager

  def setup
    @cells = []
  end

  def setup_cells(sim)
    @img = @resource_manager.load_image("white_cell.png")
    1.times do
      @cells << WhiteCell.new(sim.space, @img)
    end

  end

  def update(time)
    power = 30*time


    for cell in @cells

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
