require 'Classes/shape'
require 'Classes/Modules/positioned'
require 'Classes/Modules/radiused_stereo'

class Ellipse < Shape
  include Positioned
  include RadiusedStereo
  
  def to_s
    tag('ellipse', { :cx => @x, :cy => @y, :rx => @radius_x, :ry => @radius_y })
  end
end
