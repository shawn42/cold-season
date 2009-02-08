class Terrain
  attr_reader :vertices
  constructor :vertices, :segments, :space do
    @color = 0xff336633
    color =0xff336633 
    @top_color = color
    @bottom_color = 0xff333300
    @bottom = 800
  end

#  def draw(info)
#    @vertices.each_segment do |a,b|
#      a = info.view_point(a)
#      b = info.view_point(b)
#
#      info.window.draw_quad(
#        a.x,a.y, @top_color,
#        b.x,b.y, @top_color,
#        a.x,@bottom, @bottom_color,
#        b.x,@bottom, @bottom_color,
#        ZOrder::Terrain)
#    end
#  end

  def remove_from_space
    @segments.each do |s|
      @space.remove_shape(s)
    end
  end
end
