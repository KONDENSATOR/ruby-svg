require 'Classes/shape'

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
