require 'plist'

def conv_color_component(fval)
  ( 255.0 * fval ) .to_i
end

def conv_color(node)
  r = conv_color_component(node['Red Component'])
  g = conv_color_component(node['Green Component'])
  b = conv_color_component(node['Blue Component'])
  "#{r},#{g},#{b}"
end

COLOUR_MAP = {
  'Ansi 0 Color' => [6],
  'Ansi 1 Color' => [8],
  'Ansi 2 Color' => [10],
  'Ansi 3 Color' => [12],
  'Ansi 4 Color' => [14],
  'Ansi 5 Color' => [16],
  'Ansi 6 Color' => [18],
  'Ansi 7 Color' => [20],
  'Ansi 8 Color' => [7],
  'Ansi 9 Color' => [9],
  'Ansi 10 Color' => [11],
  'Ansi 11 Color' => [13],
  'Ansi 12 Color' => [15],
  'Ansi 13 Color' => [17],
  'Ansi 14 Color' => [19],
  'Ansi 15 Color' => [21],
  'Background Color' => [2,3],
  'Bold Color' => [1],
  'Cursor Color' => [5],
  'Cursor Text Color' => [4],
  'Foreground Color' => [0],
  #'Selected Text Color' => [4],
  #'Selection Color' => [5'
}

result={}

Plist::parse_xml(ARGF).each do |key, value|
  if COLOUR_MAP.key?(key)
    COLOUR_MAP[key].each do |number|
      result[number] = conv_color(value)
    end
  end
end

result.sort.each { |k,v|  puts "Colour#{k}=\"#{v}\"" }