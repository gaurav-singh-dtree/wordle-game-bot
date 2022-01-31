module Matrix
  class WordleBox
    POSSIBLE_COLORS = %w[red green yellow]
    attr_accessor :current_char, :current_color

    def initialize(c, color)
      @current_char = c
      @current_color = color
    end

    POSSIBLE_COLORS.each do |color|
      define_method "#{color}?".to_sym do
        return true if self.current_color.eql?(color)
        false
      end
    end

    POSSIBLE_COLORS.each do |color|
      define_singleton_method "#{color}".to_sym do
        return color
      end
    end

    def output
      case current_color
      when POSSIBLE_COLORS[0]
        return "🟥"
      when POSSIBLE_COLORS[1]
        return "🟩"
      when POSSIBLE_COLORS[2]
        return "🟨"
      else
        return "🟥"
      end
    end
  end
end
