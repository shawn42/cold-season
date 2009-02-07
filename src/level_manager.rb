require 'level'
require 'simulation'
require 'bacteria'

class LevelManager
  attr_reader :level, :healthy_cell_controller, :flow_controller, :white_cell_controller
  constructor :resource_manager, :bacteria_controller, :healthy_cell_controller,
    :flow_controller, :white_cell_controller, :viewport_controller

  def start
    @level = Level.new
    @level.background_image = @resource_manager.load_image("level1_bg.png")

    @simulation = Simulation.new
    @level.simulation = @simulation

    # in seconds
    @level.time_remaining = 60

    @level.build_segments
    bacteria = Bacteria.new @simulation.space, @resource_manager.load_image("bacteria.png")

    @level.bacteria = bacteria
    @viewport_controller.follow_target = bacteria
    @viewport_controller.focus bacteria.body.p
    @bacteria_controller.bacteria = bacteria

    
    @healthy_cell_controller.setup_cells @simulation
    @flow_controller.setup_bits @simulation
    @white_cell_controller.setup_cells @simulation

  end

  def update(time)
    @bacteria_controller.update time
    @healthy_cell_controller.update time
    @white_cell_controller.update time
    @flow_controller.update time
    @viewport_controller.update time
    @simulation.space.step time
    @level.update time

    bacteria = @bacteria_controller.bacteria
    # TODO: WHERE SHOULD THIS GO?
    cells_to_kill = []
    for cell in @healthy_cell_controller.cells
#      cell_loc = cell.body.p
#      bacteria_loc = bacteria.body.p
#
#      dist = Math.sqrt((cell_loc.x-bacteria_loc.x)*(cell_loc.x-bacteria_loc.x)+(cell_loc.y-bacteria_loc.y)*(cell_loc.y-bacteria_loc.y))
#
#      cells_to_kill << cell if dist < 100
      cells_to_kill << cell if bacteria.shape.bb.intersect? cell.shape.bb
    end
    for cell in cells_to_kill
      bacteria.score += 50
      @healthy_cell_controller.cells.delete cell
      cell.kill_self

      finish_level if @healthy_cell_controller.cells.empty?
    end

    for cell in @white_cell_controller.cells
      fail_level if bacteria.shape.bb.intersect? cell.shape.bb
    end

    fail_level if @level.time_remaining <= 0
    
  end

  def fail_level
    puts "YOU SUCK"
    throw :rubygame_quit
  end

  def finish_level
    bacteria = @bacteria_controller.bacteria
    bacteria.score += @level.time_remaining.to_i
    puts "YAY, YOU WON WITH A SCORE OF [#{bacteria.score}]"
    throw :rubygame_quit
  end
end
