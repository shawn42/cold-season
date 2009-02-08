class SvgLoader
  constructor :resource_manager

  def get_layer_from_file(filename, layer_name)
    g = @resource_manager.load_svg(filename).find_group_by_label(layer_name)
    raise "Can't find SVG layer '#{layer_name}'" if g.nil?
    g
  end
end
