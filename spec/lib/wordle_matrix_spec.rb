require_relative '../spec_helper'

RSpec.describe "WorldeMatrix" do
  let(:matrix) { WordleMatrix.new("place") }

  context "#add_word" do
    it "should add a new row" do
      matrix.add_word("magic")
      expect(matrix.wordle_rows.length).to eq(1)
    end

    it "should add 2 rows on on adding 2 words" do
      matrix.add_word("kitte")
      matrix.add_word("might")
      expect(matrix.wordle_rows.length).to eq(2)
    end
  end

  context "#green_matches" do
    it "should return matched chars" do
      matrix = WordleMatrix.new("magic")
      matrix.add_word("might")
      expect(matrix.green_matches.compact).to eq(['m', 'g'])
    end

    it "should not return matched chars" do
      matrix = WordleMatrix.new("magic")
      matrix.add_word("place")
      expect(matrix.green_matches.compact).to eq([])
    end
  end

  context "#red_matches_list" do
    it "should return not matched chars" do
      matrix = WordleMatrix.new("magic")
      matrix.add_word("might")
      expect(matrix.red_matches_list.compact).to eq(['h', 't'])
    end
  end
end
