require 'rails_helper'

RSpec.describe User, type: :model do
  %i(first_name last_name email user_name).each do |attribute|
    it { should validate_presence_of(attribute) }
    it { should validate_length_of(attribute).is_at_most(200) }
  end

  it { should validate_uniqueness_of(:email) }
  it { should validate_uniqueness_of(:user_name) }
end
