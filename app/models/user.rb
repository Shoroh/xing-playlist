class User < ActiveRecord::Base
  validates :first_name, :last_name, :email, :user_name, presence: true, length: { maximum: 200 }
  validates :email, :user_name, uniqueness: true
end
