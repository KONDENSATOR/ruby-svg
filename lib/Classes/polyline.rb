require 'Classes/poly'

class Polyline < Poly
  def to_str
    tag('polyline', { :points => points_str })
  end
end
