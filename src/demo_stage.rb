require 'physical_stage'
class DemoStage < PhysicalStage
  GRAVITY = 9
  DAMPING = 0.7

  def setup
    super

    space.iterations = 5
    space.damping = DAMPING
    space.gravity = vec2(0,GRAVITY)

    @svg_doc = resource_manager.load_svg @opts[:file]

    @score = create_actor :score, :x => 10, :y => 10
    @timer = create_actor :timer, :x => 610, :y => 10, :down_from => 60_000
    @timer.when :time_expired do
      sound_manager.play_sound :times_up

      # TODO add listeners for play_sound_finished?
      sleep 1
      fire :restart_stage 
    end

    create_actor :logo, :x => 10, :y => 660

    create_actor :background
    create_actor :mid_bubbles

    dynamic_actors = create_actors_from_svg @svg_doc

    create_actor :svg_actor, :name => :ground, :svg_doc => @svg_doc

    @bacteria = dynamic_actors[:bacteria]

    # TODO pull out into controller actor?
    @reds = []
    20.times do
      @reds << create_actor(:red_bloodcell, :x => rand(1500), :y => rand(900))
    end

    create_actor :white_bloodcell, :x => 220, :y => 400

    viewport.follow @bacteria

    space.add_collision_func(:bacteria, :white_bloodcell) do |b, wc|
      shippy = director.find_physical_obj b
      lose
    end

    space.add_collision_func(:bacteria, :red_bloodcell) do |b, rc|
      cell = director.find_physical_obj rc
      if cell.alive?
        sound_manager.play_sound :splat
        cell.remove_self 
        @score.score += 10
        @reds.delete cell
        win if @reds.empty?
      end
    end
  end

  def win
    sound_manager.play_sound :win
    fire :next_stage
  end

  def lose
    sound_manager.play_sound :fail
    fire :restart_stage
  end

  def curtain_up
    sound_manager.play_music :current_rider
  end

  def draw(target)
    target.fill [25,25,25,255]
    super
  end
end

