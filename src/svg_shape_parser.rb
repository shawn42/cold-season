class SvgShapeParser
  def path_to_polygon(path, opts={})
    if path.nil? or path.vertices.nil? or path.vertices.size < 3
      raise "Can't convert SVG path to Polygon: #{path.inspect}"
    end
    verts = path.vertices

    # SVG drawing may use closed path, which repeats the point of closure... we don't require the repeat
    if verts.first == verts.last
      verts.pop
    end

    Polygon.new(verts)
  end

  def path_to_unclosed_polygon(path)
    if path.nil? or path.vertices.nil?
      raise "Can't convert SVG path to Polygon: #{path.inspect}"
    end
    Polygon.new(path.vertices)
  end

end
