class Tip < ActiveRecord::Base

  belongs_to :user
  belongs_to :round


  def valid_qly_tip?
    # check there are 3 entries
    if qly_tip_1.nil? || qly_tip_2.nil? || qly_tip_3.nil? ||
       qly_tip_1.blank? || qly_tip_2.blank? || qly_tip_3.blank?
       false
    else
      true
    end

    # check there are no duplicates
  end

  def valid_race_tip?
  end

end
