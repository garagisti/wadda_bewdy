require 'rails_helper'

RSpec.describe 'A Round', type: :model do

  subject(:round) { FactoryGirl.build(:valid_round) }

  it {should be_valid}

  context "where all the attributes are empty" do
    let(:round) { Round.new }
    it "should be invalid" do
      expect(round).not_to be_valid
    end
  end

  context "when a valid round exists" do
    it "should a have valid round id, circuit id, qly date time & race date time" do
      expect(round.round_number.nil?).to be_falsey
      expect(round.circuit_id.nil?).to be_falsey
      expect(round.qly_datetime.nil?).to be_falsey
      expect(round.race_datetime.nil?).to be_falsey
    end
  end

  # TODO: Complete this
  context "when a qualyfing is completed" do

    it "should allocate 10 points to a correct guess" do
      # result = qly result
      # user's tips
    end

    it "should allocate 8 points to a guess off by 1" do
    end

    it "should allocate 6 points to a guess off by 2" do
    end

    it "should allocate no points to a guess off by 3 or more" do
    end

  end


end