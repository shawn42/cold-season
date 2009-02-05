class SvgLoader
  constructor :media_loader

  def get_layer_from_file(filename, layer_name)
    g = @media_loader.load_svg_document(filename).find_group_by_label(layer_name)
    raise "Can't find SVG layer '#{layer_name}'" if g.nil?
    g
  end
end
