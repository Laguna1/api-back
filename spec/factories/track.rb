FactoryBot.define do
  factory :track do
    activ
    name { 'Name' }
    distance { 100 }
    duration { 30 }
    repeat { 2 }
  end
end
