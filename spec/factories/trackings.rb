FactoryBot.define do
  factory :tracking do
    activity
    name { 'Name' }
    distance { 100 }
    duration { 30 }
    repeats { 2 }
  end
end
