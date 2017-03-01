class User < ActiveRecord::Base
  paginates_per Rails.env.test? ? 5 : 25

  validates :first_name, :last_name, :email, :user_name, presence: true, length: { maximum: 200 }
  validates :email, :user_name, uniqueness: true

  scope :ordered, -> { User.order(created_at: :desc) }
end
