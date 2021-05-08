FactoryBot.define do
  factory :tracking do
    date { Faker::Date.between(from: '2021-05-08', to: '2022-05-08') }
    distance { Faker::Number.number(digits: 4) }
    rate { Faker::Lorem.word }
    activity
  end
end
