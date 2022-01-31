class WordRepo
  def self.all_words
    @all_words ||= File.read("/Users/gauravsingh/work/dtree/wordle-game-bot/data/words.txt").split(',').map(&:strip)
  end

  def self.today_word
    base_word_index = all_words.index(Commons::BASE_WORD)
    day_difference_from_base_day = (Date.today - Commons::BASE_DAY).to_i
    # Check if all words have finished
    all_words[base_word_index + day_difference_from_base_day]
  end
end
