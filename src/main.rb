PROJECT_ROOT_PATH = __dir__
Dir[File.expand_path("#{PROJECT_ROOT_PATH}/../lib/*.rb", __FILE__)].each do |file|
  require file
end

class WordleGame
  def self.play
    today_word = WordRepo.today_word
    WordlePlayer.start(today_word)
  end
end

WordleGame.play
