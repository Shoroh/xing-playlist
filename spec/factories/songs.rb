FactoryGirl.define do
  factory :song do
    title { FFaker::Music.song }
    artist
    album
    track { rand(1..25) }
    year { rand(1950..2017) }
    genre
  end
end
