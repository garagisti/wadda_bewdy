class QlyResult < ActiveRecord::Base
  belongs_to :round
  has_many :drivers
  validates_presence_of :round_id, :qly_result_1, :qly_result_2, :qly_result_3

  def to_s
    Driver.where(id: qly_result_1).first
  end

end
