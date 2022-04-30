require_relative './../config/config'

module Colors

  def self.add_color(colors)
    color_map = colors.map do |color|
      case color
      when 'G'
        ' '.on_green
      when 'Y'
        ' '.on_yellow
      when 'B'
        ' '.on_black
      end
    end
    color_map
  end

end

