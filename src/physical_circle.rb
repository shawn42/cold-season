class PhysicalCircle
  attr_reader :body, :mass, :radius, :shape

  Defaults = {
    :location => ZeroVec2,
    :mass => 50,
    :friction => 0.7,
    :elast => 0.1,
    :z_order => 1,
    :radius => 10,
    :collision_type => :circle,
  }

  def initialize(opts)
    opts = Defaults.merge(opts)
    @mass = opts[:mass]
    @radius = opts[:radius]
    @group = opts[:group]

    moment_of_inertia = CP.moment_for_circle(@mass, @radius,0, ZeroVec2)
    @body = CP::Body.new(@mass, moment_of_inertia)

    @shape = CP::Shape::Circle.new(@body, @radius, ZeroVec2)
    @shape.collision_type = opts[:collision_type]
    @shape.body.p = opts[:location]
   
    @shape.e = opts[:elast]
    @shape.u = opts[:friction]
    @shape.group = @group if @group

    @space = opts[:space]
    @space.add_body(@body)
    @space.add_shape(@shape)
  end

  def cold_drop(loc)
    @body.reset_forces
    @body.p = loc
    @body.a = 0
    @body.w = 0
    @body.v = ZeroVec2
  end
end
