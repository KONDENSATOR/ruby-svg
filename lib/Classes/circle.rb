require 'Classes/shape'
require 'Classes/Modules/positioned'
require 'Classes/Modules/radiused_mono'

class Circle < Shape
  include Positioned
  include RadiusedMono
  
  def to_s
    tag('circle', { :cx => @x, :cy => @y, :r => @radius })
  end
end
