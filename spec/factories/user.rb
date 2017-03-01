FactoryGirl.define do
  factory :user do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    user_name { "#{first_name}_#{last_name}".downcase }
    email { FFaker::Internet.free_email("#{first_name}.#{last_name}") }
  end
end
