require 'Classes/shape'

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
