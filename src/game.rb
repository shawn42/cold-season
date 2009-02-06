class Game
  STEP_SIZE = 20

  constructor :wrapped_screen, :input_manager, :level_manager, :game_view

  def setup()
    factory = Rubygoo::AdapterFactory.new
    @render_adapter = factory.renderer_for :rubygame, @wrapped_screen.screen
    @gui = Rubygoo::App.new :renderer => @render_adapter, :theme => 'cold_season',
      :data_dir => "#{DATA_PATH}/themes", :mouse_cursor => false

    # get levels?
    @level_manager.start

    @gui.add @game_view
    @app_adapter = factory.app_for :rubygame, @gui

    @input_manager.when :event_received do |evt|
      case evt
      when KeyUpEvent
        @playing = true
      end
      @app_adapter.on_event evt
    end
    @wrapped_screen.show_cursor = false
  end

  def update(time)
    steps = (time / STEP_SIZE).ceil
    steps.times do 
      @gui.update STEP_SIZE
      update_simulation STEP_SIZE/1000.0
    end

    @gui.draw @render_adapter
  end

  def update_simulation(time)
    # TODO update the physics
    @level_manager.update time if @playing
  end

end
