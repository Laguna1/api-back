FactoryBot.define do
  factory :tracking do
    name { 'Name' }
    distance { 100 }
    duration { 30 }
    repeats { 2 }
    activity
  end
end
