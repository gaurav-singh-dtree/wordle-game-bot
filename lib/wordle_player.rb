class WordlePlayer
  attr_accessor :possible_matches, :wordle_matrix, :max_attempts, :current_attempt_count

  def initialize(word)
    @max_attempts = word.length + 1
    @current_attempt_count = 1
    @wordle_matrix = WordleMatrix.new(word)
    @wordle_matrix.add_word(first_word)
    @possible_matches = WordRepo.all_words
  end

  def next_word
    filter_for_green
    filter_for_red
    filter_for_yellow
    possible_matches[rand(possible_matches.length)]
  end

  def increment_attempt
    self.current_attempt_count = self.current_attempt_count + 1
  end

  def should_guess_next_word?
    return false if (self.current_attempt_count >= self.max_attempts)
    return false if self.words_macthed?
    true
  end

  def self.start(word)
    wordle_player = self.new(word)

    while(wordle_player.should_guess_next_word?) do
      wordle_player.increment_attempt
      wordle_player.wordle_matrix.add_word(wordle_player.next_word)
    end
    TwitterResults.publish(format_output(wordle_player))
  end

  private

  def self.format_output(wordle_player)
    "#Wordle #{WordRepo.wordle_day} #{wordle_player.current_attempt_count}/#{wordle_player.max_attempts} \n#{wordle_player.wordle_matrix.output}"
  end

  def first_word
    random_matches = WordRepo.all_words.filter do |word|
      !(word =~ Commons::MATCHING_REGEX).nil?
    end
    return random_matches[rand(random_matches.length)]
  end

  def words_macthed?
    wordle_matrix.wordle_rows.last.green?
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
    self.possible_matches = self.possible_matches.filter { |word| !(word =~ /#{build_regex_for_position}/).nil? }
  end

  def filter_for_yellow
    self.possible_matches = self.possible_matches.filter do |word|
      wordle_matrix.yellow_matches_list.all? { |possible_char| word.include?(possible_char)}
    end
  end

  def filter_for_red
    self.possible_matches = self.possible_matches.filter do |word|
      !wordle_matrix.red_matches_list.any? { |possible_char| word.include?(possible_char)}
    end
  end
end
