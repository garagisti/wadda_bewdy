class Driver < ActiveRecord::Base
  belongs_to :constructor
  has_many :race_results
  validates_presence_of :name, :number, :constructor_id

  def to_s
    "#{name}"
  end
end
