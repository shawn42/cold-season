require 'chipmunk'
require 'enumerator'

class Level
  include CP
  attr_accessor :simulation, :background_image, :bacteria, :segments, :terrain_verts, :time_remaining


  def initialize
    @segments = []
  end

  def build_segments
    moment_of_inertia,mass = Float::Infinity,Float::Infinity
    elasticity = 0.1
    friction = 0.7
    thickness = 0.5
    @terrain_body = Body.new(mass,moment_of_inertia)
#    @terrain_verts = [[0,600],[800,700]]
    @terrain_verts = [vec2(20,600),vec2(1800,601),vec2(1800,25),vec2(20,25),vec2(20,600)]
#    @terrain_verts.each_segment do |a,b|

    @terrain_verts.each_cons(2) do |point|
      a,b = point[0],point[1]
      seg = Shape::Segment.new(@terrain_body, a,b, thickness)
      seg.collision_type = :terrain
      seg.e = elasticity
      seg.u = friction
      @segments << seg
      @simulation.space.add_shape(seg)
    end
  end

  def update(time)
    @time_remaining -= time
  end
end
