require 'Classes/style_class'
require 'Classes/path'
require 'Classes/rect'
require 'Classes/circle'
require 'Classes/ellipse'
require 'Classes/line'
require 'Classes/polyline'
require 'Classes/polygon'

class Svg
private  
  def style_classes_str
    result = ""
    @style_classes.each do |style_class|
      result << style_class.to_s
    end
    return result
  end
  def style_str
    style = "  <style type='text/css'><![CDATA[\n"
    style << "  #{style_classes_str()}\n"
    style << "  ]]></style>\n"
  end
  def defs_str
    defs = "<defs>\n"
    defs << " #{style_str()}\n"
    defs << "</defs>\n"
  end
  def prims_str()
    result = ""
    @prims.each do |prim|
      result << prim.to_s
    end
    return result
  end
  def doc_str()
    doc = "<?xml version='1.0' standalone='no'?>\n"
    doc << "<!DOCTYPE svg PUBLIC '-//W3C//DTD SVG 1.1//EN' 'http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd'>\n" 
    doc << "<svg width='#{@width}' height='#{@height}' version='1.1' xmlns='http://www.w3.org/2000/svg'>\n"
    doc << "#{defs_str()}\n"
    doc << "#{prims_str()}\n"
    doc << "</svg>\n"
    return doc
  end

public
  def to_s()
    doc_str()
  end
  def write(file_name)
    File.open(file_name, 'w') do |f|
      f.puts to_s()
    end
  end
  
  def inc_id_counter
    @id_counter += 1
  end
  
  def class(id = "id#{inc_id_counter}")
    p = StyleClass.new()
    p.id = id
    yield p
    @style_classes << p
  end
  def path(id = "id#{inc_id_counter}")
    p = Path.new()
    p.id = id
    yield p
    @prims << p
  end
  def rect(id = "id#{inc_id_counter}")
    p = Rect.new()
    p.id = id
    yield p
    @prims << p
  end
  def circle(id = "id#{inc_id_counter}")
    p = Circle.new()
    p.id = id
    yield p
    @prims << p
  end
  def ellipse(id = "id#{inc_id_counter}")
    p = Ellipse.new()
    p.id = id
    yield p
    @prims << p
  end
  def line(id = "id#{inc_id_counter}")
    p = Line.new()
    p.id = id
    yield p
    @prims << p
  end
  def polyline(id = "id#{inc_id_counter}")
    p = Polyline.new()
    p.id = id
    yield p
    @prims << p
  end
  def polygon(id = "id#{inc_id_counter}")
    p = Polygon.new()
    p.id = id
    yield p
    @prims << p
  end
  
  def initialize(width = '100%', height = '100%')
    @width, @height = width, height
    @style_classes = []
    @prims = []
    @id_counter = 0
  end
end
