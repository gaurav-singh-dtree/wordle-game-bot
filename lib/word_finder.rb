class WordFinder
  attr_accessor :wordle_matrix, :words_list

  def initialize(wordle_matrix)
    @words_list = WordRepo.all_words
    @wordle_matrix = wordle_matrix
  end

  def next
    filter_for_green
    filter_for_red
    filter_for_yellow
    words_list[rand(words_list.length)]
  end

  def first_word
    random_matches = words_list.filter do |word|
      !(word =~ Commons::MATCHING_REGEX).nil?
    end
    return random_matches[rand(random_matches.length)]
  end

  def build_regex_for_position
    l = []
    position_matched_chars = wordle_matrix.green_matches
    position_matched_chars.each do |char|
      if char.nil?
        l << "[a-z]{1}"
      else
        l << "#{char}{1}"
      end
    end
    l.join
  end

  def filter_for_green
    self.words_list = words_list.filter { |word| !(word =~ /#{build_regex_for_position}/).nil? }
  end

  def filter_for_yellow
    self.words_list = words_list.filter do |word|
      wordle_matrix.yellow_matches_list.all? { |possible_char| word.include?(possible_char)}
    end
  end

  def filter_for_red
    self.words_list = words_list.filter do |word|
      !wordle_matrix.red_matches_list.any? { |possible_char| word.include?(possible_char)}
    end
  end
end
