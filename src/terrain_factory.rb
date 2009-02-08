require 'terrain'

class TerrainFactory
  constructor :svg_loader

  def load_from_file(file,space,layer="ground")
    g = @svg_loader.get_layer_from_file(file, "ground")
    build_from_vertices(g.path.vertices, space)
  end

  def build_from_vertices(vertices, space)
    moment_of_inertia,mass = Float::Infinity,Float::Infinity
    terrain_body = CP::Body.new(mass,moment_of_inertia)
    elasticity = 0.1
    friction = 0.7
    thickness = 0.5
    segments = []
    vertices.each_cons(2) do |a,b|
      seg = CP::Shape::Segment.new(terrain_body, a,b, thickness)
      seg.collision_type = :terrain
      seg.e = elasticity
      seg.u = friction
      seg.group = :terrain
      segments << seg
      space.add_shape(seg)
    end
    Terrain.new(:vertices => vertices, :segments => segments, :space => space)
  end
end
