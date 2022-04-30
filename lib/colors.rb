require_relative './../config/config'

module Colors

  def self.add_color(colors)
    color_map = colors.map do |color|
      case color
      when 'G'
        color.green
      when 'Y'
        color.yellow
      when 'B'
        color.black
      end
    end
    color_map
  end

end

