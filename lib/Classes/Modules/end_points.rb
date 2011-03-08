module EndPoints
  def x1(v)
    @x1 = v
  end
  def y1(v)
    @y1 = v
  end
  def x2(v)
    @x2 = v
  end
  def y2(v)
    @y2 = v
  end
  def point1(x,y)
    @x1, @y1 = x, y
  end
  def point2(x,y)
    @x2, @y2 = x, y
  end
  def rect(x1, y1, x2, y2)
    @x1, @y1 = x1, y1
    @x2, @y2 = x2, y2
  end
end
