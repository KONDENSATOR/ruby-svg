require 'Classes/shape'
require 'Classes/Modules/positioned'
require 'Classes/Modules/radiused_stereo'
require 'Classes/Modules/sized'

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
