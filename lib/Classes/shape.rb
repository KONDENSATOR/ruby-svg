require 'Classes/core_object'

class Shape < CoreObject
  attr_accessor :style_class
  attr_accessor :expand_style_class
  attr_accessor :transform
  
  def transform_str
    return "transform='#{@transform.to_s}'" if @transform
    ""
  end
  def style_str
    return "style='#{@style_class.to_s}'" if @style_class and @expand_style_class
    return "class='#{@style_class}'" if @style_class and not @expand_style_class
    ""
  end
  def flatten_attribs(attribs)
    result = ""
    attribs.each_pair do |key, value|
      result << "#{key}='#{value}' " if value
    end
    return result
  end
  def tag(name, attribs)
    "<#{name} id='#{@id}' #{flatten_attribs(attribs)} #{style_str} #{transform_str} />"
  end
end
