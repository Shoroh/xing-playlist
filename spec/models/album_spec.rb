require 'rails_helper'

RSpec.describe Album, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_most(200) }
end
