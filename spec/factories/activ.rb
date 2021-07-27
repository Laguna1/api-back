FactoryBot.define do
  factory :activ do
    sequence(:item) { |n| n.days.ago }
    user
  end
end
