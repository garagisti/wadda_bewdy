class Driver < ActiveRecord::Base
  belongs_to :constructor
  validates_presence_of :name, :number, :constructor_id
end
