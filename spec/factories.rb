FactoryBot.define do
  factory :merchant do
    name { Faker::Restaurant.name }
  end

  factory :item do
    name { Faker::Hipster.word }
    description { Faker::Hipster.sentence }
    unit_price { Faker::Number.decimal(l_digits: 2) }
    # merchant_id 
  end
end
