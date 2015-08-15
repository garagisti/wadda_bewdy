require 'rails_helper'

RSpec.describe 'A Tip', type: :model do

  subject(:tip) {Tip.new}

  context "when valid qualy tips are entered" do

    let(:qly_tips) {Tip.new(round_id: 1, qly_tip_1: 1, qly_tip_2: 2, qly_tip_3: 3)}

    it "should have 3 entries" do
      expect(qly_tips.valid_qly_tip?).to be_truthy
    end

    it "there should be no duplicates" do
      expect(qly_tips.valid_qly_tip?).to be_truthy
    end
  end

  context "when invalid qualy tips are entered" do

    let(:qly_tips) {Tip.new(round_id: 1, qly_tip_1: 1, qly_tip_2: nil, qly_tip_3: '')}

    it "is invalid if there are not 3 entries" do
      expect(qly_tips.valid_qly_tip?).to be_falsey
    end

    it "is invalid if there are duplicate tips" do
      qly_tips.qly_tip_1 = 2
      qly_tips.qly_tip_2 = 2
      qly_tips.qly_tip_3 = 2
      expect(qly_tips.valid_qly_tip?).to be_falsey
    end
  end

  context "when valid race tips are entered" do

    let(:qly_tips) {Tip.new(round_id: 1, race_tip_1: 1, race_tip_2: 2, race_tip_3: 3,
                            race_tip_4: 4, race_tip_5: 5, race_tip_6: 6, race_tip_7: 7,
                            race_tip_8: 8, race_tip_9: 9, race_tip_10:10)}

    it "should have 10 entries"
    it "there should be no duplicates"
  end

end