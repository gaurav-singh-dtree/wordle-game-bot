module Matrix
  class WordleRow
    attr_accessor :wordle_boxes

    def initialize(row_length)
      @row_length = row_length
      @wordle_boxes = []
    end

    def add_box(c, color)
      @wordle_boxes << WordleBox.new(c, color) if (@row_length > @wordle_boxes.length)
    end

    def green?
      return true if ((@wordle_boxes.length > 0) && @wordle_boxes.all? { |box| box.green? })
      false
    end

    def red_chars
      not_matched_list = []
      @wordle_boxes.each do |box|
        not_matched_list << box.current_char if box.red?
      end
      not_matched_list.uniq
    end

    def yellow_chars
      possible_matches_list = []
      @wordle_boxes.each do |box|
        possible_matches_list << box.current_char if box.yellow?
      end
      possible_matches_list.uniq
    end

    def output
      matched_output = []
      @wordle_boxes.each do |box|
        matched_output << box.output
      end
      matched_output.join+"\n"
    end
  end
end
