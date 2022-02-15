require_relative '../spec_helper'

RSpec.describe "WordFinder" do
  let(:matrix) { WordleMatrix.new("place") }

  context "#next" do
    let(:finder) { WordFinder.new(matrix) }

    it "should return next word" do
      matrix.add_word("magic")
      expect(finder.next).to be
    end

    it "should return random first word" do
      expect(finder.first_word).to be
    end
  end
end