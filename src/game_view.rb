class GameView < Container

  #constructor :level_manager, :resource_manager

  def initialize(args)
    super(args)

    @level_manager = args[:level_manager]
    @resource_manager = args[:resource_manager]
    @green = GooColor.color(:green,255)
    
    @score_label = Label.new "0"
    add @score_label
  end

  def update(time)
    # this would be from animations/etc in the gui only
   
    # TODO: change this to be event driven
    score = @level_manager.level.bacteria.score.to_s
    @score_label.set_text score unless score == @score_label.instance_variable_get('@text')
  end

  def radians_to_deg(rad); rad * 180.0 / Math::PI + 90; end

  def draw_cell(cell, adapter)
    loc = cell.body.p
    deg = -radians_to_deg(cell.body.a)
    img = cell.orig_image.rotozoom(deg,1,true)
    cell.image = img
    w = img.size[0]
    h = img.size[1]
    adapter.draw_image(cell.image, loc.x-w/2, loc.y-h/2)

  end

  def draw(adapter)
    adapter.draw_image(@level_manager.level.background_image, 0, 0)
    level = @level_manager.level
    bacteria = level.bacteria
    draw_cell bacteria, adapter
    
    for cell in @level_manager.healthy_cell_controller.cells
      draw_cell cell, adapter
    end

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