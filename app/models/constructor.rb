class Constructor < ActiveRecord::Base
  has_many :drivers
  validates_presence_of :name, :engine
end
