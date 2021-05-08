FactoryBot.define do
  factory :activity do
    name { Faker::Lorem.word }
    place { Faker::Lorem.word }
    intensity { Faker::Lorem.word }
    user
  end
end
