require 'date'
Dir[File.expand_path('/Users/gauravsingh/work/dtree/wordle-game-bot/lib/*.rb', __FILE__)].each do |file|
  p file
  require file
end

class WordleGame
  def self.play
    today_word = WordRepo.today_word
    WordlePlayer.start(today_word)
  end
end

# today_word = WordRepo.today_word
# WordlePlayer.start(today_word)
WordleGame.play
