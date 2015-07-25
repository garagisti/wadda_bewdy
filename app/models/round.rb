class Round < ActiveRecord::Base
  belongs_to :circuit
  has_one :qly_result
  has_one :race_result

  validates_presence_of :round_number, :circuit_id, :qly_datetime, :race_datetime

  # Is the current round on?
  def is_current?
    race_datetime > (DateTime.current - 1.hour) &&
    !(race_datetime > (DateTime.current + 1.week))
  end

end
