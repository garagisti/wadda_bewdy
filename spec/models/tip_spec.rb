require 'rails_helper'

RSpec.describe 'A Tip', type: :model do

  subject(:tip) {Tip.new}

  context "when valid qualy tip are entered" do

    let(:qly_tips) {Tip.new(round_id: 1, qly_tip_1: 1, qly_tip_2: 2, qly_tip_3: 3)}

    it "should have 3 entries" do
      expect(qly_tips.valid_qly_tip?).to be_truthy
    end

    it "is invalid if there are not 3 entries" do
      qly_tips[:qly_tip_3] = ""
      expect(qly_tips.valid_qly_tip?).to be_falsey
    end

    # it "there should be no duplicates" do
      # expect(qly_tips.valid?)
    # end
  end

 context "when an invalid qualy tips are entered" do

  it "duplicate entries are invalid"
  it "less than 3 entries are invalid"
 end
end