class Constructor < ActiveRecord::Base
  has_many :drivers
  validates_presence_of :ergast_constructor_code, :name, :nationality
end
