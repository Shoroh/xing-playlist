class User < ActiveRecord::Base
  validates :first_name, :last_name, :email, :user_name, presence: true
end
