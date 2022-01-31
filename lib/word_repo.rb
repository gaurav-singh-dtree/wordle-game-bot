class WordRepo
  def self.all_words
    @all_words ||= File.read("/Users/gauravsingh/work/dtree/wordle-game-bot/data/words.txt").split(',').map(&:strip)
  end

  def self.base_word_index
    all_words.index(Commons::BASE_WORD)
  end

  def self.calculate_days_difference
    (Date.today - Commons::BASE_DAY).to_i
  end

  def self.today_word
    all_words[base_word_index + calculate_days_difference]
  end
end
