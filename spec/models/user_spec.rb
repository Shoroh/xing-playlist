require 'rails_helper'

RSpec.describe User, type: :model do
  %i(first_name last_name email user_name).each do |attribute|
    it { should validate_presence_of(attribute) }
  end
end
