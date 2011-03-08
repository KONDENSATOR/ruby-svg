require 'Classes/shape'
require 'Classes/Modules/end_points'

class Line < Shape
  include EndPoints
  
  def to_s
    tag('line', { :x1 => @x1, :y1 => @y1, :x2 => @x2, :y2 => @y2 })
  end
end
