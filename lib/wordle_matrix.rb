Dir[File.expand_path("#{PROJECT_ROOT_PATH}/../lib/matrix/*.rb", __FILE__)].each do |file|
  require file
end

class WordleMatrix
  attr_accessor :wordle_rows

  def initialize(word)
    @wordle_rows = []
    @correct_word = word
  end

  def add_row(row)
    @wordle_rows << row
  end

  def add_word(word)
    wordle_row = Matrix::WordleRow.new(word.length)
    (0..(@correct_word.length-1)).each do |index|
      if(@correct_word[index] == word[index])
        wordle_row.add_box(word[index], Matrix::WordleBox.green)
      elsif(@correct_word.include?(word[index]))
        wordle_row.add_box(word[index], Matrix::WordleBox.yellow)
      else
        wordle_row.add_box(word[index], Matrix::WordleBox.red)
      end
    end
    add_row(wordle_row)
  end

  def green_matches
    matches = []
    @wordle_rows.last.wordle_boxes.each do |box, index|
      g = nil
      g = box.current_char if box.green?
      matches << g
    end
    matches
  end

  def red_matches_list
    not_matched_list = []
    @wordle_rows.each do |row|
      not_matched_list << row.red_chars
    end
    not_matched_list.flatten.uniq
  end

  def yellow_matches_list
    possible_matched_list = []
    @wordle_rows.each do |row|
      possible_matched_list << row.yellow_chars
    end
    possible_matched_list.flatten.uniq
  end

  def output
    matched_output = []
    @wordle_rows.each do |row|
      matched_output << row.output
    end
    matched_output.join
  end
end
