FactoryGirl.define do
  factory :artist do
    name { FFaker::Music.artist }
  end
end
