class RaceResult < ActiveRecord::Base
  belongs_to :round
  has_many :drivers
  validates_presence_of :round_id, :race_result_1, :race_result_2,
                        :race_result_3, :race_result_4, :race_result_5,
                        :race_result_6, :race_result_7, :race_result_8,
                        :race_result_9, :race_result_10

  def winner
    Driver.find_by_id(race_result_1)
  end

end
