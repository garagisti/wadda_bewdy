class QlyResult < ActiveRecord::Base
  belongs_to :round
  validates_presence_of :qly_result_1, :qly_result_2, :qly_result_3

end
