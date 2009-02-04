class GameView < Widget

  #constructor :level_manager, :resource_manager

  def initialize(args)
    @level_manager = args[:level_manager]
    @resource_manager = args[:resource_manager]
    @green = GooColor.color(:green,255)
    super()
  end

  def update(time)
    # this would be from animations/etc in the gui only
  end

  def radians_to_gosu(rad); rad * 180.0 / Math::PI + 90; end

  def draw(adapter)
    adapter.draw_image(@level_manager.level.background_image, 0, 0)
    level = @level_manager.level
    bacteria = level.bacteria
    loc = bacteria.body.p

    deg = radians_to_gosu(bacteria.body.a)
    bacteria.image = bacteria.orig_image.rotozoom(-deg,1,true)

    adapter.draw_image(bacteria.image, loc.x, loc.y)

    level.terrain_verts.each_cons(2) do |seg|
      p1,p2 = *seg
      adapter.fill(p1.x,p1.y,p2.x,p2.y+1,@green)
    end

#    fc = @level_manager.flow_controller
#    for bit in fc.bits
#      loc = bit.body.p
#      adapter.draw_image(bit.image, loc.x, loc.y)
#      # draw bit
#    end
    
  end


end