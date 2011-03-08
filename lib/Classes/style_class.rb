require 'Classes/core_object'

class StyleClass < CoreObject
  # http://www.w3.org/TR/SVG/painting.html#SpecifyingPaint
      
  def color_interpolation(val)
    @styles << "color-interpolation:#{val}"
  end
  def color_interpolation_filters(val)
    @styles << "color-interpolation_filters:#{val}"
  end
  def color_profile(val)
    @styles << "color-profile:#{val}"
  end
  def color_rendering(val)
    @styles << "color-rendering:#{val}"
  end
  
  def fill(val)
    @styles << "fill:#{val}"
  end
  def fill_rule(val)
    @styles << "fill-rule:#{val}"
  end
  def fill_opacity(val)
    @styles << "fill:#{val}"
  end
  
  def stroke(val)
    @styles << "stroke:#{val}"
  end
  def stroke_width(val)
    @styles << "stroke-width:#{val}"
  end
  def stroke_linecap(val)
    @styles << "stroke-linecap:#{val}"
  end
  def stroke_linejoin(val)
    @styles << "stroke-linejoin:#{val}"
  end
  def stroke_miterlimit(val)
    @styles << "stroke-miterlimit:#{val}"
  end
  def stroke_dasharray(val)
    @styles << "stroke-dasharray:#{val}"
  end
  def stroke_dashoffset(val)
    @styles << "stroke-dashoffset:#{val}"
  end
  def stroke_opacity(val)
    @styles << "stroke-opacity:#{val}"
  end
  
  def display(val)
    @styles << "display:#{val}"
  end
  def visibility(val)
    @styles << "visibility:#{val}"
  end
  
  def custom(name, val)
    @styles << "#{name}:#{val}"
  end
  
  def to_s
    s = "#{@id} {\n"
    s << "  #{@styles.join(';')}\n"
    s << "}\n"
    return s
  end
  def initialize()
    @styles = []
  end
end