require 'rails_helper'

RSpec.describe Song, type: :model do
  %i(title artist album genre).each do |attribute|
    it { should validate_presence_of(attribute) }
  end
end
