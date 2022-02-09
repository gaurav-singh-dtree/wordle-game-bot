class WordlePlayer
  attr_accessor :wordle_matrix, :max_attempts, :current_attempt_count

  def initialize(word)
    @max_attempts = word.length + 1
    @current_attempt_count = 1
    @wordle_matrix = WordleMatrix.new(word)
    @finder = WordFinder.new(wordle_matrix)
    @wordle_matrix.add_word(@finder.first_word)
  end

  def play_more?
    return false if (self.current_attempt_count >= self.max_attempts)
    return false if self.words_macthed?
    true
  end

  def play
    increment_attempt
    wordle_matrix.add_word(next_word)
  end

  def self.start(word)
    wordle_player = self.new(word)

    while(wordle_player.play_more?) do
      wordle_player.play
    end
    TwitterResults.publish(format_output(wordle_player))
  end

  private

  def next_word
    @finder.next
  end

  def increment_attempt
    self.current_attempt_count = self.current_attempt_count + 1
  end

  def self.format_output(wordle_player)
    "#Wordle #{WordRepo.wordle_day} #{wordle_player.current_attempt_count}/#{wordle_player.max_attempts} \n#{wordle_player.wordle_matrix.output}"
  end

  def words_macthed?
    wordle_matrix.wordle_rows.last.green?
  end
end
