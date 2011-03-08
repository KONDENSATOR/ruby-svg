class Svg
private
  class CoreObject
    attr_accessor :id
  end
  class Transform
    def to_s
    end
  end
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
  class Shape < CoreObject
    attr_accessor :style_class
    attr_accessor :expand_style_class
    attr_accessor :transform
    
    def transform_str
      return "transform='#{@transform.to_s}'" if @transform
      ""
    end
    def style_str
      return "style='#{@style_class.to_s}'" if @style_class and @expand_style_class
      return "class='#{@style_class}'" if @style_class and not @expand_style_class
      ""
    end
    def flatten_attribs(attribs)
      result = ""
      attribs.each_pair do |key, value|
        result << "#{key}='#{value}' " if value
      end
      return result
    end
    def tag(name, attribs)
      "<#{name} id='#{@id}' #{flatten_attribs(attribs)} #{style_str} #{transform_str} />"
    end
  end
  class Path < Shape
    # http://apike.ca/prog_svg_paths.html
    
  private
    def d_str()
      @cmd.join("")
    end
        
  public
    # Moves the pen to a new location. No line is drawn. All path data must begin 
    # with a 'moveto' command.
    def moveto(x,y)
      @cmd << "M#{x} #{y}"
    end
    # Draws a line from the current point to the point (x,y). 
    def lineto(x,y)
      @cmd << "L#{x} #{y}"
    end
    # Draws a horizontal line from the current point to x.
    def horizontal_lineto(x)
      @cmd << "H#{x}"
    end
    # Draws a vertical line from the current point to y.
    def vertical_lineto(y)
      @cmd << "V#{y}"
    end
    # Draw a cubic bezier curve to the point (x,y) where the points (x1,y1) and 
    # (x2,y2) are the start and end control points, respectively.
    def curveto(x1, y1, x2, y2, x, y)
      @cmd << "C#{x1} #{y1} {x2} #{y2} {x} #{y}"
    end
    # Draw a curve to the point (x,y) where the point (x2,y2) is the end control 
    # point and the start control point is the reflection of the last point's end 
    # control point.
    def smooth_curveto(x2, y2, x, y)
      @cmd << "S#{x2} #{y2} {x} #{y}"
    end
    # Draw a quadratic bezier between the last point and point (x,y) using the
    # point (x1,y1) as the control point.
    def quadratic_bezier_curveto(x1, y1, x, y)
      @cmd << "Q#{x} #{y}"
    end
    # Draw a quadratic bezier between the last point and point (x,y) using the 
    # reflection of the last control point as the control point.
    def smooth_quadratic_bezier_curveto(x, y)
      @cmd << "T#{x} #{y}"
    end
    # Draws and arc from the current point to x, y. The actual scale factor and
    # position of the arc needed to bridge the two points is computed by the SVG 
    # viewer.
    # rx ry x-axis-rotation large-arc-flag sweep-flag x y
    # def elliptical_arc(x, y)
    # end
    # Closes the path. A line is drawn from the last point to the first.
    def closepath
      @cmd << "Z"
    end
    
    def to_s
      tag('path', { :d => d_str() })
    end
    
    def initialize()
      @cmd = []
    end
  end
  
  module Positioned
    def x(v)
      @x = v
    end
    def y(v)
      @y = v
    end
    def point(x,y)
      @x, @y = x, y
    end
  end
  module Sized
    def width(v)
      @width = v
    end
    def height(v)
      @height = v
    end
    def size(width,height)
      @width = width
      @height = height
    end
  end
  module RadiusedStereo
    def rx(v)
      @radius_x = v
    end
    def ry(v)
      @radius_y = v
    end
    def r(x,y)
      @radius_x = x
      @radius_y = y
    end
  end
  module RadiusedMono
    def r(v)
      @radius = v
    end
  end
  module EndPoints
    def x1(v)
      @x1 = v
    end
    def y1(v)
      @y1 = v
    end
    def x2(v)
      @x2 = v
    end
    def y2(v)
      @y2 = v
    end
    def point1(x,y)
      @x1, @y1 = x, y
    end
    def point2(x,y)
      @x2, @y2 = x, y
    end
    def rect(x1, y1, x2, y2)
      @x1, @y1 = x1, y1
      @x2, @y2 = x2, y2
    end
  end

  class Rect < Shape
    include Positioned
    include Sized
    include RadiusedStereo
        
    def to_s
      radius = ""
      radius = "rx='#{@rx}' ry='#{@ry}'" if @rx or @ry
      
      tag('rect', {:x => @x, :y => @y, :width => @width, :height => @height, :rx => @rx, :ry => @ry })
    end
  end
  class Circle < Shape
    include Positioned
    include RadiusedMono
    
    def to_s
      tag('circle', { :cx => @x, :cy => @y, :r => @radius })
    end
  end
  class Ellipse < Shape
    include Positioned
    include RadiusedStereo
    
    def to_s
      tag('ellipse', { :cx => @x, :cy => @y, :rx => @radius_x, :ry => @radius_y })
    end
  end
  class Line < Shape
    include EndPoints
    
    def to_s
      tag('line', { :x1 => @x1, :y1 => @y1, :x2 => @x2, :y2 => @y2 })
    end
  end
  class Poly < Shape
    def point(x, y)
      points << "#{x},#{y}"
    end
    def initialize()
      points = []
    end
    def points_str()
      points.join(' ')
    end
  end
  class Polyline < Poly
    def to_str
      tag('polyline', { :points => points_str })
    end
  end
  class Polygon < Poly
    def to_str
      tag('polygon', { :points => points_str })
    end
  end
  
  def style_classes_str
    result = ""
    @style_classes.each do |style_class|
      result << style_class.to_s
    end
    return result
  end
  def style_str
    style = "  <style type='text/css'><![CDATA[\n"
    style << "  #{style_classes_str()}\n"
    style << "  ]]></style>\n"
  end
  def defs_str
    defs = "<defs>\n"
    defs << " #{style_str()}\n"
    defs << "</defs>\n"
  end
  def prims_str()
    result = ""
    @prims.each do |prim|
      result << prim.to_s
    end
    return result
  end
  def doc_str()
    doc = "<?xml version='1.0' standalone='no'?>\n"
    doc << "<!DOCTYPE svg PUBLIC '-//W3C//DTD SVG 1.1//EN' 'http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd'>\n" 
    doc << "<svg width='#{@width}' height='#{@height}' version='1.1' xmlns='http://www.w3.org/2000/svg'>\n"
    doc << "#{defs_str()}\n"
    doc << "#{prims_str()}\n"
    doc << "</svg>\n"
    return doc
  end

