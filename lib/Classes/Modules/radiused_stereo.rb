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
