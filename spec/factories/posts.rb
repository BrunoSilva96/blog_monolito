FactoryBot.define do
  factory :post do
    text { Faker::Lorem.paragraph }

    transient do
      user { nil }
    end

    after(:build) do |post, evaluator|
      post.user = evaluator.user || create(:user)
    end
  end
end
