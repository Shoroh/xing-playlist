FactoryGirl.define do
  factory :album do
    name { FFaker::Music.album }
  end
end
