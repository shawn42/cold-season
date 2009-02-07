class ViewportController
  attr_accessor :follow_target

  constructor :viewport do 
    @follow_target = nil
  end

  def update(time)
    if @follow_target
#        pt = @follow_target.location + vec2(100,-200) # more space to the right
      pt = @follow_target.body.p
      focus pt
    end
  end

  def focus(pt)
    dest_x = pt.x - (@viewport.width / 2.0)
    dest_y = pt.y - (@viewport.height / 2.0)

#      puts "#{dest_x}, #{dest_y}"

    @viewport.x = dest_x
    @viewport.y = dest_y
  end
end
