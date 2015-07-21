class Round < ActiveRecord::Base
  belongs_to :circuit
  has_one :qly_result
  has_one :race_result
end
