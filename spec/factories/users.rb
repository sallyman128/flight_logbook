FactoryBot.define do
  factory :user do
    email_address { Faker::Internet.unique.email }
    password { Faker::Internet.password(min_length: 12) }
  end
end
