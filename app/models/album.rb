class Album < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 200 }
end