public
  def to_s()
    doc_str()
  end
  def write(file_name)
    File.open(file_name, 'w') do |f|
      f.puts to_s()
    end
  end
  
  def inc_id_counter
    @id_counter += 1
  end
  
  def class(id = "id#{inc_id_counter}")
    p = StyleClass.new()
    p.id = id
    yield p
    @style_classes << p
  end
  def path(id = "id#{inc_id_counter}")
    p = Path.new()
    p.id = id
    yield p
    @prims << p
  end
  def rect(id = "id#{inc_id_counter}")
    p = Rect.new()
    p.id = id
    yield p
    @prims << p
  end
  def circle(id = "id#{inc_id_counter}")
    p = Circle.new()
    p.id = id
    yield p
    @prims << p
  end
  def ellipse(id = "id#{inc_id_counter}")
    p = Ellipse.new()
    p.id = id
    yield p
    @prims << p
  end
  def line(id = "id#{inc_id_counter}")
    p = Line.new()
    p.id = id
    yield p
    @prims << p
  end
  def polyline(id = "id#{inc_id_counter}")
    p = Polyline.new()
    p.id = id
    yield p
    @prims << p
  end
  def polygon(id = "id#{inc_id_counter}")
    p = Polygon.new()
    p.id = id
    yield p
    @prims << p
  end
  
  def initialize(width = '100%', height = '100%')
    @width, @height = width, height
    @style_classes = []
    @prims = []
    @id_counter = 0
  end
end