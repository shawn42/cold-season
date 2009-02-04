require 'level'
require 'simulation'
require 'bacteria'

class LevelManager
  attr_reader :level
  constructor :resource_manager, :bacteria_controller

  def start
    @level = Level.new
    @level.background_image = @resource_manager.load_image("level1_bg.png")

    @simulation = Simulation.new
    @level.simulation = @simulation

    @level.build_segments
    bacteria = Bacteria.new @simulation.space, @resource_manager.load_image("bacteria.png")
    
    @level.bacteria = bacteria
    @bacteria_controller.bacteria = bacteria
  end

  def update(time)
    @bacteria_controller.update time
    @simulation.space.step time
  end
end
