require 'rexml/document'

class SvgRectangleLoader 
  def as_arrays_of_tuples(fname)
    doc = REXML::Document.new(File.read(fname))
    g = REXML::XPath.first(doc.root, "//svg:g")
    raise "Didn't find any 'g' elements in the SVG document #{fname}" unless g
    rect_els = g.get_elements("rect")
    raise "There were no rectangles in the main group of the SVG document #{fname}" if rect_els.empty?
    rect_els.map do |rect_el|
      atts = lambda { |att| rect_el.attributes[att].to_f }

      x = atts['x']
      y = atts['y']
      w = atts['width']
      h = atts['height']

      [
        [x,y],
        [x+w,y],
        [x+w,y+h],
        [x,y+h]
      ]

    end
  end
end
