class Circuit < ActiveRecord::Base
  has_many :rounds

  def to_s
    "#{name}"
  end
end
