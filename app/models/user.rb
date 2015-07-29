class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tips


  def has_tipped?(round_id)
    !Tip.where("user_id = ? AND round_id = ?",id,round_id).first.nil?
  end

end
