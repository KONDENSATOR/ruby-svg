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
