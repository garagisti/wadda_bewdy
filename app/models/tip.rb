class Tip < ActiveRecord::Base

  belongs_to :user
  belongs_to :round


  def valid_qly_tip?
    # Assume tip is valid to begin with
    validity = true

    # check there are 3 entries
    if qly_tip_1.nil? || qly_tip_2.nil? || qly_tip_3.nil? ||
       qly_tip_1.blank? || qly_tip_2.blank? || qly_tip_3.blank?
       validity = false

    # check there are no duplicates
    elsif qly_tip_1 == qly_tip_2 ||
          qly_tip_1 == qly_tip_3 ||
          qly_tip_2 == qly_tip_3
      validity = false
    end
    validity
  end

  def valid_race_tip?
    # Check there are 10 entries

    # check there are no duplicates


  end

end
