require_relative '../spec_helper'

RSpec.describe "WordleRepo" do

  context "#today_word" do
    it "should not be nil" do
      expect(WordRepo.today_word).not_to be_nil
    end
  end

  context "#base_word_index" do
    it "should be greater than zero" do
      expect(WordRepo.base_word_index > 0).to be_truthy
    end
  end
end
