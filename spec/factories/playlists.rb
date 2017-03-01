FactoryGirl.define do
  factory :playlist do
    name { FFaker::Music.song }
    user
  end
end
