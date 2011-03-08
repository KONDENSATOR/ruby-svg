require 'Classes/poly'

class Polygon < Poly
  def to_str
    tag('polygon', { :points => points_str })
  end
end
