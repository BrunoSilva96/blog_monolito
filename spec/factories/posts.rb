FactoryBot.define do
  factory :post do
    text { Faker::Lorem.paragraph }
  end
end
