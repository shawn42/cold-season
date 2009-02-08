class Terrain
  attr_reader :vertices
  constructor :vertices, :segments, :space do
    @color = 0xff336633
    color =0xff336633 
    @top_color = color
    @bottom_color = 0xff333300
    @bottom = 800
  end

  def remove_from_space
    @segments.each do |s|
      @space.remove_shape(s)
    end
  end
end
