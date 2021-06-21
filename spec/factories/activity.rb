FactoryBot.define do
  factory :activity do
    sequence(:item) { |n| n.days.ago }
  end
end
