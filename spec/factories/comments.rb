FactoryBot.define do
  factory :comment do
    text { Faker::Lorem.paragraph }

    transient do
      user { nil }
    end

    after(:build) do |comment, evaluator|
      comment.user = evaluator.user || create(:user)
    end
  end
end
